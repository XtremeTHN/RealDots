{
  stdenv,
  replaceVars,
  # fetchFromGitHub,
  configDir,
}:

stdenv.mkDerivation {
  pname = "adw-gtk3-dark-matugen";
  version = "0.1";
  src = /home/axel/Git/adw-gtk-dark-matugen;
  # src = fetchFromGitHub {
  #   owner = "XtremeTHN";
  #   repo = "adw-gtk3-dark-matugen";
  #   rev = "v0.1";#
  #   sha256 = "sha256-6kWz54Yx8eu5SvBwh6le2OQDWF9aVjGSrikdqTMBJ90=";
  # };
  dontBuild = false;
  # patches = [
  #   (replaceVars ./patches/changePaths.patch {
  #     CONFIG = configDir;
  #   })
  # ];

  postPatch = ''
    for f in 3 4; do
      substituteInPlace gtk-$f.0/gtk-dark.css \
        --replace "./colors.css" "${configDir}/gtk-$f.0/colors.css"

      substituteInPlace gtk-$f.0/gtk.css \
        --replace "./colors.css" "${configDir}/gtk-$f.0/colors.css"
    done
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/themes/adw-gtk-matugen
    cp -a $(pwd)/* $out/share/themes/adw-gtk-matugen
    runHook postInstall
  '';
}
