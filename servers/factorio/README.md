![](https://wiki.factorio.com/images/Factorio-logo.png)

![][badge-img] &nbsp; ![][size-badge] &nbsp; ![][pulls-badge] &nbsp; ![][status-badge]

> *Factorio* is a game about building and creating automated factories to produce items of increasing complexity, within an infinite 2D world. Use your imagination to design your factory, combine simple elements into ingenious structures, and finally protect it from the creatures who don't really like you.
>
>
> - [Factorio Official website][website-uri]
> - [Steam store page][steam-uri]

### Getting started

- To deploy a sample gameserver individually
```bash
task factorio:deploy:gs
# Or if you prefer to use kubectl directly
kubectl apply -k github.com/gruberdev/gaming/servers/factorio/deploy/gs
```

- To deploy a fleet of Factorio servers (with auto-scaling)
```bash
task factorio:deploy:fleet
# Or if you prefer to use kubectl directly
kubectl apply -k github.com/gruberdev/gaming/servers/factorio/deploy/fleet
```

- How to request help about CLI commands regarding this game:

```bash
task factorio:help
```

---

<br>
<details>

<summary> <b> Environment Variables (Click to expand)</b> </summary>

| <h4>Variable name</h4>    | <h4>**Default Value**</h4> | <h4>**Description**</h4> |
|----------------------------|-------------------|-----------------|
|  FCTR_SERVERNAME           | Agones Server Example | The name of the Factorio server |
|  FCTR_DESCRIPTION          | A brief description of your server | A short description of the Factorio server |
|  FCTR_ADMINS               |                   | A list of case-insensitive usernames that will be promoted to admin immediately |
|  FCTR_MAXPLAYERS           | 32                | Maximum number of players allowed; admins can join even a full server. 0 means unlimited. |
|  FCTR_PUBLIC               | true              | Whether the game will be published on the official Factorio matching server |
|  FCTR_LAN                  | true              | Whether the game will be broadcast on LAN |
|  FCTR_USERNAME             |                   | Your factorio.com login username; required for games with visibility 'public' |
|  FCTR_PASSWORD             |                   | Your factorio.com login password; required for games with visibility 'public' |
|  FCTR_TOKEN                |                   | Authentication token; may be used instead of 'password' above |
|  FCTR_GAMEPASSWORD         |                   | Password required to join the game |
|  FCTR_VERIFIED_USER        | true              | When set to true, the server will only allow clients that have a valid Factorio.com account |
|  FCTR_MAXUPLOAD            | 0                 | Maximum upload speed in kilobytes per second; 0 means unlimited |
|  FCTR_LATENCY              | 0                 | Minimum latency in ticks; one tick is 16ms in default speed, 0 means no minimum |
|  FCTR_RETURNEE_POLICY      | false             | Whether players that played on this map already can join even when the max player limit was reached |
|  FCTR_AUTOKICK             | 0                 | How many minutes until someone is kicked for being AFK; 0 for never |
|  FCTR_AUTOPAUSE            | true              | Whether the server should be paused when no players are present |
|  FCTR_ADMIN_PAUSE          | true              | Whether only admins should be able to pause the game |
|  FCTR_AUTOSAVE_INTERVAL    | 10                | Autosave interval in minutes |
|  FCTR_SAVE_SLOTS           | 5                 | Server autosave slots; cycled through when the server autosaves |
|  FCTR_AUTOSAVE_SERVER      | true              | Whether autosaves should be saved only on server or also on all connected clients |
|  FCTR_AUTOSAVE_NONBLOCKING | false             | Whether non-blocking saving is enabled (highly experimental) |
|  FCTR_ADMINS               |                   | A list of case-insensitive usernames that will be promoted immediately |

---
</details>

<br>



#### References

<sub>

➧   [Dockerfile Technical Reference #1][repo-1]

➧   [Dockerfile Technical Reference #2][repo-2]

➧   [CLI parameters official documentation][cli-args-uri]

</sub>

[repo-1]: https://github.com/goofball222/factorio
[repo-2]: https://github.com/mikkilevon/headless-factorio-docker
[cli-args-uri]: https://wiki.factorio.com/Command_line_parameters
[badge-img]: https://img.shields.io/docker/v/grubertech/factorio?arch=amd64&label=latest%20version&sort=date&style=flat-square
[size-badge]: https://img.shields.io/docker/image-size/grubertech/factorio?label=image%20size&sort=date&style=flat-square
[pulls-badge]: https://img.shields.io/docker/pulls/grubertech/factorio.svg?style=flat-square
[status-badge]: https://img.shields.io/maintenance/yes/2023?style=flat-square
[steam-uri]: https://store.steampowered.com/app/427520/Factorio
[website-uri]: https://www.factorio.com/
