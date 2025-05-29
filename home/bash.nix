{ ... }: {
  programs.bash = {
    enable = true;
    enableCompletion = true;
    historySize = 1000000;
    historyFileSize = 1000000;

    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/.cargo/bin"

      view_pdf() {
          if [ -z "$1" ]; then
              echo "No file given"
              return 1
          fi
          nohup evince $1 > /dev/null 2>&1 &
      }

      git_quick_add() {
          for f in $(git ls-files --modified --exclude-standard --others)
          do
              git add $f; git commit --sign --message "feat($(dirname $f)): add $(basename $f)"
          done
      }

      cp_latest_screenshot() {
          if [ -z "$1" ]; then
              echo "No destination given"
              return 1
          fi
          cp "$(ls -t $(xdg-user-dir PICTURES)/Screenshots/* | head -n 1)" $1
      }

      mv_latest_screenshot() {
          if [ -z "$1" ]; then
              echo "No destination given"
              return 1
          fi
          mv "$(ls -t $(xdg-user-dir PICTURES)/Screenshots/* | head -n 1)" $1
      }

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

          if [[ $(tmux attach-session -t "$name" 2>/dev/null ) ]]; then
              return 0
          fi

          cd "$dir"
          tmux new-session -d -s "$name"

          tmux rename-window -t "$name" "nvim"
          tmux send-keys -t "$name" "nvim ." C-m

          tmux new-window -t "$name"
          tmux rename-window -t "$name" "bash"

          tmux attach-session -t "$name"
      }
    '';

    # set some aliases, feel free to add more or remove some
    shellAliases = {
      v = "nvim";
      g = "git";
      t = "tmux";
      e = "eza";
      c = "cargo";
      m = "aerc";
      z = "zig";
      o = "open_project";
      x = "exit";
      gitgraph="git log --graph --oneline --all --decorate";
      urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
      urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
      recmd5 = "/home/sandro/projects/recmd5/recmd5.sh";
      yubipi = "curl -k https://yubipi.gierens.de -H \"X-Auth-Token: $(pass yubipi)\" 2>/dev/null | jq -r .otp | xclip";
    };
  };
}
