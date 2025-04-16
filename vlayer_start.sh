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
read -p "项目名称: " project_name
vlayer init $project_name --template simple-web-proof
cd $project_name
forge build

read -p "JWT token: " token
read -p "钱包私钥（带0x）: " private_key
# Run Inside a Screen Session
cd vlayer
##检查是否存在文件
if [ ! -f "/root/$project_name/.env.testnet.local" ]; then
    echo 'VLAYER_API_TOKEN=1
EXAMPLES_TEST_PRIVATE_KEY=1
CHAIN_NAME=optimismSepolia
JSON_RPC_URL=https://sepolia.optimism.io' > /root/$project_name/.env.testnet.local
fi

sed -i "s/VLAYER_API_TOKEN=.*$/VLAYER_API_TOKEN=$token/" .env.testnet.local
sed -i "s/EXAMPLES_TEST_PRIVATE_KEY=.*$/EXAMPLES_TEST_PRIVATE_KEY=$private_key/" .env.testnet.local
bun add @vlayer/sdk

# Install Vlayer SDK & Run Prover
# bun run prove:testnet
read -p "screen名称: " screen_name
screen -d -m -S $screen_name bash -c "cd /root/$project_name/vlayer && while true; do bun run prove:testnet; sleep 3600; done"
