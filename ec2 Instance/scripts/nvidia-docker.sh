sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y gnupg
sudo mkdir -p /etc/systemd/system/docker.service.d
curl -fsSL https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -fsSL https://nvidia.github.io/nvidia-docker/ubuntu20.04/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update
sudo apt-get install -y docker-ce
sudo apt-get install -y nvidia-docker2
sudo systemctl restart docker
docker --version
dpkg -l | grep nvidia-docker
sudo docker info | grep "Runtimes"
