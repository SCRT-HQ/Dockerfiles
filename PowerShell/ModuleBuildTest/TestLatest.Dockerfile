FROM scrthq/powershell:latest-buildtest-ubu-1804
SHELL ["pwsh", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
COPY ["PowerShell/ModuleBuildTest/*", "/source/"]
WORKDIR /source
ENTRYPOINT [ "pwsh", "-command", ". ./build.ps1 -Task Test" ]
