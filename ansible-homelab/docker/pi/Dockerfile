FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    openssh-server \
    python3 \
    sudo \
    vim \
    htop \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create the pi user with sudo access
RUN useradd -m -s /bin/bash pi \
    && echo "pi:raspberry" | chpasswd \
    && usermod -aG sudo pi \
    && echo "pi ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# SSH setup
RUN mkdir /var/run/sshd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config

# Create pi's .ssh dir for authorized keys
RUN mkdir -p /home/pi/.ssh && chown pi:pi /home/pi/.ssh && chmod 700 /home/pi/.ssh

EXPOSE 22
