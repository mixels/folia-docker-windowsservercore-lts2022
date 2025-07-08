# Folia - All Versions

This Docker image provides Folia Minecraft server versions. You can easily run a Folia Minecraft server using this image.

## Quick start

```powershell
docker run -it -d -p 25565:25565 --name mixels-folia-windowsservercore2022 -e MINECRAFT_EULA=true -v C:\Folia:C:\serverfiles mixels/folia-windowsservercore-ltsc2022:latest
```

This command starts a Folia server in detached mode (-d), maps port 25565 from the host to the container, accepts the Minecraft EULA, and maps the folder `C:\Folia` on the host PC to the server folder inside the container (which is `C:\serverfiles`). In the volume mapping value, you can change the path before the colon (:) to refer to any path on the host machine you want. Just make sure to always run subsequent run commands with that same value, as game files and savegame files will all be stored in that folder.

After running this image for the first time, stop the server and navigate to the mapped host folder. There, find the file `server.properties` and edit it to set server settings how you'd like them to be. Make note of the values for `query.port`, `rcon.port`, and `server-port`. If you use these features of the server, you will need to map each of these ports in the same way you did above (with the `-p 25565:25565` flag) by adding more `-p` flags. For example, if using port 25565, 25566, and 25567, use the flags `-p 25565:25565 -p 25566:25566 -p 25567:25567`.

For advanced users, there are no restrictions on port usage inside the container. You are free to set whatever ports you want in `server.properties` and write your Docker command to bind whatever host ports to whatever container ports you want.

## Installation and Configuration (Recommended)

## Options
Your `docker run` command can specify some important settings that control how the server functions. These options go here in the command `docker run {options} mixels/folia-windowsservercore-ltsc2022`:

**Required**
* `-p`: Map a port from the host machine to the container using the syntax `-p <hostPort>:<containerPort>`. Ports must be mapped to enable network connectivity to the server inside the container. | Example: `-p 25565:25565 -p 25566:25566 -p 25567:25567`
* `-e MINECRAFT_EULA=true`: Enables automatic acceptance of the Minecraft EULA.
* `-v`: Maps a folder path on the host machine to a folder path inside the container using the syntax `-v <PathOnHost>:<PathInContainer>`. This container exclusively uses the path `C:\serverfiles` inside the container, so be sure you map your host machine path to `C:\serverfiles`. The path you choose on your host machine should be the folder where you want your Folia Minecraft server to be installed. | Example: `-v C:\MyFoliaServer:C:\serverfiles`

**Optional**
* `-it`: Bind the console used to run the `docker run` command to the process started inside the container. This will let the console act as a server console, which you can run commands from similar to the default Minecraft server console. Omit this and use `-d` instead if you want the Folia Minecraft server as a background process.
* `-d`: Detach the process started from the console. This means that closing the console will not close the server process. Omit `-it` and use this instead if you want to run the Folia Minecraft server as a background process.

```powershell
docker volume create mixels-folia --opt type=none --opt device=C:\Folia --opt o=bind

docker run -it -d -p 25565:25565 --name mixels-folia-windowsservercore2022 -v mixels-folia:C:\serverfiles -e MAX_RAM=14G -e MINECRAFT_EULA=true --restart=always mixels/folia-windowsservercore-ltsc2022:latest
```
It is suggested to create a volume definition in Docker for repeated usage. Doing so simplifies writing of your Docker Run command and reduces the likelihood of accidentally running the server with a wrong path mapped in the `-v` flag.

If you run multiple Folia servers, change the `mixels-folia` designation above to create a unique value for each.

## Using Specific Versions

When deploying your server for production or if you require version stability, consider using specific image versions. For example:

### Folia 1.19.4

```powershell
docker run -it -d -p 25565:25565 -e MINECRAFT_EULA=true endkind/folia:<versionTag>
```
By specifying a version like 1.19.4, you ensure that your server runs a known and tested version of Folia.

### All Supported Version Tags

- `latest` uses always the newest version
- `1.21.4`
- `1.20.1`, `1.20.2`, `1.20.4`, `1.20.6`
- `1.19.4`

## Environment variables

You can customize your Folia server by setting the following environment variables:

- `MIN_RAM` (default: 512M) - Minimum RAM allocated for the server.
- `MAX_RAM` (default: 1G) - Maximum RAM allocated for the server.
- `MINECRAFT_EULA` (default: false) - Set to `true` to accept the Minecraft EULA.
- `JAVA_FLAGS` - Additional Java flags generated with [flags.sh](https://flags.sh/).
- `FOLIA_FLAGS` (default: --nojline) - Custom Folia server flags.
- `TZ` (example: Europe/Berlin) - Set the time zone for the server.

These environment variables allow you to tailor your Folia server's configuration to your specific requirements. You can adjust memory allocation, specify custom Java flags, and configure various server settings to suit your needs.

## Additional Information

- [GitHub Repository](https://github.com/mixels/folia-windowsservercore-ltsc2022)
- [Docker Repository](https://hub.docker.com/r/mixels/folia-windowsservercore-ltsc2022)
- Connect to our Minecraft server (crossplay) at `the7legions.ddns.net:8793` and start your adventure!

## License

This project is licensed under the terms of the [GNU General Public License v3.0](https://choosealicense.com/licenses/gpl-3.0/) License.

### Other License

This project includes code derived from the [Folia](https://github.com/PaperMC/folia) project and from the [Endkind-Folia](https://github.com/Endkind/folia) project.
