# Init AI workflow on new environment
# Has to be executed with -E and sudo privileges
# Will dump trash into ~/temp

# Trash folder
cd ~/tmp

##### CUDA TOOLKITS 12.5
wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-wsl-ubuntu.pin
mv cuda-wsl-ubuntu.pin /etc/apt/preferences.d/cuda-repository-pin-600

wget https://developer.download.nvidia.com/compute/cuda/12.5.1/local_installers/cuda-repo-wsl-ubuntu-12-5-local_12.5.1-1_amd64.deb
dpkg -i cuda-repo-wsl-ubuntu-12-5-local_12.5.1-1_amd64.deb

cp /var/cuda-repo-wsl-ubuntu-12-5-local/cuda-*-keyring.gpg /usr/share/keyrings/
apt-get update
apt-get -y install cuda-toolkit-12-5

echo 'export PATH="/usr/local/cuda-12.5/bin:$PATH"' >> ~/.bash_path
echo ">> Cuda 12.5 installed, restart system"
