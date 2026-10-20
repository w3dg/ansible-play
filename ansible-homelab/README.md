# Ansible Home Lab (Docker)

A local Docker environment simulating two Raspberry Pis (`berry1`, `berry2`) with an Ansible control node.

## Requirements

- Docker + Docker Compose

## Quickstart

```bash
# 1. Run the setup script (generates SSH keys, starts containers)
./start.sh

# 2. Verify connectivity
docker compose exec control ansible all -m ping

# 3. Run the playbook
docker compose exec control ansible-playbook /ansible/setup.yml
```

## Structure

```
.
├── docker-compose.yml
├── start.sh                  # one-shot setup script
├── ssh_keys/                 # auto-generated SSH keys (gitignore this!)
├── ansible/
│   ├── ansible.cfg
│   ├── inventory.ini         # berry1 + berry2 hosts
│   └── setup.yml             # the playbook
└── docker/
    ├── control/Dockerfile    # Ansible control node
    └── pi/Dockerfile         # Simulated Pi (SSH target)
```

## Useful Commands

| Command | Description |
|---|---|
| `docker compose exec control ansible all -m ping` | Ping all hosts |
| `docker compose exec control ansible-playbook /ansible/setup.yml` | Run playbook |
| `docker compose exec control bash` | Shell into control node |
| `docker compose exec berry1 bash` | Shell into berry1 |
| `docker compose down` | Tear everything down |
| `docker compose down --volumes --rmi all` | Full cleanup |

## Teardown

```bash
docker compose down
```
