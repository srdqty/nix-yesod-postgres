{ image-name ? "nix-yesod-postgres-image"
, image-tag ? "latest"
, push-image ? false
, compiler ? import ../ghc.nix
}:

let
  nixpkgs = import ../nixpkgs-pinned {};
  project-root = import ../project-root.nix;

  docker-push = nixpkgs.lib.optionalString push-image ''
    docker push ${image-name}:${image-tag}
  '';
in with nixpkgs;

stdenv.mkDerivation rec {
  name = "build-docker-image";

  # Docker is a system service anyway, so just assume it's installed instead of
  # bothering with buildInputs.

  shellHook = ''
    set -eu

    nix-build '${project-root}/nix/docker-image.nix' \
      --argstr image-name ${image-name} \
      --argstr image-tag ${image-tag} \
      --argstr compiler ${compiler} \
      --out-link '${project-root}/docker-image.tar.gz'

    docker load -i '${project-root}/docker-image.tar.gz'

    ${docker-push}

    exit
  '';
}
