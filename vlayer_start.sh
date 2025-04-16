##安装git
sudo apt -y update
sudo apt install -y git
##安装bun
sudo apt install -y unzip
curl -fsSL https://bun.sh/install | bash
##安装Foundry
curl -L https://foundry.paradigm.xyz | bash
source /root/.bashrc
foundryup
##安装vlayerup
curl -SL https://install.vlayer.xyz | bash
source /root/.bashrc
vlayerup
# Install Viem & Project Setup
bun add viem
rm -rf bun.lockb node_modules
bun install

# Create a New Project (Change YOUR-PROJECT-NAME)
vlayer init TEST --template simple-web-proof
cd TEST
forge build

# Run Inside a Screen Session
screen -S vlayer
cd vlayer
nano .env.testnet.local

# Install Vlayer SDK & Run Prover
bun add @vlayer/sdk
