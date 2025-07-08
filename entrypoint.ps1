Write-Host "Created by Endkind Ender (www.endkind.net) and modified by Mixels"

cd C:\container

if (-not (Test-Path "C:\serverfiles\server.jar")) {
    $result = & ".\getFolia.ps1"
    
    if (-Not $result) {
        exit 1
    }
}

while ($true) {
    # Required environment variables: MINECRAFT_EULA
    # Optional environment variables: MIN_RAM, MAX_RAM, JAVA_FLAGS, FOLIA_FLAGS
    java -Xms$env:MIN_RAM -Xmx$env:MAX_RAM $env:JAVA_FLAGS "-Dcom.mojang.eula.agree=$env:MINECRAFT_EULA" -jar C:\serverfiles\server.jar $env:FOLIA_FLAGS --nogui
    
    if ($LASTEXITCODE -ne 0) {
        exit 1
    }
}
