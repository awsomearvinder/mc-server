FROM maven:3.9.11 as CoreProtectBuild

RUN git clone https://github.com/PlayPro/CoreProtect.git /home/app

RUN sed -i "s/project.branch>/project.branch>development/" /home/app/pom.xml
RUN mvn -f /home/app clean package

# wtf am I doing with my life
FROM alpine:3.22.1 as TownyZip

RUN apk add --no-cache zip unzip
ADD https://github.com/TownyAdvanced/Towny/releases/download/0.101.2.0/Towny.Advanced.0.101.2.0.zip /home/app/Towny.zip
RUN unzip -j /home/app/Towny.zip -d /home/app

FROM itzg/minecraft-server

ADD --chown=1000:1000 https://hangarcdn.papermc.io/plugins/Artillex-Studios/AxGraves/versions/1.22.3/PAPER/AxGraves-1.22.3.jar /plugins/
ADD --chown=1000:1000 https://hangarcdn.papermc.io/plugins/pop4959/Chunky/versions/1.4.40/PAPER/Chunky-Bukkit-1.4.40.jar /plugins/
ADD --chown=1000:1000 https://cdn.modrinth.com/data/s86X568j/versions/asaBBItO/ChunkyBorder-Bukkit-1.2.23.jar /plugins/
ADD --chown=1000:1000 https://hangarcdn.papermc.io/plugins/EngineHub/CraftBook/versions/5.0.0-beta-04/PAPER/craftbook-bukkit-5.0.0-beta-04.jar /plugins/
ADD --chown=1000:1000 https://mediafilez.forgecdn.net/files/6769/644/Dynmap-3.7-beta-10-spigot.jar /plugins/
ADD --chown=1000:1000 https://github.com/TownyAdvanced/Dynmap-Towny/releases/download/1.3.0/Dynmap-Towny-1.3.0.jar /plugins/
ADD --chown=1000:1000 https://github.com/EssentialsX/Essentials/releases/download/2.21.1/EssentialsX-2.21.1.jar /plugins/
ADD --chown=1000:1000 https://github.com/EssentialsX/Essentials/releases/download/2.21.1/EssentialsXChat-2.21.1.jar /plugins/
ADD --chown=1000:1000 https://github.com/EssentialsX/Essentials/releases/download/2.21.1/EssentialsXProtect-2.21.1.jar /plugins/
ADD --chown=1000:1000 https://github.com/EssentialsX/Essentials/releases/download/2.21.1/EssentialsXSpawn-2.21.1.jar /plugins/
ADD --chown=1000:1000 https://cdn.modrinth.com/data/BOtP88G0/versions/x9EDRdqn/GuiEngine-1.4.3.jar /plugins/
ADD --chown=1000:1000 https://download.luckperms.net/1595/bukkit/loader/LuckPerms-Bukkit-5.5.10.jar /plugins/
ADD --chown=1000:1000 https://hangarcdn.papermc.io/plugins/Flyte/PluginPortal/versions/2.2.2/PAPER/PluginPortal-2.2.2.jar /plugins/
ADD --chown=1000:1000 https://github.com/dmulloy2/ProtocolLib/releases/download/5.3.0/ProtocolLib.jar /plugins/

COPY --chown=1000:1000 --from=CoreProtectBuild /home/app/target/CoreProtect-*.jar /plugins/
COPY --chown=1000:1000 --from=TownyZip /home/app/*.jar /plugins/

ADD --chown=1000:1000 https://github.com/TownyAdvanced/TownyCultures/releases/download/2.0.3/TownyCultures-2.0.3.jar /plugins/
ADD --chown=1000:1000 https://github.com/TownyAdvanced/TownyProvinces/releases/download/2.2.0/TownyProvinces-2.2.0.jar /plugins/
ADD --chown=1000:1000 https://github.com/Vittorassi/TreeFella/releases/download/1.3/TreeFella-1.3.jar /plugins/
ADD --chown=1000:1000 https://github.com/MilkBowl/Vault/releases/download/1.7.3/Vault.jar /plugins/
ADD --chown=1000:1000 https://mediafilez.forgecdn.net/files/6201/343/worldguard-bukkit-7.0.13-dist.jar /plugins/
ADD --chown=1000:1000 https://cdn.modrinth.com/data/1u6JkXh5/versions/Jk1z2u7n/worldedit-bukkit-7.3.16.jar /plugins/

COPY ./plugins /plugins/

ENV TYPE=PAPER
ENV VERSION=1.21.4

