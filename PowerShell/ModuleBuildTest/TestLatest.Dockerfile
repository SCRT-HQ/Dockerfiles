FROM scrthq/powershell:latest
SHELL ["pwsh", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
COPY ["PowerShell/ModuleBuildTest/*", "/source/"]
WORKDIR /source
ENTRYPOINT [ "pwsh", "-command", ". ./build.ps1 -Task Test" ]
