FROM scrthq/powershell:preview-noentrypoint-buildtest-ubu-2004
SHELL ["pwsh", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
COPY ["PowerShell/ModuleBuildTest/*", "/source/"]
WORKDIR /source
ENTRYPOINT [ "pwsh", "-command", ". ./build.ps1 -Task Test" ]
