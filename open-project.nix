{ pkgs }: {
  pkgs.writeShellApplication = {
    name = "open-project";

    runtimeInputs = [ tmux neovim bash ];

    text = ''
      open_project() {
          if [ -z "$1" ]; then
              echo "No destination given"
              return 1
          fi
          if [ -n "$TMUX" ]; then
              echo "Already inside a TMUX session."
              return 1
          fi
          if [ ! -d "$1" ]; then
              echo "Path does not exist or is no directory."
              return 1
          fi

          dir="$1"
          name=$(basename "$dir")
          if [ -n "$2" ]; then
              name="$2"
          fi

          [[ $(tmux attach-session -t "$name" 2>/dev/null ) ]] && { return }

          cd "$dir"
          tmux new-session -d -s "$name"

          tmux rename-window -t "$name" "nvim"
          tmux send-keys -t "$name" "nvim ." C-m

          tmux new-window -t "$name"
          tmux rename-window -t "$name" "bash"

          tmux attach-session -t "$name"
      }
    '';
  }
}
