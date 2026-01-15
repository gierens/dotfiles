{
  programs.zwift = {
    # Enable the zwift module and install required dependencies
    enable = true;
    # The Docker image to use for zwift
    image = "docker.io/netbrain/zwift";
    # The zwift game version to run
    version = "1.104.4";
    # Container tool to run zwift (e.g., "podman" or "docker")
    containerTool = "docker";
    # If true, do not pull the image (use locally cached image)
    dontPull = false;
    # If true, skip new version check
    dontCheck = false;
    # If true, print the container run command and exit
    dryRun = false;
    # If set, launch container with "-it --entrypoint bash" for debugging
    interactive = false;
    # Extra args passed to docker/podman (e.g. "--cpus=1.5")
    containerExtraArgs = "";
    # Zwift account username (email address)
    zwiftUsername = "sandro@gierens.de";
    # Zwift account password

    # NOTE: set actual password before first run.
    # zwiftPassword = "xxxx";

    # NOTE: don't forget to create all these directories before first run.
    # Directory to store zwift workout files
    zwiftWorkoutDir = "/var/lib/zwift/workouts";
    # Directory to store zwift activity files
    zwiftActivityDir = "/var/lib/zwift/activities";
    # Directory to store zwift log files
    zwiftLogDir = "/var/lib/zwift/logs";
    # Directory to store zwift screenshots
    zwiftScreenshotsDir = "/var/lib/zwift/screenshots";

    # Run zwift in the foreground (set true for foreground mode)
    zwiftFg = false;
    # Disable Linux GameMode if true
    zwiftNoGameMode = false;
    # Enable Wine's experimental Wayland support if using Wayland
    wineExperimentalWayland = true;
    # Networking mode for the container ("bridge" is default)
    networking = "bridge";
    # User ID for running the container (usually your own UID)
    zwiftUid = "1000";
    # Group ID for running the container (usually your own GID)
    zwiftGid = "100";
    # GPU/device flags override (Docker: "--gpus=all", Podman/CDI: "--device=nvidia.com/gpu=all")
    vgaDeviceFlag = "--device=nvidia.com/gpu=all";
    # Enable debug output and verbose logging if true
    debug = false;
    # If set, run container in privileged mode ("--privileged --security-opt label=disable")
    privilegedContainer = false;
  };
}
