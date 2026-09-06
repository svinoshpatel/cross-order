{
  description = "Dotnet development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        # Pick the SDK version(s) you need. You can combine multiple
        # via pkgs.dotnetCorePackages.combinePackages [ ... ] if a
        # project needs several target frameworks side by side.
        dotnet-sdk = pkgs.dotnetCorePackages.sdk_10_0;
      in
      {
        devShells.default = pkgs.mkShell {
          name = "dotnet-dev-shell";

          packages = with pkgs; [
            dotnet-sdk
            omnisharp-roslyn   # C# language server (for editors/LSP)
            netcoredbg         # .NET debugger (works well with nvim-dap, VSCode)
          ];

          # Avoid the SDK's first-run telemetry/banner and welcome message
          DOTNET_CLI_TELEMETRY_OPTOUT = "1";
          DOTNET_NOLOGO = "1";

          # Keep nuget/global packages inside the project so `dotnet` doesn't
          # try to write into the read-only nix store or your home profile.
          DOTNET_ROOT = "${dotnet-sdk}";
          NUGET_PACKAGES = "${toString ./.}/.nuget/packages";

          shellHook = ''
            echo "dotnet SDK: $(dotnet --version)"
            export PATH="$HOME/.dotnet/tools:$PATH"
          '';
        };
      });
}
