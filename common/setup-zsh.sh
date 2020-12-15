#!/bin/sh

apt-get install -y zsh tmux
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended"
wget https://gist.githubusercontent.com/nnarain/4c925a06290d5659d9d2a1391a77373a/raw/b4fef3b4a113677e47ab08cc98bd8cbc71d1a4dc/agnoster-newline.zsh-theme -O ~/.oh-my-zsh/themes/agnoster-newline.zsh-theme
sed -i 's/robbyrussell/agnoster-newline/g' ~/.zshrc

echo "source /opt/ros/${ROS_DISTRO}/setup.zsh"
echo "zsh" >> ~/.bashrc
