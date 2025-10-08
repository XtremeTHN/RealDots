{
  stdenv,
  fetchFromGitHub,
  configDir,
}:

stdenv.mkDerivation {
  pname = "adw-gtk-matugen";
  version = "0.2";
  src = fetchFromGitHub {
    owner = "XtremeTHN";
    repo = "adw-gtk3-dark-matugen";
    rev = "v0.1";
    sha256 = "sha256-1MZMyvYyXw9d/eOcB3BldKx3lDpvVemTiUtLvwbYUIQ=";
  };

  dontBuild = false;

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
