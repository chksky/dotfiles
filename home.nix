{ config, pkgs, inputs, ... }:

{
  home.username = "chksky";
  home.homeDirectory = "/home/chksky";
  home.stateVersion = "24.05";

  nixpkgs.config = {
    allowUnfree = true;
  };

  home.packages = [
    pkgs.htop
    pkgs.btop
    pkgs.neofetch

    pkgs.deno

    # archives
    pkgs.zip
    pkgs.xz
    pkgs.unzip

    pkgs.gnumake

    # JSON processing
    pkgs.jq

    # for `sensors` command
    pkgs.lm_sensors

    pkgs.wmctrl

    pkgs.obsidian
    pkgs.libsecret
    pkgs.polkit
    pkgs.xdg-utils
    pkgs.shared-mime-info
  ];

  programs.helix.enable = true;

  home.file.".config/obsidian/.keep".text = "";

  xdg.desktopEntries.obsidian = {
    name = "Obsidian";
    exec = "obsidian --no-sandbox %u";
    icon = "obsidian";
    type = "Application";
    categories = [ "Office" "TextEditor" ];
    mimeType = [ "x-scheme-handler/obsidian" ];
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion = {
      enable = true;
      strategy = [ "history" ];
    };
    initExtra = ''
      # fnm
      FNM_PATH="/home/chksky/.local/share/fnm"
      if [ -d "$FNM_PATH" ]; then
        export PATH="$FNM_PATH:$PATH"
        eval "`fnm env`"
      fi

      # ghcup-env
      [ -f "/home/chksky/.ghcup/env" ] && . "/home/chksky/.ghcup/env"
    '';

    shellAliases = {
      hms = "home-manager switch";
      f = "wmctrl -r :ACTIVE: -b add,fullscreen";
      uf = "wmctrl -r :ACTIVE: -b remove,fullscreen";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "docker"  ];
      theme = "robbyrussell";
    };

    plugins = [
      {
        name = "you-should-use";
        src = pkgs.fetchFromGitHub {
          owner = "MichaelAquilina";
          repo = "zsh-you-should-use";
          rev = "1.9.0";
          sha256 = "1kb11rqhmsnv3939prb9f00c1giqy3200sjnhh7cxcfjcncq0y7v";
        };
      }
    ];
  };

  programs.atuin = {
    enable = true;
    settings = {
      enter_accept = false;
    };
  };

  programs.git = {
    enable = true;
    userName = "Dima Ochkivskyi";
    userEmail = "github@chksky.com";
    difftastic.enable = true;
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/chksky/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nano";
  };
  # TODO: add editorconfig

  dconf.settings = {
    "org/gnome/desktop/input-sources" = {
      xkb-options = ["ctrl:nocaps"];
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
