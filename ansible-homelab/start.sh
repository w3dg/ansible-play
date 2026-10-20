#!/usr/bin/env bash
set -e

echo "🔧 Setting up Ansible Home Lab..."

# Generate SSH keys if they don't exist
if [ ! -f ./ssh_keys/id_rsa ]; then
  echo "🔑 Generating SSH key pair..."
  mkdir -p ./ssh_keys
  ssh-keygen -t rsa -b 2048 -f ./ssh_keys/id_rsa -N "" -q
  echo "   Keys written to ./ssh_keys/"
fi

# Start just the Pi containers first
echo "🐳 Starting Pi containers..."
docker compose up -d berry1 berry2
sleep 3

# Copy SSH public key to each Pi
echo "📋 Copying SSH key to berry1 and berry2..."
for host in berry1 berry2; do
  docker compose exec -T $host bash -c "
    mkdir -p /home/pi/.ssh &&
    echo '$(cat ./ssh_keys/id_rsa.pub)' >> /home/pi/.ssh/authorized_keys &&
    chown -R pi:pi /home/pi/.ssh &&
    chmod 600 /home/pi/.ssh/authorized_keys
  "
  echo "   ✅ $host ready"
done

# Now start the control node
echo "🚀 Starting Ansible control node..."
docker compose up -d control
sleep 2

echo ""
echo "✅ All done! To run the playbook:"
echo ""
echo "   docker compose exec control ansible-playbook /ansible/setup.yml"
echo ""
echo "To ping all hosts first:"
echo ""
echo "   docker compose exec control ansible all -m ping"
echo ""
echo "To tear everything down:"
echo ""
echo "   docker compose down"
