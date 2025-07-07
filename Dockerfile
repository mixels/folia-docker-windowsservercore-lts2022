FROM openjdk:21-windowsservercore-ltsc2022

LABEL Author Endkind Ender <endkind.ender@endkind.net>, modified by Mixels

WORKDIR c:\\serverfiles

COPY getFolia.ps1 getFolia.ps1
COPY entrypoint.ps1 entrypoint.ps1

ARG FOLIA_VERSION=latest
ENV FOLIA_VERSION=$FOLIA_VERSION
RUN $env:FOLIA_VERSION | Out-File -FilePath .\folia_version

ENV MIN_RAM=1G
ENV MAX_RAM=14G
ENV JAVA_FLAGS="--add-modules=jdk.incubator.vector -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20"
ENV FOLIA_FLAGS="--nojline"

ENTRYPOINT ["entrypoint.ps1"]
