# futuralogic/mcrcon

An Alpine ARM64 docker image for MCRCON - Automate Minecraft server backups or RCON for remote management.

Builds MCRCON from [Tiiffi/mcrcon](https://github.com/Tiiffi/mcrcon) - [v0.7.1](https://github.com/Tiiffi/mcrcon/releases/tag/v0.7.1)

# Usage

## Environment variables used by the container

|ENV|Description|Required|
|----|----|----|
|RCON_SERVER|Name or IP of your Minecraft server|*|
|RCON_PORT|Port running RCON|*|
|RCON_PASS|Password for RCON access|*|
|MC_WORLD|Simply a friendly name used in the auto-generated backup file.|Backup|
|KEEP_MIN|Remove backup folders older than X minutes|Backup|
|TZ|Set container timezone so the auto-generated backup file name is dated usefully for you (otherwise UTC).|Backup|

## Volume mounts

|Container mount|Description|
|---|---|
|/data/from|Folder where your Minecraft files live (typically where server.properties exists)|
|/data/to|Folder where you want the backups to be sent|

## Backup your Minecraft server

The `backup` command executes `backup.sh` to createa zip snapshot of your Minecraft server data.

Archives older than `KEEP_MIN` will be deleted, keeping your `/data/to` tidy.

Zip archives are named:

`{MC_WORLD}-backup-YYYY-MM-DD-HH-MM-SS.zip`

```
docker run --rm \
	-e RCON_SERVER=server_name \
	-e RCON_PORT=custom_port \
	-e RCON_PASS=password \
	-e MC_WORLD=some_name \
	-e KEEP_MIN=190 \
	-e TZ=America/Chicago \
	-v /your/minecraft/server/data/folder:/data/from \
	-v /your/backup/location:/data/to \
	futuralogic/mcrcon:latest backup
```

## Execute a Minecraft console command (and then exit)

```
docker run --rm \
	-e RCON_SERVER=server_name \
	-e RCON_PORT=custom_port \
	-e RCON_PASS=password \
	-e TZ=America/Chicago \
	futuralogic/mcrcon:latest run list players
```

## Run an interactive RCON session

Run the container with interactive/tty.

```
docker run -it --rm \
	-e RCON_SERVER=server_name \
	-e RCON_PORT=custom_port \
	-e RCON_PASS=password \
	-e TZ=America/Chicago \
	futuralogic/mcrcon:latest run
```
