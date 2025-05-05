{ stdenv, replaceVars, fetchFromGitHub, configDir }:

stdenv.mkDerivation {
  pname = "adw-gtk3-dark-matugen";
  version = "0.1";
  src = fetchFromGitHub {
    owner = "XtremeTHN";
    repo = "adw-gtk3-dark-matugen";
    rev = "v0.1";
    sha256 = "sha256-6kWz54Yx8eu5SvBwh6le2OQDWF9aVjGSrikdqTMBJ90=";
  };
  dontBuild = false;
  patches = [
    (replaceVars ./patches/changePaths.patch {
      config3 = "${configDir}/gtk-3.0";
      config4 = "${configDir}/gtk-4.0";
    })
  ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/themes/adw-gtk3-dark-matugen
    cp -a $(pwd)/* $out/share/themes/adw-gtk3-dark-matugen
    runHook postInstall
  '';
}