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

function port_assign {
    cat <<EOF >server.properties
motd=            \u00A7x\u00A75\u00A74\u00A7D\u00A7A\u00A7F\u00A74\u00A7l☲ \u00A7x\u00A75\u00A74\u00A7C\u00A7F\u00A7E\u00A7F\u00A7lᴏ\u00A7x\u00A75\u00A74\u00A7C\u00A7A\u00A7E\u00A7C\u00A7lx\u00A7x\u00A75\u00A74\u00A7C\u00A74\u00A7E\u00A79\u00A7lʏ\u00A7x\u00A75\u00A74\u00A7B\u00A7F\u00A7E\u00A77\u00A7lɢ\u00A7x\u00A75\u00A74\u00A7B\u00A7A\u00A7E\u00A74\u00A7lᴇ\u00A7x\u00A75\u00A74\u00A7B\u00A74\u00A7E\u00A71\u00A7lɴ \u00A7x\u00A75\u00A74\u00A7A\u00A79\u00A7D\u00A7C\u00A7lᴍ\u00A7x\u00A75\u00A74\u00A7A\u00A74\u00A7D\u00A79\u00A7lᴄ \u00A7x\u00A75\u00A74\u00A79\u00A79\u00A7D\u00A74\u00A7l☲ \u00A7x\u00A75\u00A74\u00A78\u00A7F\u00A7C\u00A7E\u00A7l- \u00A7x\u00A75\u00A74\u00A78\u00A74\u00A7C\u00A79\u00A7l1\u00A7x\u00A75\u00A74\u00A77\u00A7E\u00A7C\u00A76\u00A7l2\u00A7x\u00A75\u00A74\u00A77\u00A79\u00A7C\u00A73\u00A7l3\u00A7x\u00A75\u00A74\u00A77\u00A74\u00A7C\u00A71\u00A7lg\u00A7x\u00A75\u00A74\u00A76\u00A7E\u00A7B\u00A7E\u00A7lg\u00A7x\u00A75\u00A74\u00A76\u00A79\u00A7B\u00A7B\u00A7l4\u00A7x\u00A75\u00A74\u00A76\u00A73\u00A7B\u00A79\u00A7l5\u00A7x\u00A75\u00A74\u00A75\u00A7E\u00A7B\u00A76\u00A7l6\u00A7r\n    \u00A7x\u00A75\u00A74\u00A7D\u00A7A\u00A7F\u00A74\u00A7lJ\u00A7x\u00A75\u00A74\u00A7D\u00A77\u00A7F\u00A72\u00A7lᴏ\u00A7x\u00A75\u00A74\u00A7D\u00A74\u00A7F\u00A71\u00A7lɪ\u00A7x\u00A75\u00A74\u00A7D\u00A70\u00A7E\u00A7F\u00A7lɴ \u00A7x\u00A75\u00A74\u00A7C\u00A7A\u00A7E\u00A7C\u00A7ld\u00A7x\u00A75\u00A74\u00A7C\u00A77\u00A7E\u00A7A\u00A7li\u00A7x\u00A75\u00A74\u00A7C\u00A74\u00A7E\u00A79\u00A7ls\u00A7x\u00A75\u00A74\u00A7C\u00A71\u00A7E\u00A77\u00A7lc\u00A7x\u00A75\u00A74\u00A7B\u00A7D\u00A7E\u00A76\u00A7lo\u00A7x\u00A75\u00A74\u00A7B\u00A7A\u00A7E\u00A74\u00A7lr\u00A7x\u00A75\u00A74\u00A7B\u00A77\u00A7E\u00A73\u00A7ld\u00A7x\u00A75\u00A74\u00A7B\u00A74\u00A7E\u00A71\u00A7l.\u00A7x\u00A75\u00A74\u00A7B\u00A71\u00A7D\u00A7F\u00A7lg\u00A7x\u00A75\u00A74\u00A7A\u00A7D\u00A7D\u00A7E\u00A7lg\u00A7x\u00A75\u00A74\u00A7A\u00A7A\u00A7D\u00A7C\u00A7l/\u00A7x\u00A75\u00A74\u00A7A\u00A77\u00A7D\u00A7B\u00A7ly\u00A7x\u00A75\u00A74\u00A7A\u00A74\u00A7D\u00A79\u00A7lJ\u00A7x\u00A75\u00A74\u00A7A\u00A71\u00A7D\u00A77\u00A7lS\u00A7x\u00A75\u00A74\u00A79\u00A7E\u00A7D\u00A76\u00A7lc\u00A7x\u00A75\u00A74\u00A79\u00A7A\u00A7D\u00A74\u00A7lq\u00A7x\u00A75\u00A74\u00A79\u00A77\u00A7D\u00A73\u00A7lZ\u00A7x\u00A75\u00A74\u00A79\u00A74\u00A7D\u00A71\u00A7ls\u00A7x\u00A75\u00A74\u00A79\u00A71\u00A7C\u00A7F\u00A7lQ\u00A7x\u00A75\u00A74\u00A78\u00A7E\u00A7C\u00A7E\u00A7lg\u00A7x\u00A75\u00A74\u00A78\u00A7B\u00A7C\u00A7C\u00A7lV \u00A7x\u00A75\u00A74\u00A78\u00A74\u00A7C\u00A79\u00A7lꜰ\u00A7x\u00A75\u00A74\u00A78\u00A71\u00A7C\u00A77\u00A7lᴏ\u00A7x\u00A75\u00A74\u00A77\u00A7E\u00A7C\u00A76\u00A7lʀ \u00A7x\u00A75\u00A74\u00A77\u00A77\u00A7C\u00A73\u00A7lᴍ\u00A7x\u00A75\u00A74\u00A77\u00A74\u00A7C\u00A71\u00A7lᴏ\u00A7x\u00A75\u00A74\u00A77\u00A71\u00A7C\u00A70\u00A7lʀ\u00A7x\u00A75\u00A74\u00A76\u00A7E\u00A7B\u00A7E\u00A7lᴇ \u00A7x\u00A75\u00A74\u00A76\u00A78\u00A7B\u00A7B\u00A7lɪ\u00A7x\u00A75\u00A74\u00A76\u00A74\u00A7B\u00A79\u00A7lɴ\u00A7x\u00A75\u00A74\u00A76\u00A71\u00A7B\u00A78\u00A7lꜰ\u00A7x\u00A75\u00A74\u00A75\u00A7E\u00A7B\u00A76\u00A7lᴏ
server-port=$SERVER_PORT
query.port=$SERVER_PORT
EOF
}


function forced_motd {
    sed -i "s|^motd=.*|motd=            \u00A7x\u00A75\u00A74\u00A7D\u00A7A\u00A7F\u00A74\u00A7l☲ \u00A7x\u00A75\u00A74\u00A7C\u00A7F\u00A7E\u00A7F\u00A7lᴏ\u00A7x\u00A75\u00A74\u00A7C\u00A7A\u00A7E\u00A7C\u00A7lx\u00A7x\u00A75\u00A74\u00A7C\u00A74\u00A7E\u00A79\u00A7lʏ\u00A7x\u00A75\u00A74\u00A7B\u00A7F\u00A7E\u00A77\u00A7lɢ\u00A7x\u00A75\u00A74\u00A7B\u00A7A\u00A7E\u00A74\u00A7lᴇ\u00A7x\u00A75\u00A74\u00A7B\u00A74\u00A7E\u00A71\u00A7lɴ \u00A7x\u00A75\u00A74\u00A7A\u00A79\u00A7D\u00A7C\u00A7lᴍ\u00A7x\u00A75\u00A74\u00A7A\u00A74\u00A7D\u00A79\u00A7lᴄ \u00A7x\u00A75\u00A74\u00A79\u00A79\u00A7D\u00A74\u00A7l☲ \u00A7x\u00A75\u00A74\u00A78\u00A7F\u00A7C\u00A7E\u00A7l- \u00A7x\u00A75\u00A74\u00A78\u00A74\u00A7C\u00A79\u00A7l1\u00A7x\u00A75\u00A74\u00A77\u00A7E\u00A7C\u00A76\u00A7l2\u00A7x\u00A75\u00A74\u00A77\u00A79\u00A7C\u00A73\u00A7l3\u00A7x\u00A75\u00A74\u00A77\u00A74\u00A7C\u00A71\u00A7lg\u00A7x\u00A75\u00A74\u00A76\u00A7E\u00A7B\u00A7E\u00A7lg\u00A7x\u00A75\u00A74\u00A76\u00A79\u00A7B\u00A7B\u00A7l4\u00A7x\u00A75\u00A74\u00A76\u00A73\u00A7B\u00A79\u00A7l5\u00A7x\u00A75\u00A74\u00A75\u00A7E\u00A7B\u00A76\u00A7l6\u00A7r\n    \u00A7x\u00A75\u00A74\u00A7D\u00A7A\u00A7F\u00A74\u00A7lJ\u00A7x\u00A75\u00A74\u00A7D\u00A77\u00A7F\u00A72\u00A7lᴏ\u00A7x\u00A75\u00A74\u00A7D\u00A74\u00A7F\u00A71\u00A7lɪ\u00A7x\u00A75\u00A74\u00A7D\u00A70\u00A7E\u00A7F\u00A7lɴ \u00A7x\u00A75\u00A74\u00A7C\u00A7A\u00A7E\u00A7C\u00A7ld\u00A7x\u00A75\u00A74\u00A7C\u00A77\u00A7E\u00A7A\u00A7li\u00A7x\u00A75\u00A74\u00A7C\u00A74\u00A7E\u00A79\u00A7ls\u00A7x\u00A75\u00A74\u00A7C\u00A71\u00A7E\u00A77\u00A7lc\u00A7x\u00A75\u00A74\u00A7B\u00A7D\u00A7E\u00A76\u00A7lo\u00A7x\u00A75\u00A74\u00A7B\u00A7A\u00A7E\u00A74\u00A7lr\u00A7x\u00A75\u00A74\u00A7B\u00A77\u00A7E\u00A73\u00A7ld\u00A7x\u00A75\u00A74\u00A7B\u00A74\u00A7E\u00A71\u00A7l.\u00A7x\u00A75\u00A74\u00A7B\u00A71\u00A7D\u00A7F\u00A7lg\u00A7x\u00A75\u00A74\u00A7A\u00A7D\u00A7D\u00A7E\u00A7lg\u00A7x\u00A75\u00A74\u00A7A\u00A7A\u00A7D\u00A7C\u00A7l/\u00A7x\u00A75\u00A74\u00A7A\u00A77\u00A7D\u00A7B\u00A7ly\u00A7x\u00A75\u00A74\u00A7A\u00A74\u00A7D\u00A79\u00A7lJ\u00A7x\u00A75\u00A74\u00A7A\u00A71\u00A7D\u00A77\u00A7lS\u00A7x\u00A75\u00A74\u00A79\u00A7E\u00A7D\u00A76\u00A7lc\u00A7x\u00A75\u00A74\u00A79\u00A7A\u00A7D\u00A74\u00A7lq\u00A7x\u00A75\u00A74\u00A79\u00A77\u00A7D\u00A73\u00A7lZ\u00A7x\u00A75\u00A74\u00A79\u00A74\u00A7D\u00A71\u00A7ls\u00A7x\u00A75\u00A74\u00A79\u00A71\u00A7C\u00A7F\u00A7lQ\u00A7x\u00A75\u00A74\u00A78\u00A7E\u00A7C\u00A7E\u00A7lg\u00A7x\u00A75\u00A74\u00A78\u00A7B\u00A7C\u00A7C\u00A7lV \u00A7x\u00A75\u00A74\u00A78\u00A74\u00A7C\u00A79\u00A7lꜰ\u00A7x\u00A75\u00A74\u00A78\u00A71\u00A7C\u00A77\u00A7lᴏ\u00A7x\u00A75\u00A74\u00A77\u00A7E\u00A7C\u00A76\u00A7lʀ \u00A7x\u00A75\u00A74\u00A77\u00A77\u00A7C\u00A73\u00A7lᴍ\u00A7x\u00A75\u00A74\u00A77\u00A74\u00A7C\u00A71\u00A7lᴏ\u00A7x\u00A75\u00A74\u00A77\u00A71\u00A7C\u00A70\u00A7lʀ\u00A7x\u00A75\u00A74\u00A76\u00A7E\u00A7B\u00A7E\u00A7lᴇ \u00A7x\u00A75\u00A74\u00A76\u00A78\u00A7B\u00A7B\u00A7lɪ\u00A7x\u00A75\u00A74\u00A76\u00A74\u00A7B\u00A79\u00A7lɴ\u00A7x\u00A75\u00A74\u00A76\u00A71\u00A7B\u00A78\u00A7lꜰ\u00A7x\u00A75\u00A74\u00A75\u00A7E\u00A7B\u00A76\u00A7lᴏ|g" server.properties
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

####################################
#          Install Functions       #
####################################

function install_java {
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
# This is optional turn on if you want.

# function optimize_server {
#     if [ ! -d "$HOME/plugins" ]; then
#         mkdir -p $HOME/plugins
#     fi
#     echo -e "\033[93m○ Optimizing Server...\e[0m"
#     curl -o $HOME/plugins/Hibernate.jar https://raw.githubusercontent.com/divyamboii/BetterJavaEggs/refs/heads/main/Hibernate.jar
# }

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
    launchJavaServer
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
    echo -e "\e[31m3) Exit"
}

function minecraft_menu {
    while true; do
        clear
        display
        echo -e "\e[36m● Select your Java server:\e[0m"
        echo -e "\e[32m1) Vanilla  \e[90m(1.18 - 1.21.3)\e[0m"
        echo -e "\e[32m2) Paper  \e[90m(1.8.8 - 1.21.1)\e[0m"
        echo -e "\e[32m3) Purpur \e[90m(1.14.1 - 1.21.1)\e[0m"
        echo -e "\e[31m4) Back\e[0m"

        read mcsoft

        case $mcsoft in
        1)
            clear
            display
            echo -e "\e[36m● Select the Vanilla version you want to use:\e[0m"
            echo -e "\e[32m→ 1.18, 1.18.1, 1.18.2, 1.19, 1.19.1, 1.19.2, 1.19.3, 1.19.4, 1.20, 1.20.1, 1.20.2, 1.20.4, 1.20.5, 1.20.6, 1.21, 1.21.1, 1.21.2, 1.21.3\e[0m"
            read -r input_version
            valid_versions="1.18 1.18.1 1.18.2 1.19 1.19.1 1.19.2 1.19.3 1.19.4 1.20 1.20.1 1.20.2 1.20.4 1.20.5 1.20.6 1.21 1.21.1 1.21.2 1.21.3"

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
            echo -e "\e[32m→ 1.8.8, 1.9.4, 1.10.2, 1.11.2, 1.12.2, 1.13.2, 1.14.4, 1.15.2, 1.16.5, 1.17, 1.17.1, 1.18, 1.18.1, 1.18.2, 1.19, 1.19.1, 1.19.2, 1.19.3, 1.19.4, 1.20, 1.20.1, 1.20.2, 1.20.4, 1.20.5, 1.20.6, 1.21, 1.21.1\e[0m"
            read -r input_version
            valid_versions="1.8.8 1.9.4 1.10.2 1.11.2 1.12.2 1.13.2 1.14.4 1.15.2 1.16.5 1.17 1.17.1 1.18 1.18.1 1.18.2 1.19 1.19.1 1.19.2 1.19.3 1.19.4 1.20 1.20.1 1.20.2 1.20.4 1.20.5 1.20.6 1.21 1.21.1"

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
            echo -e "\e[32m→ 1.14.1, 1.14.2, 1.14.3, 1.14.4, 1.15, 1.15.1, 1.15.2, 1.16.1, 1.16.2, 1.16.3, 1.16.4, 1.16.5, 1.17, 1.17.1, 1.18, 1.18.1, 1.18.2, 1.19, 1.19.1, 1.19.2, 1.19.3, 1.19.4, 1.20, 1.20.1, 1.20.2, 1.20.4, 1.20.6, 1.21, 1.21.1\e[0m"
            read -r input_version
            valid_versions="1.14.1 1.14.2 1.14.3 1.14.4 1.15 1.15.1 1.15.2 1.16.1 1.16.2 1.16.3 1.16.4 1.16.5 1.17 1.17.1 1.18 1.18.1 1.18.2 1.19 1.19.1 1.19.2 1.19.3 1.19.4 1.20 1.20.1 1.20.2 1.20.4 1.20.6 1.21 1.21.1"
            if [[ $valid_versions =~ (^|[[:space:]])$input_version($|[[:space:]]) ]]; then
                purpur="$input_version"
                prompt_eula_mc
                install_purpur
            else
                echo -e "\e[31m● The specified version is either invalid or deprecated.\e[0m"
            fi
            ;;
        4)
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
            mc_java | mc_java_paper | mc_java_purpur)
                clear
                display
                case "$type" in
                mc_java | mc_java_paper | mc_java_purpur)
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
            exit 0
            ;;
        *)
            echo -e "\e[31m● Invalid choice. Please try again.\e[0m"
            ;;
        esac
    done
}

main