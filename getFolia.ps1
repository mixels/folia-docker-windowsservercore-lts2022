$VERSION = Get-Content -Path "C:\serverfiles\folia_version"
$BASE_URL = "https://api.papermc.io/v2/projects/folia"

if ($VERSION -eq "latest") {
    $response = Invoke-RestMethod -Uri $BASE_URL
    $VERSION = $response.versions[-1]
}

$versionResponse = Invoke-RestMethod -Uri "$BASE_URL/versions/$VERSION"
$LATEST_BUILD = $versionResponse.builds[-1]

try {
    Invoke-WebRequest -Uri "$BASE_URL/versions/$VERSION/builds/$LATEST_BUILD/downloads/folia-$VERSION-$LATEST_BUILD.jar" -OutFile "C:\serverfiles\server.jar" -ErrorAction Stop
    Write-Output "Download Folia Version ($VERSION) Build ($LATEST_BUILD)"
}
catch {
    Write-Output "An error occurred while downloading Folia. Please try again or recreate the container."
    return $false
}

if (Test-Path "C:\serverfiles\server.jar") {
    return $true
} else {
    return $false
}
