{pkgs, pname, version, ...}:

pkgs.stdenvNoCC.mkDerivation {
  inherit pname version;

  src = ./.;
  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/sounds/${pname}

    install -Dm644 $src/index.theme $out/share/sounds/${pname}

    cp -r $src/mmbn $out/share/sounds/${pname}
    find $out/share/sounds/${pname}/mmbn -type d -exec chmod 755 {} \;
    find $out/share/sounds/${pname}/mmbn -type f -exec chmod 644 {} \;

    runHook postInstall
  '';

  meta = {
    name = "Megaman Battle Network Sounds Effect Pack";
    description = "A pack of the custom sound effects used in the hit GBA game series Megaman Battle Network";
  };
}