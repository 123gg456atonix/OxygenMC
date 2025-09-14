#!/bin/bash

ARCH=$([[ "$(uname -m)" == "x86_64" ]] && printf "amd64" || printf "arm64")

function display {
    echo -e "\e[31m
 ▒█████  ▒██   ██▒▓██   ██▓  ▄████ ▓█████  ███▄    █  ███▄ ▄███▓ ▄████▄  
▒██▒  ██▒▒▒ █ █ ▒░ ▒██  ██▒ ██▒ ▀█▒▓█   ▀  ██ ▀█   █ ▓██▒▀█▀ ██▒▒██▀ ▀█  
▒██░  ██▒░░  █   ░  ▒██ ██░▒██░▄▄▄░▒███   ▓██  ▀█ ██▒▓██    ▓██░▒▓█    ▄ 
▒██   ██░ ░ █ █ ▒   ░ ▐██▓░░▓█  ██▓▒▓█  ▄ ▓██▒  ▐▌██▒▒██    ▒██ ▒▓▓▄ ▄██▒
░ ████▓▒░▒██▒ ▒██▒  ░ ██▒▓░░▒▓███▀▒░▒████▒▒██░   ▓██░▒██▒   ░██▒▒ ▓███▀ ░
░ ▒░▒░▒░ ▒▒ ░ ░▓ ░   ██▒▒▒  ░▒   ▒ ░░ ▒░ ░░ ▒░   ▒ ▒ ░ ▒░   ░  ░░ ░▒ ▒  ░
  ░ ▒ ▒░ ░░   ░▒ ░ ▓██ ░▒░   ░   ░  ░ ░  ░░ ░░   ░ ▒░░  ░      ░  ░  ▒   
░ ░ ░ ▒   ░    ░   ▒ ▒ ░░  ░ ░   ░    ░      ░   ░ ░ ░      ░   ░        
    ░ ░   ░    ░   ░ ░           ░    ░  ░         ░        ░   ░ ░      
                   ░ ░                                          ░        
\e[0m"
}

function unix_args {
    echo -e "Detected Forge 1.17 or newer version. Setting up forge unix args."
    ln -sf libraries/net/minecraftforge/forge/*/unix_args.txt unix_args.txt
    rm -rf run.*
}

function create_config() {
    local type="$1"
    cat <<EOF >OxygenMC.yml
# DO NOT MODIFY OR DELETE THIS FILE! This contains everything for OxygenMC to know what software are you using. Modifying or deleting this file may result of making your server unbootable. Period.
software:
  type: $type
EOF
}

function prompt_eula_mc {
    local eula_file="eula.txt"
    echo -e "\e[36m○ Before installing, you must accept the Minecraft EULA.\e[0m"
    echo -e "\e[32m○ Do you accept the Minecraft EULA? (type 'y' to accept):\e[0m"
    read accept_eula_input
    accept_eula_input=$(echo "$accept_eula_input" | tr '[:upper:]' '[:lower:]') # Convert to lowercase
    if [[ "$accept_eula_input" == *y* || "$accept_eula_input" == *yes* ]]; then
        echo "eula=true" >"$eula_file"
        echo -e "\033[92m● EULA Has Been Accepted\e[0m"
    else
        echo -e "\e[31m● You Must Accept The EULA To Use This Server!\e[0m"
        exit 1
    fi
}

function online_mode {
    echo -e "\e[36m○ Do you want to enable online mode? (true/false):\e[0m"
    read true_false
    true_false=$(echo "$true_false" | tr '[:upper:]' '[:lower:]') # Convert to lowercase
    if [ "$true_false" == "true" ]; then
        sed -i "s|^online-mode=.*|online-mode=true|g" server.properties
        echo -e "\033[92m● Online Mode Enabled\e[0m"
    elif [ "$true_false" == "false" ]; then
        sed -i "s|^online-mode=.*|online-mode=false|g" server.properties
        echo -e "\033[92m● Online Mode Disabled\e[0m"
    else
        echo -e "\e[31m● ONLINE_MODE variable is not set to true or false. Please set it correctly.\e[0m"
        exit 1
    fi
}

function port_assign {
    cat <<EOF >server.properties
motd=§x§5§4§D§A§F§4§l☲ §x§5§4§C§F§E§F§lᴏ§x§5§4§C§A§E§C§lx§x§5§4§C§4§E§9§lʏ§x§5§4§B§F§E§7§lɢ§x§5§4§B§A§E§4§lᴇ§x§5§4§B§4§E§1§lɴ §x§5§4§A§9§D§C§lᴍ§x§5§4§A§4§D§9§lᴄ §x§5§4§9§9§D§4§l☲ §x§5§4§8§F§C§E§l- §x§5§4§8§4§C§9§l1§x§5§4§7§E§C§6§l2§x§5§4§7§9§C§3§l3§x§5§4§7§4§C§1§lg§x§5§4§6§E§B§E§lg§x§5§4§6§9§B§B§l4§x§5§4§6§3§B§9§l5§x§5§4§5§E§B§6§l6\n§x§5§4§D§A§F§4§lʜ§x§5§4§D§6§F§2§lᴛ§x§5§4§D§1§F§0§lᴛ§x§5§4§C§D§E§D§lᴘ§x§5§4§C§8§E§B§ls§x§5§4§C§4§E§9§l:§x§5§4§B§F§E§7§l/§x§5§4§B§B§E§5§l/§x§5§4§B§7§E§2§lᴏ§x§5§4§B§2§E§0§lx§x§5§4§A§E§D§E§lʏ§x§5§4§A§9§D§C§lɢ§x§5§4§A§5§D§9§lᴇ§x§5§4§A§0§D§7§lɴ§x§5§4§9§C§D§5§lᴍ§x§5§4§9§8§D§3§lᴄ§x§5§4§9§3§D§1§l.§x§5§4§8§F§C§E§l1§x§5§4§8§A§C§C§l2§x§5§4§8§6§C§A§l3§x§5§4§8§1§C§8§lɢ§x§5§4§7§D§C§6§lɢ§x§5§4§7§9§C§3§l4§x§5§4§7§4§C§1§l5§x§5§4§7§0§B§F§l6§x§5§4§6§B§B§D§l.§x§5§4§6§7§B§A§lᴄ§x§5§4§6§2§B§8§lᴏ§x§5§4§5§E§B§6§lᴍ
server-port=$SERVER_PORT
query.port=$SERVER_PORT
server-ip=0.0.0.0
EOF
}


function forced_motd {
    sed -i "s|^motd=.*|motd=§x§5§4§D§A§F§4§l☲ §x§5§4§C§F§E§F§lᴏ§x§5§4§C§A§E§C§lx§x§5§4§C§4§E§9§lʏ§x§5§4§B§F§E§7§lɢ§x§5§4§B§A§E§4§lᴇ§x§5§4§B§4§E§1§lɴ §x§5§4§A§9§D§C§lᴍ§x§5§4§A§4§D§9§lᴄ §x§5§4§9§9§D§4§l☲ §x§5§4§8§F§C§E§l- §x§5§4§8§4§C§9§l1§x§5§4§7§E§C§6§l2§x§5§4§7§9§C§3§l3§x§5§4§7§4§C§1§lg§x§5§4§6§E§B§E§lg§x§5§4§6§9§B§B§l4§x§5§4§6§3§B§9§l5§x§5§4§5§E§B§6§l6\n§x§5§4§D§A§F§4§lʜ§x§5§4§D§6§F§2§lᴛ§x§5§4§D§1§F§0§lᴛ§x§5§4§C§D§E§D§lᴘ§x§5§4§C§8§E§B§ls§x§5§4§C§4§E§9§l:§x§5§4§B§F§E§7§l/§x§5§4§B§B§E§5§l/§x§5§4§B§7§E§2§lᴏ§x§5§4§B§2§E§0§lx§x§5§4§A§E§D§E§lʏ§x§5§4§A§9§D§C§lɢ§x§5§4§A§5§D§9§lᴇ§x§5§4§A§0§D§7§lɴ§x§5§4§9§C§D§5§lᴍ§x§5§4§9§8§D§3§lᴄ§x§5§4§9§3§D§1§l.§x§5§4§8§F§C§E§l1§x§5§4§8§A§C§C§l2§x§5§4§8§6§C§A§l3§x§5§4§8§1§C§8§lɢ§x§5§4§7§D§C§6§lɢ§x§5§4§7§9§C§3§l4§x§5§4§7§4§C§1§l5§x§5§4§7§0§B§F§l6§x§5§4§6§B§B§D§l.§x§5§4§6§7§B§A§lᴄ§x§5§4§6§2§B§8§lᴏ§x§5§4§5§E§B§6§lᴍ|g" server.properties
}

####################################
#        Start Functions           #
####################################

function launchVanillaServer {
    echo -e "\033[93m○ Checking if Java is up to date...\e[0m"
    install_java
    forced_motd
    echo -e "\033[92m● Starting Vanilla Server...\e[0m"
    java -Xms128M -XX:MaxRAMPercentage=95.0 -Dterminal.jline=false -Dterminal.ansi=true -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true $STARTUP_ARGUMENT -jar server.jar nogui
}

function launchJavaServer {
    echo -e "\033[93m○ Checking if Java is up to date...\e[0m"
    install_java
    forced_motd
    echo -e "\033[92m● Starting Minecraft Java Server...\e[0m"
    java -Xms128M -XX:MaxRAMPercentage=95.0 -Dterminal.jline=false -Dterminal.ansi=true -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true $STARTUP_ARGUMENT -jar server.jar nogui
}

function launchBedrockVanillaServer {
    echo -e "\033[92m● Starting Minecraft Bedrock Server...\e[0m"
    echo -e "Currently the bedrock install script is broken/not updated. If files not downloaded Please download the latest version of Bedrock vanilla from https://www.minecraft.net/en-us/download/server/bedrock "
    LD_LIBRARY_PATH=. ./bedrock_server
}

function launchProxyServer {
    echo -e "\033[93mo Checking is Java is up to date...\e[0m"
    install_java
    echo -e "\033[92m● Starting Minecraft Proxy Server...\e[0m"
    java -Xms128M -jar server.jar
}

####################################
#          Install Functions       #
####################################

function install_java {
    echo -e "\033[93m○ Installing/Checking Java version $JAVA_VERSION...\e[0m"
    if [ -z "$JAVA_VERSION" ]; then
        echo -e "\e[31m● Please specify the desired Java version using the JAVA_VERSION environment variable.\e[0m"
        exit 1
    fi
    if [ ! -d "$HOME/.sdkman" ]; then
        curl -s "https://get.sdkman.io" | bash >/dev/null 2>&1
    fi
    source "$HOME/.sdkman/bin/sdkman-init.sh"
    sdk update >/dev/null 2>&1
    sdk selfupdate
    case "$JAVA_VERSION" in
    8)
        JAVA_VERSION_S="8.0.422-tem"
        ;;
    11)
        JAVA_VERSION_S="11.0.24-tem"
        ;;
    17)
        JAVA_VERSION_S="17.0.12-tem"
        ;;
    21)
        JAVA_VERSION_S="21.0.4-tem"
        ;;
    22)
        JAVA_VERSION_S="22.0.2-tem"
        ;;
    *)
        echo -e "\e[31m● Unsupported Java version specified: $JAVA\e[0m"
        exit 1
        ;;
    esac
    if [ -z "$JAVA_VERSION_S" ]; then
        echo -e "\e[31m● Critical Error!\e[0m"
        exit 1
    fi
    if sdk current java | grep -q "$JAVA_VERSION"; then
    echo -e "\033[92m● Java $JAVA_VERSION is already installed.\e[0m"
    else
        echo -e "\033[93m○ Installing Java $JAVA_VERSION...\e[0m"
        if [ -n "$(sdk current java)" ]; then
            OLD_VERSION=$(sdk current java)
            echo -e "\033[93m○ Removing old Java version $OLD_VERSION...\e[0m"
            sdk uninstall java "$OLD_VERSION"
        fi
        sdk install java "$JAVA_VERSION_S"
        echo -e "\033[92m● Java $JAVA_VERSION installed successfully."
    fi
    export JAVA_HOME="$HOME/.sdkman/candidates/java/$JAVA_VERSION_S"
    export PATH="$JAVA_HOME/bin:$PATH"
}

function optimize_server {
    echo -e "\033[93m○ Do you want to optimize the server? (y/n)\e[0m"
    read optimize_input
    optimize_input=$(echo "$optimize_input" | tr '[:upper:]' '[:lower:]') # Convert to lowercase
    if [[ "$optimize_input" == *y* || "$optimize_input" == *yes* ]]; then
        echo -e "\033[93m○ Optimizing server...\e[0m"
        if [ ! -f "server.properties" ]; then
            echo -e "\e[31m● server.properties file not found. Cannot optimize.\e[0m"
            return
        fi
        sed -i "s|^view-distance=.*|view-distance=6|g" server.properties
        sed -i "s|^max-tick-time=.*|max-tick-time=60000|g" server.properties
        sed -i "s|^entity-activation-range=.*|entity-activation-range=32|g" server.properties
        sed -i "s|^tick-inactive-villagers=.*|tick-inactive-villagers=false|g" server.properties
        sed -i "s|^max-players=.*|max-players=10|g" server.properties
        if [ ! -d "$HOME/plugins" ]; then
        mkdir -p $HOME/plugins
        echo -e "\033[93m○ Adding Hibernate.jar...\e[0m"
        curl -o $HOME/plugins/Hibernate.jar https://raw.githubusercontent.com/123gg456atonix/OxygenMC/refs/heads/main/public/Hibernate.jar
        else 
        echo -e "\033[93m○ Adding Hibernate.jar...\e[0m"
        curl -o $HOME/plugins/Hibernate.jar https://raw.githubusercontent.com/123gg456atonix/OxygenMC/refs/heads/main/public/Hibernate.jar
        fi
        echo -e "\033[92m● Server optimized successfully.\e[0m"
    else
        echo -e "\033[93m○ Skipping optimization.\e[0m"
    fi
}

function install_vanilla {
    echo -e "\033[93m○ Downloading Vanilla Server...\e[0m"
    jar_url=$(curl --silent --request GET --header 'Authorization: 6d8c118f50aad5ef0362060dc526e49b5247cc1bd89272c0c5b3512cd0fbcad8' --url "https://versions.mcjars.app/api/v2/builds/VANILLA/$vanilla" | jq -r '.builds[0].jarUrl')
    curl -o server.jar "$jar_url"
    create_config "mc_java_vanilla"
    port_assign
    echo -e "\033[92m● Installation Completed!\e[0m"
    install_java
    clear
    display
    online_mode
    launchVanillaServer
    exit
}

function install_paper {
    echo -e "\033[93m○ Downloading Paper Server...\e[0m"
    jar_url=$(curl --silent --request GET --header 'Authorization: 6d8c118f50aad5ef0362060dc526e49b5247cc1bd89272c0c5b3512cd0fbcad8' --url "https://versions.mcjars.app/api/v2/builds/PAPER/$paper" | jq -r '.builds[0].jarUrl')
    curl -o server.jar "$jar_url"
    create_config "mc_java_paper"
    port_assign
    echo -e "\033[92m● Installation Completed!\e[0m"
    install_java
    clear
    display
    optimize_server
    online_mode
    launchJavaServer
    exit
}

function install_purpur {
    echo -e "\033[93m○ Downloading Purpur Server...\e[0m"
    jar_url=$(curl --silent --request GET --header 'Authorization: 6d8c118f50aad5ef0362060dc526e49b5247cc1bd89272c0c5b3512cd0fbcad8' --url "https://versions.mcjars.app/api/v2/builds/PURPUR/$purpur" | jq -r '.builds[0].jarUrl')
    curl -o server.jar "$jar_url"
    create_config "mc_java_purpur"
    port_assign
    echo -e "\033[92m● Installation Completed!\e[0m"
    install_java
    clear
    display
    optimize_server
    online_mode
    launchJavaServer
    exit
}

function install_fabric {
    echo -e "\033[93m○ Downloading Fabric Server...\e[0m"
    jar_url=$(curl --silent --request GET --header 'Authorization: 6d8c118f50aad5ef0362060dc526e49b5247cc1bd89272c0c5b3512cd0fbcad8' --url "https://versions.mcjars.app/api/v2/builds/FABRIC/$fabric" | jq -r '.builds[0].jarUrl')
    curl -o server.jar "$jar_url"
    create_config "mc_java_fabric"
    port_assign
    echo -e "\033[92m● Installation Completed!\e[0m"
    install_java
    clear
    display
    online_mode
    launchJavaServer
    exit
}

function install_forge {
    echo -e "\033[93m○ Downloading Forge Server...\e[0m"
    jar_url=$(curl --silent --request GET --header 'Authorization: 6d8c118f50aad5ef0362060dc526e49b5247cc1bd89272c0c5b3512cd0fbcad8' --url "https://versions.mcjars.app/api/v2/builds/FORGE/$forge" | jq -r '.builds[0].zipUrl')
    curl -o server.jar.zip "$jar_url"
    unzip -o server.jar.zip
    rm -f server.jar.zip
    create_config "mc_java_forge"
    port_assign
    echo -e "\033[92m● Installation Completed!\e[0m"
    install_java
    clear
    display
    online_mode
    launchJavaServer
    exit
}

function install_bungee {
    echo -e "\033[93m○ Downloading Bungeecord Server...\e[0m"
        jar_url=$(curl --silent --request GET --header 'Authorization: 6d8c118f50aad5ef0362060dc526e49b5247cc1bd89272c0c5b3512cd0fbcad8' --url "https://versions.mcjars.app/api/v2/builds/BUNGEECORD/$cord" | jq -r '.builds[0].jarUrl')
    curl -o server.jar "$jar_url"
    create_config "mc_proxy_cord"
    echo -e "\033[92m● Installation Completed!\e[0m"
    install_java
    clear
    display
    launchProxyServer
    exit
}

function install_bedrock {
    #!/bin/bash
    echo -e "\033[93m○ Downloading and Installing Required Softwares...\e[0m"
        # Minecraft CDN Akamai blocks script user-agents
    RANDVERSION=$(echo $((1 + $RANDOM % 4000)))
    if [ -z "${BEDROCK_VERSION}" ] || [ "${BEDROCK_VERSION}" == "latest" ]; then
        echo -e "\n Downloading latest Bedrock Server"
        curl -L -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.$RANDVERSION.212 Safari/537.36" -H "Accept-Language: en" -H "Accept-Encoding: gzip, deflate" -o versions.html.gz https://www.minecraft.net/en-us/download/server/bedrock
        DOWNLOAD_URL=$(zgrep -o 'https://www.minecraft.net/bedrockdedicatedserver/bin-linux/[^"]*' versions.html.gz)
    else
        echo -e "\n Downloading ${BEDROCK_VERSION} Bedrock Server"
        DOWNLOAD_URL=https://www.minecraft.net/bedrockdedicatedserver/bin-linux/bedrock-server-1.21.102.1.zip
    fi
    DOWNLOAD_FILE=$(echo ${DOWNLOAD_URL} | cut -d"/" -f5) # Retrieve archive name
    #echo -e "backing up config files"
    
    rm -rf *.bak versions.html.gz
    echo -e "\033[93m○ Installing Vanilla Bedrock Server"
    curl -L -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.$RANDVERSION.212 Safari/537.36" -H "Accept-Language: en" -o $DOWNLOAD_FILE $DOWNLOAD_URL
    echo -e "Unpacking server files"
    unzip -o $DOWNLOAD_FILE
    echo -e "\033[93m○ Cleaning up after installing\e[0m"
    echo -e "\033[93m○ Restoring backup config files - on first install there will be file not found errors which you can ignore.\e[0m"
    cp -rf server.properties.bak server.properties
    cp -rf permissions.json.bak permissions.json
    cp -rf allowlist.json.bak allowlist.json
    sed -i "s|^server-port=.*|server-port="$SERVER_PORT"|g" server.properties
    sed -i "s|^server-name=.*|server-name="OxygenMC Multi-egg https://discord.gg/XrqErRqXCu"|g" server.properties
    rm -rf *.bak
    rm -rf *.txt
    chmod +x bedrock_server
    create_config "mc_bedrock_vanilla"
    echo -e "\033[92mInstall Completed\e[0m"
    display
    launchBedrockVanillaServer
    exit
}

function main_menu {
    clear
    display
    echo -e "\e[36m● Select the server type:\e[0m"
    echo -e "\e[32m1) Minecraft Java\e[0m"
    echo -e "\e[32m2) Minecraft Bedrock\e[0m"
    echo -e "\e[32m3) Minecraft Proxy\e[0m"
    echo -e "\e[31m4) Exit"
}

function minecraft_menu {
    while true; do
        clear
        display
        echo -e "\e[36m● Select your Java server:\e[0m"
        echo -e "\e[32m1) Vanilla  \e[90m(1.21.8 - 1.2.5)\e[0m"
        echo -e "\e[32m2) Paper  \e[90m(1.21.8 - 1.8.8)\e[0m"
        echo -e "\e[32m3) Purpur \e[90m(1.21.8 - 1.14.1)\e[0m"
        echo -e "\e[32m4) Fabric  \e[90m(1.21.8 - 1.14)\e[0m"
        echo -e "\e[32m5) Forge  \e[90m(1.21.8 - 1.6.2)\e[0m"
        echo -e "\e[31m6) Back\e[0m"

        read mcsoft

        case $mcsoft in
        1)
            clear
            display
            echo -e "\e[36m● Select the Vanilla version you want to use:\e[0m"
            echo -e "\e[32m→ 1.21.8 - 1.21 , 1.20.6 - 1.20, 1.19.4 - 1.19, 1.18.2 - 1.18, 1.17.1 - 1.17, 1.16.5 - 1.16, 1.15.2 - 1.15, 1.14.4 - 1.14, 1.13.2 - 1.13, 1.12.2 - 1.12, 1.11.2 - 1.11, 1.10.2 - 1.10, 1.9.4 - 1.9, 1.8.9 - 1.8, 1.7.10 - 1.7.2, 1.6.4, 1.6.2, 1.6.1, 1.5.2, 1.5.1, 1.4.7 - 1.4.4, 1.4.2, 1.3.2, 1.3.1, 1.2.5  \e[0m"
            read -r input_version
            valid_versions="1.21.8 1.21.7 1.21.6 1.21.5 1.21.4 1.21.3 1.21.2 1.21.1 1.21 1.20.6 1.20.5 1.20.4 1.20.3 1.20.2 1.20.1 1.20 1.19.4 1.19.3 1.19.2 1.19.1 1.19 1.18.2 1.18.1 1.18 1.17.1 1.17 1.16.5 1.16.4 1.16.3 1.16.2 1.16.1 1.16 1.15.2 1.15.1 1.15 1.14.4 1.14.3 1.14.2 1.14.1 1.14 1.13.2 1.13.1 1.13 1.12.2 1.12.1 1.12 1.11.2 1.11 1.10.2 1.10 1.9.4 1.9.3 1.9.2 1.9.1 1.9 1.8.9 1.8.8 1.8.7 1.8.6 1.8.5 1.8.4 1.8.3 1.8.2 1.8.1 1.8 1.7.10 1.7.9 1.7.8 1.7.7 1.7.6 1.7.5 1.7.4 1.7.3 1.7.2 1.6.4 1.6.2 1.6.1 1.5.2 1.5.1 1.4.7 1.4.6 1.4.5 1.4.4 1.4.2 1.3.2 1.3.1 1.2.5"

            # Check if the input version is in the list of valid versions
            if [[ $valid_versions =~ (^|[[:space:]])$input_version($|[[:space:]]) ]]; then
                vanilla="$input_version"
                prompt_eula_mc
                install_vanilla
            else
               echo -e "\e[31m● The specified version is either invalid or deprecated.\e[0m"
            fi
            ;;
        2)
            clear
            display
            echo -e "\e[36m● Select the Paper version you want to use:\e[0m"
            echo -e "\e[32m→ 1.21.8, 1.21.7, 1.21.6, 1.21.5, 1.21.4, 1.21.3, 1.21.1, 1.21, 1.20.6, 1.20.5, 1.20.4, 1.20.2, 1.20.1, 1.20, 1.19.4, 1.19.3, 1.19.2, 1.19.1, 1.19, 1.18.2, 1.18.1, 1.18, 1.17.1, 1.17, 1.16.5, 1.16.4, 1.16.3, 1.16.2, 1.16.1, 1.15.2, 1.15.1, 1.15, 1.14.4, 1.14.3, 1.14.2, 1.14.1, 1.14, 1.13.2, 1.13.1, 1.13, 1.12.2, 1.12.1, 1.12, 1.11.2, 1.10.2, 1.9.4, 1.8.8, 1.7.10\e[0m"
            read -r input_version
            valid_versions="1.21.8 1.21.7 1.21.6 1.21.5 1.21.4 1.21.3 1.21.2 1.21.1 1.21 1.20.6 1.20.5 1.20.4 1.20.3 1.20.2 1.20.1 1.20 1.19.4 1.19.3 1.19.2 1.19.1 1.19 1.18.2 1.18.1 1.18 1.17.1 1.17 1.16.5 1.16.4 1.16.3 1.16.2 1.16.1 1.16 1.15.2 1.15.1 1.15 1.14.4 1.14.3 1.14.2 1.14.1 1.14 1.13.2 1.13.1 1.13 1.12.2 1.12.1 1.12 1.11.2 1.10.2 1.9.4 1.8.8 1.7.10"

            # Check if the input version is in the list of valid versions
            if [[ $valid_versions =~ (^|[[:space:]])$input_version($|[[:space:]]) ]]; then
                paper="$input_version"
                prompt_eula_mc
                install_paper
            else
               echo -e "\e[31m● The specified version is either invalid or deprecated.\e[0m"
            fi
            ;;
        3)
            clear
            display
            echo -e "\e[36m● Select the Purpur version you want to use:\e[0m"
            echo -e "\e[32m→1.21.8, 1.21.7, 1.21.6, 1.21.5, 1.21.4, 1.21.3, 1.21.1, 1.21, 1.20.6, 1.20.4, 1.20.2, 1.20.1, 1.20, 1.19.4, 1.19.3, 1.19.2, 1.19.1, 1.19, 1.18.2, 1.18.1, 1.18, 1.17.1, 1.17, 1.16.5, 1.16.4, 1.16.3, 1.16.2, 1.16.1, 1.15.2, 1.15.1, 1.15, 1.14.4, 1.14.3, 1.14.2, 1.14.1\e[0m"
            read -r input_version
            valid_versions="1.21.8 1.21.7 1.21.6 1.21.5 1.21.4 1.21.3 1.21.2 1.21.1 1.21 1.20.6 1.20.5 1.20.4 1.20.3 1.20.2 1.20.1 1.20 1.19.4 1.19.3 1.19.2 1.19.1 1.19 1.18.2 1.18.1 1.18 1.17.1 1.17 1.16.5 1.16.4 1.16.3 1.16.2 1.16.1 1.16 1.15.2 1.15.1 1.15 1.14.4 1.14.3 1.14.2 1.14.1"
            if [[ $valid_versions =~ (^|[[:space:]])$input_version($|[[:space:]]) ]]; then
                purpur="$input_version"
                prompt_eula_mc
                install_purpur
            else
                echo -e "\e[31m● The specified version is either invalid or deprecated.\e[0m"
            fi
            ;;
        4)
            clear
            display
            echo -e "\e[36m● Select the Fabric version you want to use:\e[0m"
            echo -e "\e[32m→ 1.21.8 - 1.21 , 1.20.6 - 1.20, 1.19.4 - 1.19, 1.18.2 - 1.18, 1.17.1 - 1.17, 1.16.5 - 1.16, 1.15.2 - 1.15, 1.14.4 - 1.14\e[0m"
            read -r input_version
            valid_versions="1.21.8 1.21.7 1.21.6 1.21.5 1.21.4 1.21.3 1.21.2 1.21.1 1.21 1.20.6 1.20.5 1.20.4 1.20.3 1.20.2 1.20.1 1.20 1.19.4 1.19.3 1.19.2 1.19.1 1.19 1.18.2 1.18.1 1.18 1.17.1 1.17 1.16.5 1.16.4 1.16.3 1.16.2 1.16.1 1.16 1.15.2 1.15.1 1.15 1.14.4 1.14.3 1.14.2 1.14.1 1.14"

            # Check if the input version is in the list of valid versions
            if [[ $valid_versions =~ (^|[[:space:]])$input_version($|[[:space:]]) ]]; then
                fabric="$input_version"
                prompt_eula_mc
                install_fabric
            else
               echo -e "\e[31m● The specified version is either invalid or deprecated.\e[0m"
            fi
            ;;
        5)
            clear
            display
            echo -e "\e[36m● Select the Forge version you want to use:\e[0m"
            echo -e "\e[32m→ 1.21.8, 1.21.7, 1.21.6, 1.21.5, 1.21.4, 1.21.3, 1.21.1, 1.21, 1.20.6, 1.20.4, 1.20.2, 1.20.1, 1.20, 1.19.4, 1.19.3, 1.19.2, 1.19.1, 1.19, 1.18.2, 1.18.1, 1.18, 1.17.1, 1.16.5, 1.16.4, 1.16.3, 1.16.2, 1.16.1, 1.15.2, 1.15.1, 1.15, 1.14.4, 1.14.3, 1.14.2, 1.13.2, 1.12.2, 1.12.1, 1.12, 1.11.2, 1.11, 1.10.2, 1.10, 1.9.4, 1.9, 1.8.9, 1.8.8, 1.8, 1.7.10, 1.7.2, 1.6.4, 1.6.2\e[0m"
            read -r input_version
            valid_versions="1.21.8 1.21.7 1.21.6 1.21.5 1.21.4 1.21.3 1.21.1 1.21 1.20.6 1.20.4 1.20.2 1.20.1 1.20 1.19.4 1.19.3 1.19.2 1.19.1 1.19 1.18.2 1.18.1 1.18 1.17.1 1.16.5 1.16.4 1.16.3 1.16.2 1.16.1 1.15.2 1.15.1 1.15 1.14.4 1.14.3 1.14.2 1.13.2 1.12.2 1.12.1 1.12 1.11.2 1.11 1.10.2 1.10 1.9.4 1.9 1.8.9 1.8.8 1.8 1.7.10 1.7.2 1.6.4 1.6.2"

            # Check if the input version is in the list of valid versions
            if [[ $valid_versions =~ (^|[[:space:]])$input_version($|[[:space:]]) ]]; then
                forge="$input_version"
                prompt_eula_mc
                install_forge
            else
               echo -e "\e[31m● The specified version is either invalid or deprecated.\e[0m"
            fi
            ;;
        6)
            break
            ;;
        *)
            echo -e "\e[31m● Invalid choice. Please try again.\e[0m"
            ;;
        esac
    done
}

function bedrock_menu {
    while true; do
        clear
        display
        echo -e "\e[36m● Select your Bedrock server:\e[0m"
        echo -e "\e[32m1) Vanilla Bedrock\e[0m"
        echo -e "\e[31m2) Back\e[0m"

        read bdsoft

        case $bdsoft in
        1)
            install_bedrock
            ;;
        2)
            break
            ;;
        *)
            echo -e "\e[31m● Invalid choice. Please try again.\e[0m"
            ;;
        esac
    done
}

function ProxyMenu {
        while true; do
        clear
        display
        echo -e "\e[36m● Select your Proxy server:\e[0m"
        echo -e "\e[32m1) Bungeecord\e[0m"
        echo -e "\e[31m2) Back\e[0m"

        read pssoft

        case $pssoft in
        1)
            clear
            display
            echo -e "\e[36m● Select the Bungeecord version you want to use:\e[0m"
            echo -e "\e[32m→ 1.21, 1.20, 1.19, 1.18, 1.17, 1.16, 1.15, 1.14, 1.13, 1.12, 1.11, 1.10, 1.9, 1.8, 1.7, 1.6.4, 1.6.2, 1.6.1, 1.5, 1.4.7, 1.0 [0m"
            read -r input_version
            valid_versions="1.21 1.20 1.19 1.18 1.17 1.16 1.15 1.14 1.13 1.12 1.11 1.10 1.9 1.8 1.7 1.6.4 1.6.2 1.6.1 1.5 1.4.7 1.0"

            # Check if the input version is in the list of valid versions
            if [[ $valid_versions =~ (^|[[:space:]])$input_version($|[[:space:]]) ]]; then
                cord="$input_version"
                prompt_eula_mc
                install_bungee
            else
               echo -e "\e[31m● The specified version is either invalid or deprecated.\e[0m"
            fi
            ;;
        *)
            echo -e "\e[31m● Invalid choice. Please try again.\e[0m"
            ;;
        esac
    done

}

function check_config {
    if [ -e "OxygenMC.yml" ]; then
        type=$(grep -A3 'type:' OxygenMC.yml | tail -n1 | awk '{ print $2}')

        if [ -n "$type" ]; then
            case "$type" in
            mc_bedrock_vanilla)
                clear
                display
                launchBedrockVanillaServer
                exit
                ;;
            mc_java_vanilla)
                clear
                display
                launchVanillaServer
                exit
                ;;
            mc_proxy_cord)
                clear
                display
                launchProxyServer
                exit
                ;;
            mc_java | mc_java_paper | mc_java_purpur | mc_java_fabric | mc_java_forge)
                clear
                display
                case "$type" in
                mc_java | mc_java_paper | mc_java_purpur | mc_java_fabric | mc_java_forge)
                    launchJavaServer
                    ;;
                esac
                exit
                ;;
            *)
                echo -e "\e[31m● Invalid system configuration type specified in OxygenMC.yml.\e[0m"
                exit 1
                ;;
            esac
        fi
        echo -e "\e[31m● Invalid system configuration file.\e[0m"
        exit 1
    fi
}

####################################
#          Main Script             #
####################################
function main {
    check_config
    while true; do
        main_menu
        read type

        case $type in
        1)
            minecraft_menu
            ;;
        2)
            bedrock_menu
            ;;
        3)
            ProxyMenu
            ;;
        4)
            exit 0
            ;;
        *)
            echo -e "\e[31m● Invalid choice. Please try again.\e[0m"
            ;;
        esac
    done
}

main