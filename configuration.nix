{ config, pkgs, ... }:

{
  imports = [ ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";

  networking.hostName = "nixos-vm";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Prague";

  # Password hash generated with: mkpasswd -m sha-512 test
  users.users.root.initialHashedPassword =
    "$6$mbIv7cETuxyYKc0Z$J/VBWC95983GK0hIsl5PImg8pmfkrjWb7oHJbBWYir6NODxcvQz5TSGWX.X443RTGR2dP3PT3QkZMYr/k.got.";

  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    # Password hash generated with: mkpasswd -m sha-512 test
    initialHashedPassword =
      "$6$mbIv7cETuxyYKc0Z$J/VBWC95983GK0hIsl5PImg8pmfkrjWb7oHJbBWYir6NODxcvQz5TSGWX.X443RTGR2dP3PT3QkZMYr/k.got.";
  };

  environment.systemPackages = with pkgs; [
    vim
    htop
    fzf
    curlie
    systemctl-tui
    kubectl
    kubernetes-helm
    k9s
    kubectx
  ];

  environment.variables = {
    KUBECONFIG = "/var/lib/rancher/k3s/server/cred/admin.kubeconfig";
    TERM = "xterm-256color";
  };

  programs.bash = {
    completion.enable = true;
    interactiveShellInit = ''
      # Better prompt
      export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

      # History settings
      export HISTSIZE=10000
      export HISTFILESIZE=20000
      export HISTCONTROL=ignoredups:erasedups

      # Aliases
      alias ll='ls -alF'
      alias la='ls -A'
      alias l='ls -CF'
      alias grep='grep --color=auto'
      alias k='kubectl'

      # Enable kubectl completion
      source <(kubectl completion bash)
      complete -o default -F __start_kubectl k

      # Enable fzf key bindings
      source ${pkgs.fzf}/share/fzf/key-bindings.bash
      source ${pkgs.fzf}/share/fzf/completion.bash
    '';
  };

  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = true;
  services.openssh.settings.PermitRootLogin = "yes";

  services.k3s.enable = true;
  services.k3s.role = "server";

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 6443 ];

  virtualisation.vmVariant = {
    virtualisation.memorySize = 4096;
    virtualisation.cores = 4;
  };

  system.stateVersion = "25.05";
}
