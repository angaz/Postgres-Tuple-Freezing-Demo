{
  description = "Website of Angus Dippenaar";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        {
          devShell = pkgs.mkShell {
            buildInputs = with pkgs; [
              (pkgs.writeShellScriptBin "vscode-html-language-server" "exec -a $0 ${nodePackages.vscode-html-languageserver-bin}/bin/html-languageserver $0")
              (pkgs.writeShellScriptBin "vscode-css-language-server" "exec -a $0 ${nodePackages.vscode-css-languageserver-bin}/bin/css-languageserver $0")
              nodePackages.prettier
              minio-client
              (writeShellScriptBin "mc-upload" ''
                if ! ${minio-client}/bin/mc stat $BUCKET_NAME &> /dev/null; then
                    ${minio-client}/bin/mc mb $BUCKET_NAME
                    ${minio-client}/bin/mc anonymous set download $BUCKET_NAME
                fi
                
                ${minio-client}/bin/mc cp --quiet ./index.html $BUCKET_NAME
              '')
            ];
          };
        }
      );
}
