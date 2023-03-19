## Terraria

- How to request help about CLI commands regarding Terraria
```bash
task terraria:help
```

- To deploy a fleet of Terraria servers (with auto-scaling)
```bash
task terraria:deploy:fleet
# Or if you prefer to use kubectl directly
kubectl apply -k ./servers/terraria/deploy/fleet
```
---

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
[docs-1]: https://github.com/googleforgames/agones/tree/release-1.30.0/examples/xonotic
