#!/bin/sh

echo "Starting Minecraft server..."

echo "Current directory: $(pwd)"

# Define the default jar URL
DEFAULT_JAR_URL="https://piston-data.mojang.com/v1/objects/450698d1863ab5180c25d7c804ef0fe6369dd1ba/server.jar"

# Use the JAR_URL environment variable if provided, otherwise use the default
JAR_URL=${JAR_URL:-$DEFAULT_JAR_URL}

# Check if the Minecraft server jar file exists
if [ ! -f ./minecraft_server.jar ]; then
  echo "Downloading Minecraft server jar file from $JAR_URL..."
  wget -O minecraft_server.jar $JAR_URL
else
  echo "Minecraft server jar file already exists."
fi

# Create server.properties from environment variables
cat <<EOL > ./server.properties
#Minecraft server properties
#$(date)
accepts-transfers=${ACCEPTS_TRANSFERS:-false}
allow-flight=${ALLOW_FLIGHT:-false}
allow-nether=${ALLOW_NETHER:-true}
broadcast-console-to-ops=${BROADCAST_CONSOLE_TO_OPS:-false}
broadcast-rcon-to-ops=${BROADCAST_RCON_TO_OPS:-false}
bug-report-link=${BUG_REPORT_LINK:-}
difficulty=${DIFFICULTY:-easy}
enable-command-block=${ENABLE_COMMAND_BLOCK:-false}
enable-jmx-monitoring=${ENABLE_JMX_MONITORING:-false}
enable-query=${ENABLE_QUERY:-false}
enable-rcon=${ENABLE_RCON:-true}
enable-status=${ENABLE_STATUS:-true}
enforce-secure-profile=${ENFORCE_SECURE_PROFILE:-true}
enforce-whitelist=${ENFORCE_WHITELIST:-false}
entity-broadcast-range-percentage=${ENTITY_BROADCAST_RANGE_PERCENTAGE:-100}
force-gamemode=${FORCE_GAMEMODE:-false}
function-permission-level=${FUNCTION_PERMISSION_LEVEL:-2}
gamemode=${GAMEMODE:-survival}
generate-structures=${GENERATE_STRUCTURES:-true}
generator-settings=${GENERATOR_SETTINGS:-{}}
hardcore=${HARDCORE:-false}
hide-online-players=${HIDE_ONLINE_PLAYERS:-false}
initial-disabled-packs=${INITIAL_DISABLED_PACKS:-}
initial-enabled-packs=${INITIAL_ENABLED_PACKS:-vanilla}
level-name=${LEVEL_NAME:-world}
level-seed=${LEVEL_SEED:-}
level-type=${LEVEL_TYPE:-minecraft\:normal}
log-ips=${LOG_IPS:-true}
max-chained-neighbor-updates=${MAX_CHAINED_NEIGHBOR_UPDATES:-1000000}
max-players=${MAX_PLAYERS:-20}
max-tick-time=${MAX_TICK_TIME:-60000}
max-world-size=${MAX_WORLD_SIZE:-29999984}
motd=${MOTD:-A Minecraft Server}
network-compression-threshold=${NETWORK_COMPRESSION_THRESHOLD:-256}
online-mode=${ONLINE_MODE:-true}
op-permission-level=${OP_PERMISSION_LEVEL:-4}
player-idle-timeout=${PLAYER_IDLE_TIMEOUT:-0}
prevent-proxy-connections=${PREVENT_PROXY_CONNECTIONS:-false}
pvp=${PVP:-true}
query.port=${QUERY_PORT:-25565}
rate-limit=${RATE_LIMIT:-0}
rcon.password=${RCON_PASSWORD:-password}
rcon.port=${RCON_PORT:-25575}
region-file-compression=${REGION_FILE_COMPRESSION:-deflate}
require-resource-pack=${REQUIRE_RESOURCE_PACK:-false}
resource-pack=${RESOURCE_PACK:-}
resource-pack-id=${RESOURCE_PACK_ID:-}
resource-pack-prompt=${RESOURCE_PACK_PROMPT:-}
resource-pack-sha1=${RESOURCE_PACK_SHA1:-}
server-ip=${SERVER_IP:-}
server-port=${SERVER_PORT:-25565}
simulation-distance=${SIMULATION_DISTANCE:-10}
spawn-animals=${SPAWN_ANIMALS:-true}
spawn-monsters=${SPAWN_MONSTERS:-true}
spawn-npcs=${SPAWN_NPCS:-true}
spawn-protection=${SPAWN_PROTECTION:-16}
sync-chunk-writes=${SYNC_CHUNK_WRITES:-true}
text-filtering-config=${TEXT_FILTERING_CONFIG:-}
use-native-transport=${USE_NATIVE_TRANSPORT:-true}
view-distance=${VIEW_DISTANCE:-10}
white-list=${WHITE_LIST:-false}
EOL

# Agree to the Minecraft EULA
echo "eula=true" > ./eula.txt

# Start the Minecraft server
cd $SERVER_PATH
java -Xmx${JAVA_XMX:-4096M} -Xms${JAVA_XMS:-1024M} -jar ./minecraft_server.jar nogui
