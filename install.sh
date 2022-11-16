sudo iptables -I INPUT 6 -m state --state NEW -p tcp --match multiport --dports 80,443,30000 -j ACCEPT
sudo netfilter-persistent save

curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs

node --version
npm --version

sudo npm install pm2 -g

pm2 --version

pm2 startup
sudo env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u ubuntu --hp /home/ubuntu

sudo apt-get install nano unzip -y

mkdir ~/foundry

wget --output-document ~/foundry/foundryvtt.zip "$1"

unzip ~/foundry/foundryvtt.zip -d ~/foundry/
rm ~/foundry/foundryvtt.zip

mkdir -p ~/foundryuserdata

node /home/ubuntu/foundry/resources/app/main.js --dataPath=/home/ubuntu/foundryuserdata

pm2 start "node /home/ubuntu/foundry/resources/app/main.js --dataPath=/home/ubuntu/foundryuserdata" --name foundry

pm2 list

pm2 save

sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
sudo apt update
sudo apt install caddy

file=

cat <<EOF > /etc/caddy/Caddyfile
# This replaces the existing content in /etc/caddy/Caddyfile

# A CONFIG SECTION FOR YOUR HOSTNAME
your.hostname.com {
    # PROXY ALL REQUEST TO PORT 30000
    reverse_proxy localhost:30000
    encode zstd gzip
}

# Refer to the Caddy docs for more information:
# https://caddyserver.com/docs/caddyfile


# Refer to the Caddy docs for more information:
# https://caddyserver.com/docs/caddyfile"
EOF

sudo service caddy restart

nano /home/ubuntu/foundryuserdata/Config/options.json