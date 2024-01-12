# Docker image for the Discord bot Auto Voice Channels.

[![Docker Pulls](https://img.shields.io/badge/dynamic/json?color=red&label=pulls&query=pull_count&url=https%3A%2F%2Fhub.docker.com%2Fv2%2Frepositories%2Fvinanrra%2Fauto-voice-channels%2F?style=flat-square&color=E68523&logo=docker&logoColor=white)](https://hub.docker.com/r/vinanrra/auto-voice-channels)
[![Docker Stars](https://img.shields.io/badge/dynamic/json?color=red&label=stars&query=star_count&url=https%3A%2F%2Fhub.docker.com%2Fv2%2Frepositories%2Fvinanrra%2Fauto-voice-channels%2F?style=flat-square&color=E68523&logo=docker&logoColor=white)](https://hub.docker.com/r/vinanrra/auto-voice-channels)
[![Docker Last Updated](https://img.shields.io/badge/dynamic/json?color=red&label=Last%20Update&query=last_updated&url=https%3A%2F%2Fhub.docker.com%2Fv2%2Frepositories%2Fvinanrra%2Fauto-voice-channels%2F?style=flat-square&color=E68523&logo=docker&logoColor=white)](https://hub.docker.com/r/vinanrra/auto-voice-channels)

https://github.com/gregzaal/Auto-Voice-Channels

This pulls the latest zip file of the bot from github.

***Please make sure you first [read the documentation](https://github.com/gregzaal/Auto-Voice-Channels#readme) of Auto-Voice-Channels.**

## Usage

### Docker

```bash
docker run -d \
  --name avc \
  --restart unless-stopped \
  -e ADMIN_ID=<ADMIN ID> \
  -e CLIENT_ID=<CLIENT_ID> \
  -e TZ=<TIMEZONE> \
  -e TOKEN=<TOKEN> \
  -e HEARTBEAT_TIMEOUT=60 \
  -e DISABLE_LOOP=false \
  -e RDY_MESSAGE=false \
  -e AWS=false \
  -v /path/to/folder:/AutoVoiceChannels/guilds:Z \
  vinanrra/auto-voice-channels
```

If you wan't a Docker Compose file see: [docker-compose.yml](docker-compose.yml)

## Parameters

| Parameter | Function |
| :----: | --- |
| `ADMIN_ID` | Your ID, for the bot to DM you when it logs on, joins servers, gets errors, etc. |
| `CLIENT_ID` | The bot ID. |
| `TZ` | Time displayed in logs. eg Europe/London |
| `TOKEN` | Bot's private token you can find here - do not share it with anyone else. |
| `AWS` | Activate hearthbreat to be able to host in AWS server. |
| `HEARTBEAT_TIMEOUT` | (int, default 60) For extremely extremely large servers, if your bot is having trouble connecting and repeatedly timing out before it can finish processing all members, set this to some higher number. |
| `DISABLE_LOOP` | (bool, default false) For extremely large servers, set this to true if your bot starts creating multiple channels for one person even though they only wanted one. This will disable the background loop that watches primary channels, so the only way a new channel will be created is if the event of the user joining a primary channel is caught. |
| `RDY_MESSAGE` | (bool, default false) Use to prevent the bot spamming you "Ready" when it regains connection, which may be quite often if your internet is unstable. |
| `GUILD DATA DIR` | Absolute path to the directory you wish to store your persistant guild data. |

Invite the bot to your own server, replacing `<YOUR BOT ID>` with... your bot ID: `https://discordapp.com/api/oauth2/authorize?client_id=<YOUR BOT ID>&permissions=286280784&scope=bot`
