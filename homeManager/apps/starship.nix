{ pkgs, ... }:

{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      aws = {
        format = "[ $symbol($profile)(\\($region\\))(\\[$duration\\]) ]($style)";
        style = "bg:mauve fg:#000000";
        symbol = " ";
      };
      c = {
        format = "[ $symbol($version(-$name)) ]($style)";
        style = "bg:green fg:#000000";
      };
      character = {
        error_symbol = "[>](bold red)";
        success_symbol = "[>](bold cyan)";
        vimcmd_symbol = "[>](bold cyan)";
      };
      cmake = {
        format = "[ $symbol($version) ]($style)";
        style = "bg:green fg:#000000";
      };
      cmd_duration = {
        format = "[ﮫ $duration]($style)";
        min_time = 300000;
        show_milliseconds = false;
        style = "bg:yellow fg:#000000";
      };
      cobol = {
        format = "[ $symbol($version) ]($style)";
        style = "bg:green fg:#000000";
      };
      conda = {
        format = "[ $symbol$environment ]($style)";
        style = "bg:green fg:#000000";
      };
      container = {
        format = "[$hostname]($style)";
        style = "bg:red fg:#000000";
      };
      crystal = {
        format = "[ $symbol($version) ]($style)";
        style = "bg:green fg:#000000";
      };
      dart = {
        format = "[ $symbol($version) ]($style)";
        style = "bg:green fg:#000000";
      };
      deno = {
        format = "[ $symbol($version) ]($style)";
        style = "bg:green fg:#000000";
      };
      directory = {
        format = "[$path]($style)[$read_only]($read_only_style)";
        read_only = " ";
        read_only_style = "bg:red fg:#000000";
        style = "bg:red fg:#000000";
        use_os_path_sep = false;
      };
      docker_context = {
        format = "[ $symbol$context ]($style)";
        style = "bg:mauve fg:#000000";
        symbol = " ";
      };
      dotnet = {
        format = "[ $symbol($version)( $tfm) ]($style)";
        style = "bg:green fg:#000000";
      };
      elixir = {
        format = "[ $symbol($version \\(OTP $otp_version\\)) ]($style)";
        style = "bg:green fg:#000000";
      };
      elm = {
        format = "[ $symbol($version) ]($style)";
        style = "bg:green fg:#000000";
      };
      erlang = {
        format = "[ $symbol($version) ]($style)";
        style = "bg:green fg:#000000";
      };
      format =
        "[](fg:red)$directory$username$hostname$container$sudo$shlvl[](fg:red bg:peach)$vcsh$git_branch$git_commit$git_state$git_status$git_metrics[](fg:peach bg:yellow)$cmd_duration$status[](fg:yellow bg:green)$deno$golang$helm$lua$nodejs$php$python$rust[](fg:green bg:blue)$package$nix_shell[](fg:blue bg:mauve)$azure$docker_context$kubernetes[](fg:mauve)$line_break$shell$character";
      gcloud = {
        format = "[ $symbol$account(@$domain)(\\($region\\)) ]($style)";
        style = "bg:mauve fg:#000000";
        symbol = " ";
      };
      git_branch = {
        format = "[$symbol$branch]($style)";
        style = "bg:peach fg:#000000";
        symbol = " ";
      };
      git_commit = {
        format = "[\\($hash$tag\\)]($style)";
        style = "bg:peach fg:#000000";
        tag_disabled = false;
        tag_symbol = "  ";
      };
      git_metrics = {
        added_style = "bg:peach fg:#000000";
        deleted_style = "bg:peach fg:#000000";
        disabled = false;
        format =
          "([ +$added]($added_style)[/](bg:peach fg:#000000)[-$deleted]($deleted_style))";
      };
      git_state = {
        format = "[\\($state( $progress_current/$progress_total)\\)]($style)";
        style = "bg:peach fg:#000000";
      };
      git_status = {
        ahead = "↑";
        behind = "↓";
        conflicted = "!";
        deleted = "×";
        diverged = "↕";
        format = "([ $all_status$ahead_behind]($style))";
        modified = "~";
        renamed = "»";
        staged = "●";
        stashed = "ﮅ ";
        style = "bg:peach fg:#000000";
        untracked = "+";
      };
      golang = {
        format = "[ $symbol($version) ]($style)";
        style = "bg:green fg:#000000";
        symbol = " ";
      };
      haskell = {
        format = "[ $symbol($version) ]($style)";
        style = "bg:green fg:#000000";
        symbol = " ";
      };
      helm = {
        format = "[ $symbol($version) ]($style)";
        style = "bg:green fg:#000000";
        symbol = "ﴱ ";
      };
      hg_branch = {
        format = "[$symbol$branch]($style)";
        style = "bg:peach fg:#000000";
      };
      hostname = {
        format = "[$ssh_symbol$hostname ]($style)";
        ssh_symbol = "@";
        style = "bg:red fg:#000000";
      };
      java = {
        format = "[ $symbol($version) ]($style)";
        style = "bg:green fg:#000000";
        symbol = " ";
      };
      julia = {
        format = "[ $symbol($version) ]($style)";
        style = "bg:green fg:#000000";
      };
      kotlin = {
        format = "[ $symbol($version) ]($style)";
        style = "bg:green fg:#000000";
      };
      kubernetes = {
        disabled = false;
        format = "[ $symbol($cluster/$namespace) ]($style)";
        style = "bg:mauve fg:#000000";
        symbol = "󱃾 ";
      };
      lua = {
        format = "[ $symbol($version) ]($style)";
        style = "bg:green fg:#000000";
        symbol = " ";
      };
      nim = {
        format = "[ $symbol($version) ]($style)";
        style = "bg:green fg:#000000";
      };
      nix_shell = {
        format = "[ $symbol$state( \\($name\\)) ]($style)";
        style = "bg:blue fg:#000000";
        symbol = " ";
      };
      nodejs = {
        format = "[ $symbol($version) ]($style)";
        style = "bg:green fg:#000000";
      };
      ocaml = {
        format =
          "[ $symbol($version)(\\($switch_indicator$switch_name\\)) ]($style)";
        style = "bg:green fg:#000000";
      };
      openstack = {
        format = "[ $symbol$cloud(\\($project\\)) ]($style)";
        style = "bg:mauve fg:#000000";
        symbol = " ";
      };
      package = {
        format = "[ $symbol$version ]($style)";
        style = "bg:blue fg:#000000";
        symbol = " ";
      };
      palette = "catppuccin_mocha";
      palettes = {
        catppuccin_latte = {
          base = "#eff1f5";
          blue = "#1e66f5";
          crust = "#dce0e8";
          flamingo = "#dd7878";
          green = "#40a02b";
          lavender = "#7287fd";
          mantle = "#e6e9ef";
          maroon = "#e64553";
          mauve = "#8839ef";
          overlay0 = "#9ca0b0";
          overlay1 = "#8c8fa1";
          overlay2 = "#7c7f93";
          peach = "#fe640b";
          pink = "#ea76cb";
          red = "#d20f39";
          rosewater = "#dc8a78";
          sapphire = "#209fb5";
          sky = "#04a5e5";
          subtext0 = "#6c6f85";
          subtext1 = "#5c5f77";
          surface0 = "#ccd0da";
          surface1 = "#bcc0cc";
          surface2 = "#acb0be";
          teal = "#179299";
          text = "#4c4f69";
          yellow = "#df8e1d";
        };
        catppuccin_mocha = {
          base = "#1e1e2e";
          blue = "#89b4fa";
          crust = "#11111b";
          flamingo = "#f2cdcd";
          green = "#a6e3a1";
          lavender = "#b4befe";
          mantle = "#181825";
          maroon = "#eba0ac";
          mauve = "#cba6f7";
          overlay0 = "#6c7086";
          overlay1 = "#7f849c";
          overlay2 = "#9399b2";
          peach = "#fab387";
          pink = "#f5c2e7";
          red = "#f38ba8";
          rosewater = "#f5e0dc";
          sapphire = "#74c7ec";
          sky = "#89dceb";
          subtext0 = "#a6adc8";
          subtext1 = "#bac2de";
          surface0 = "#313244";
          surface1 = "#45475a";
          surface2 = "#585b70";
          teal = "#94e2d5";
          text = "#cdd6f4";
          yellow = "#f9e2af";
        };
      };
      perl = {
        format = "[ $symbol($version) ]($style)";
        style = "bg:green fg:#000000";
      };
      php = {
        format = "[ $symbol($version) ]($style)";
        style = "bg:green fg:#000000";
        symbol = " ";
      };
      pulumi = {
        format = "[ $symbol$stack ]($style)";
        style = "bg:green fg:#000000";
      };
      purescript = {
        format = "[ $symbol($version) ]($style)";
        style = "bg:green fg:#000000";
      };
      python = {
        format =
          "[ \${symbol}\${pyenv_prefix}(\${version})(\\($virtualenv\\)) ]($style)";
        style = "bg:green fg:#000000";
        symbol = " ";
      };
      red = {
        format = "[ $symbol($version) ]($style)";
        style = "bg:green fg:#000000";
      };
      ruby = {
        format = "[ $symbol($version) ]($style)";
        style = "bg:green fg:#000000";
        symbol = " ";
      };
      rust = {
        format = "[ $symbol($version) ]($style)";
        style = "bg:green fg:#000000";
        symbol = " ";
      };
      scala = {
        format = "[ $symbol($version) ]($style)";
        style = "bg:green fg:#000000";
      };
      shlvl = { style = "bg:red fg:#000000"; };
      spack = {
        format = "[ $symbol$environment ]($style)";
        style = "bg:green fg:#000000";
      };
      status = { style = "bg:yellow fg:#000000"; };
      sudo = {
        disabled = false;
        format = "[$symbol]($style)";
        style = "bg:red fg:#000000";
        symbol = "  ";
      };
      swift = {
        format = "[ $symbol($version) ]($style)";
        style = "bg:green fg:#000000";
        symbol = " ";
      };
      terraform = {
        format = "[ $symbol$workspace ]($style)";
        style = "bg:mauve fg:#000000";
      };
      username = {
        format = "[ $user]($style)";
        style_root = "bg:red fg:#000000";
        style_user = "bg:red fg:#000000";
      };
      vagrant = {
        format = "[ $symbol($version) ]($style)";
        style = "bg:green fg:#000000";
      };
      vlang = {
        format = "[ $symbol($version) ]($style)";
        style = "bg:green fg:#000000";
      };
      zig = {
        format = "[ $symbol($version) ]($style)";
        style = "bg:green fg:#000000";
      };
    };
  };
}
