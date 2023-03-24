<p align="center">
  <img width="450" height="150" src="https://static.wikia.nocookie.net/terraria_gamepedia/images/7/7a/Terraria-official-website-2014.png">
</p>

<p align="center">
  <a href="https://hub.docker.com/r/grubertech/terraria"><img src="https://img.shields.io/docker/v/grubertech/terraria?arch=amd64&label=latest%20version&sort=date&style=flat-square" alt="Latest Version" style="max-width:100%;"></a> &nbsp;
  <a href="https://hub.docker.com/r/grubertech/terraria"><img src="https://img.shields.io/docker/image-size/grubertech/terraria?label=image%20size&sort=date&style=flat-square" alt="Image Size" style="max-width:100%;"></a> &nbsp;
  <a href="https://hub.docker.com/r/grubertech/terraria"><img src="https://img.shields.io/docker/pulls/grubertech/terraria.svg?style=flat-square" alt="Docker Pulls" style="max-width:100%;"></a> &nbsp;
  <a href="https://github.com/gruberdev/gaming/pkgs/container/terraria"><img src="https://img.shields.io/github/actions/workflow/status/gruberdev/gaming/terraria.yml?label=image%20build&logo=docker&style=flat-square" alt="CI Badge" style="max-width:100%;"></a>
</p>

> Dig, fight, explore, build! Nothing is impossible in this action-packed adventure game.
>
>
> - [Terraria Official website][website-uri]
> - [Steam store page][steam-uri]
>
> #### Pull the container Image from the mirrors below:
> &nbsp;
> [Dockerhub][dockerhub-uri] &nbsp; | &nbsp; [Github Container Registry][pull-link]
>


#### Getting started

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

<br>
<details>

<summary> <b> Environment Variables (Click to expand)</b> </summary>

<br>

| <h4>Variable name</h3>    | <h4>**Description**</h4> | <h4>**Default Values**</h4> |
|-----------------------|----------------------------------------------------------|---------------|
| TERRARIA_MOTD         | Message of the day displayed in the server               | "A server powered by Kubernetes and Agones!" |
| TERRARIA_PASS         | Password required to join the server                      | ""            |
| TERRARIA_MAXPLAYERS   | Maximum number of players allowed on the server           | "16"          |
| TERRARIA_WORLDNAME    | Name of the Terraria world used by the server                 | "Example"     |
| TERRARIA_WORLDSIZE    | Size of the world file used by the server                 | "3"           |
| TERRARIA_WORLDSEED    | Seed used to generate the world file used by the server   | "Docker"      |
| TERRARIA_USECONFIGFILE| Flag indicating whether the server should use a config file| "No"          |

</details>

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
[terraria-logo]: https://static.wikia.nocookie.net/terraria_gamepedia/images/7/7a/Terraria-official-website-2014.png
[docs-1]: https://github.com/googleforgames/agones/tree/release-1.30.0/examples/xonotic
[badge-img]: https://img.shields.io/docker/v/grubertech/terraria?arch=amd64&label=latest%20version&sort=date&style=flat-square
[size-badge]: https://img.shields.io/docker/image-size/grubertech/terraria?label=image%20size&sort=date&style=flat-square
[pulls-badge]: https://img.shields.io/docker/pulls/grubertech/terraria.svg?style=flat-square
[status-badge]: https://img.shields.io/maintenance/yes/2023?style=flat-square
[steam-uri]: https://store.steampowered.com/app/105600/Terraria/
[website-uri]: https://forums.terraria.org/index.php
[ci-badge]: https://img.shields.io/github/actions/workflow/status/gruberdev/gaming/terraria.yml?label=image%20build&logo=docker&style=flat-square
[pull-link]: https://github.com/gruberdev/gaming/pkgs/container/terraria
[dockerhub-uri]: https://hub.docker.com/r/grubertech/terraria