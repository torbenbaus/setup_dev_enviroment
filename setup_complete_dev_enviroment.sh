#!/bin/bash

# bash script for installing complete dev enviroment

RUBY_VERSION=2.4.0
RAILS_VERSION=5.0.1
GIT_USER_NAME="YOUR NAME"
GIT_USER_MAIL="YOUR@EMAIL.com"

clear

sudo echo ""; echo "Root Privilege Acquired"

echo ""
echo "======================================="
echo "=========== Installing Xcode =========="
echo "======================================="
echo ""
sudo xcode-select --install

read -rsp $'Press any key after manually installed xcode...\n' -n1 key
echo "======================================="
xcode-select -v

echo ""
echo "======================================="
echo "==== Installing Homebrew and Curl ====="
echo "======================================="
echo ""
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap caskroom/cask
brew doctor
brew install curl

echo ""
echo "======================================="
echo "==== Installing and configuring Git ==="
echo "======================================="
echo ""
brew install git
git config --global color.ui true
git config --global user.name $GIT_USER_NAME
git config --global user.email $GIT_USER_MAIL
ssh-keygen -t rsa -C $GIT_USER_MAIL

echo ""
echo "======================================="
echo "====== Installing Rbenv and Ruby ======"
echo "======================================="
echo ""
brew install rbenv ruby-build

# Add rbenv to bash so that it loads every time you open a terminal
echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile
source ~/.bash_profile

# Install Ruby
rbenv install $RUBY_VERSION
rbenv global $RUBY_VERSION
echo "======================================="
ruby -v
gem install bundler
echo "======================================="
bundle -v
gem install rails -v $RAILS_VERSION
rbenv rehash
echo "======================================="
rails -v

echo ""
echo "======================================="
echo "========== Installing MySQL ==========="
echo "======================================="
echo ""

brew install mysql
brew tap homebrew/services
brew services start mysql
echo "======================================="
brew services list


echo ""
echo "======================================="
echo "========== Installing MySQL ==========="
echo "======================================="
echo ""
brew install postgresql
brew services start postgresql
echo "======================================="
brew services list


echo ""
echo "======================================="
echo "======== Installing sequel pro ========"
echo "======================================="
echo ""
brew cask install sequel-pro

echo ""
echo "======================================="
echo "====== Installing Python and pip ======"
echo "======================================="
echo ""
curl -O https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py --user


echo ""
echo "======================================="
echo "========= Installing AWS CLI =========="
echo "======================================="
echo ""
pip3 install --user --upgrade awscli


echo ""
echo "======================================="
echo "========= Installing Docker ==========="
echo "======================================="
echo ""

echo ""
echo "======================================="
echo "========= Installing Chrome ==========="
echo "======================================="
echo ""
# source ~/.bashrc

echo ""
echo "======================================="
echo "           CONGRATULATIONS!            "
echo "        INSTALLATION COMPLETED!        "
echo ""
echo "You should do the following steps to be"
echo "ready to develop:"
echo "Go to https://github.com/settings/keys and add the following key"
cat ~/.ssh/id_rsa.pub
echo "You can check it with check with $ ssh -T git@github.com"
echo "======================================="
echo ""