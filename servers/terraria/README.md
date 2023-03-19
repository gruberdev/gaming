![][terraria-logo]

![][badge-img] &nbsp; ![][size-badge] &nbsp; ![][pulls-badge] &nbsp; ![][status-badge]

> Dig, fight, explore, build! Nothing is impossible in this action-packed adventure game. Four Pack also available!
>
>
>
> - [Terraria Official website][website-uri]
> - [Steam store page][steam-uri]

### Getting started

- To deploy a sample gameserver individually
```bash
task terraria:deploy:gs
# Or if you prefer to use kubectl directly
kubectl apply -k github.com/gruberdev/gaming/servers/terraria/deploy/gs
```

- To deploy a fleet of Terraria servers (with auto-scaling)
```bash
task terraria:deploy:fleet
# Or if you prefer to use kubectl directly
kubectl apply -k github.com/gruberdev/gaming/servers/terraria/deploy/fleet
```

- How to request help about CLI commands regarding this game:

```bash
task Terraria:help
```


## Environment Variables

| <h4>Variable name</h3>    | <h4>**Default Value**</h4> | <h4>**Description**</h4> |
|------------------------|-------------------|-----------------|
| TERRARIA_WORLDNAME        |                 |                 |
| TERRARIA_WORLDSEED        |                 |                 |
| TERRARIA_USECONFIGFILE    |                 |                 |
| TERRARIA_PASS             |                 |                 |
| TERRARIA_MOTD             |                 |                 |
| TERRARIA_MAXPLAYERS       |                 |                 |
| TERRARIA_WORLDSIZE        |                 |                 |
| TERRARIA_SHUTDOWN_MESSAGE |                 |                 |
|                           |                 |                 |

<br>
<br>

---
#### References

<sub>

➧  [Wiki entry on dedicated servers and CLI commands][wiki-uri]

➧  [Dockerfile technical reference #1][repo-1]

➧  [Dockerfile technical reference #2][repo-2]

➧  [Docs example reference #1][docs-1]

</sub>

[wiki-uri]: https://terraria.fandom.com/wiki/Server
[repo-1]: https://github.com/JACOBSMILE/terraria1.4
[repo-2]: https://github.com/beardedio/terraria/blob/main/containers/vanilla/1.4.4.9/Dockerfile
[terraria-logo]: https://static.wikia.nocookie.net/terraria_gamepedia/images/a/a4/NewPromoLogo.png/revision/latest?cb=20200506135559
[docs-1]: https://github.com/googleforgames/agones/tree/release-1.30.0/examples/xonotic
[badge-img]: https://img.shields.io/docker/v/grubertech/terraria?arch=amd64&label=latest%20version&sort=date&style=flat-square
[size-badge]: https://img.shields.io/docker/image-size/grubertech/terraria?label=image%20size&sort=date&style=flat-square
[pulls-badge]: https://img.shields.io/docker/pulls/grubertech/terraria.svg?style=flat-square
[status-badge]: https://img.shields.io/maintenance/yes/2023?style=flat-square
[steam-uri]: https://store.steampowered.com/app/105600/Terraria/
[website-uri]: https://forums.terraria.org/index.php
