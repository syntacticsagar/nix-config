{ config, pkgs, lib, ... }:
let
 LS_COLORS = pkgs.fetchgit {
    url = "https://github.com/trapd00r/LS_COLORS";
    rev = "7271a7a8135c1e8a82584bfc9a8ebc227c5c6b2b";
    sha256 = "sha256-hcdkgY0nM0i3VILt3FENCReGG4pmISkmK/rt3VvFQj8=";
  };
  ls-colors = pkgs.runCommand "ls-colors" { } ''
    mkdir -p $out/bin $out/share
    ln -s ${pkgs.coreutils}/bin/ls $out/bin/ls
    ln -s ${pkgs.coreutils}/bin/dircolors $out/bin/dircolors
    cp ${LS_COLORS}/LS_COLORS $out/share/LS_COLORS
  '';
  et-font = import ./et-font.nix { pkgs = pkgs; };
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "sgrptl";
  home.homeDirectory = "/Users/sgrptl";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";
 
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # nix-direnv
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  home.packages = [
    et-font
    ls-colors
    pkgs.cantarell-fonts
    pkgs.direnv
    pkgs.emacs
    pkgs.fd
    pkgs.git
    pkgs.gnupg
    pkgs.lorri
    pkgs.meslo-lg
    pkgs.niv
    pkgs.nerdfonts
    pkgs.pinentry_mac
    pkgs.python310
    pkgs.python310Packages.z3
    pkgs.ripgrep
  ];

  programs.helix = {
    enable = true;
    settings = {
      theme = "base16_terminal";    
    };
  };

  programs.pandoc = {
    enable = true;    
  };
  
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    history = {
      path = "/Users/sgrptl/.cache/zsh/.zsh_history";
      size = 50000;
      save = 50000;
    };
    
    initExtraBeforeCompInit = ''
      eval $(${pkgs.coreutils}/bin/dircolors -b /Users/sgrptl/.nix-profile/share/LS_COLORS)
      ${builtins.readFile /Users/sgrptl/.config/zsh/pre-compinit.zsh}
    '';
    initExtra = builtins.readFile /Users/sgrptl/.config/zsh/post-compinit.zsh;

    envExtra = '' 
      eval "$(${pkgs.direnv}/bin/direnv hook zsh)"
    '';

    plugins = [
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "be3882aeb054d01f6667facc31522e82f00b5e94";
          sha256 = "0w8x5ilpwx90s2s2y56vbzq92ircmrf0l5x8hz4g1nx3qzawv6af";
        };
      }
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = lib.cleanSource /Users/sgrptl/.config/zsh;
        file = ".p10k.zsh";
      }
    ];

    sessionVariables = rec {
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=3";

      EDITOR = "hx";
      VISUAL = EDITOR;
      GIT_EDITOR = EDITOR;
    };

    shellAliases = rec {
      ls = "ls --color=auto -F";
    };
  }; 
}
