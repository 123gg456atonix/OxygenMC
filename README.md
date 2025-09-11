<br/><p align="center">
  <picture>
    <img alt="oxygenmc" src="https://github.com/123gg456atonix/OxygenMC/blob/main/oxygenmc.png?raw=true" height="100">
  </picture>
  <br/>
  123gg456's multi-egg. OxygenMC
  <br/><br/>
  <a href="https://discord.gg/yJScqZsQgV">Discord</a> <b>·</b>
  <a href="https://github.com/123gg456atonix/OxygenMC/issues">Support</a> <b>·</b>
  <a href="https://github.com/123gg456atonix/OxygenMC/actions">Actions</a><br><br>
</p>


<!-- Introduction -->
<br/><h2 align="center">🧩 Introduction</h2>

**OxygenMC** is a multiegg designed to simply server management for hosting providers. Currently, it only supports Minecraft.

**OxygenMC** also comes with features like:
- **MOTD Blocking**: Prevents changes to MOTD.
- **More Features**: Additional features to enhance server management.

> [!NOTE]  
> Disabling theses features require modifying the `entrypoint.sh` file. Do not modify this file unless you know what are you doing.

[Learn more about **OxygenMC**](https://discord.gg/yJScqZsQgV).

<!-- Showcase -->
<br/><h2 align="center">📷 Showcase</h2>

As there are images that cannot fit inside this README, they are collapsible.
<details>
  <summary>Click me to view the images!</summary>
>  - [!Main menu]
> <img width="1440" height="900" alt="image" src="https://github.com/user-attachments/assets/90f25438-7f8c-4fe1-bf3c-1ac605f5a1b8" />

</details>

<h2 align="center">📛 How to use?</h2>
You can either download the egg file directly from [**here**](https://github.com/123gg456atonix/OxygenMC/blob/main/egg-oxygenmc.json) or Build the egg and customize it with your preferences.

> [!NOTE]
> Your should have basic knowledge of how docker works and how do make images.

1. Clone the repository
```bash
git clone github.com/123gg456atonix/OxygenMC.git
```
2. Edit the `entrypoint.sh` and any custom jar or gameserver of your prefrence and add it in the *main_menu* function.
3. After editing, Upload everything to either github or your own KVM or VPS.
4. Install docker in your server
```bash
curl -sSL https://get.docker.com/ | CHANNEL=stable bash
```
5. **!! UPDATE `.github/workflows/docker-publish.yml` !!**
6. Go to the dir where you uploaded the files and run
```bash
docker build -t <image-name>:<tag> .
```
7. Go to pterodactyl and in the nests section click on import and upload `egg-oxygenmc.json` and edit the docker image. It should look something like this
```bash
Oxygen MC|ghcr.io/123gg456atonix/oxygenmc:main
```


<br/><h2 align="center">👥 Contributors</h2>

Contributors help shape the future of OxygenMC. There are currently one main contributors:

- [**123gg456**](https://github.com/123gg456atonix) - Made the egg.

<br/><br/>
<p align="center">
  $\color{#4b4950}{\textsf{© 2025 OxygenMC. Made with ❤️ by 123gg456.}}$
</p>
<p align="center">
Join my discord for additional support https://discord.com/invite/XrqErRqXCu
</p>
