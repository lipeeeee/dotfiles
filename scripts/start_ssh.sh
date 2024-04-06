# Assume iwctl is configured
iwctl station wlan0 connect NOS-BADC-5

# Assume sshd service is setup
systemctl start sshd
systemctl status sshd

# Show ip address where ssh is being hosted on
ip address show
