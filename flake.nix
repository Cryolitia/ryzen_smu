{
  description = "ryzen_smu Nix Flake";

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  inputs =
    {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    };

  outputs =
    inputs:
    let
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs {
        inherit system;
      };
    in
    {
      devShells."${system}".ryzen_smu = pkgs.mkShell {
        buildInputs = with pkgs; [
          cmake
          linux.dev
        ];

        shellHook = ''
          export KERNEL_BUILD_PATH=${pkgs.linux.dev}/lib/modules/${pkgs.linux.modDirVersion}/build
        '';
      };
    };
}
