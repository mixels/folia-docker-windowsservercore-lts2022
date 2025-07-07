Write-Host "Created by Endkind Ender (www.endkind.net) and modified by Mixels"

if (-not (Test-Path -Path "/endkind/server.jar")) {
    & "/endkind/getFolia.ps1"
    
    if ($LASTEXITCODE -ne 0) {
        exit 1
    }
}

while ($true) {
    java -Xms$env:MIN_RAM -Xmx$env:MAX_RAM $env:JAVA_FLAGS -Dcom.mojang.eula.agree=$env:MINECRAFT_EULA -jar /endkind/server.jar $env:FOLIA_FLAGS --nogui
    
    if ($LASTEXITCODE -ne 0) {
        exit 1
    }
}
