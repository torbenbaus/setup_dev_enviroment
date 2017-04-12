#!/bin/bash

# bash script for installing complete dev enviroment

RUBY_VERSION=2.2.4
RUBY_VERSION=2.3.0
RAILS_VERSION=5.0.1

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
echo "========== Installing iTerm ==========="
echo "======================================="
echo ""

brew cask install iterm2
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
brew install zsh-syntax-highlighting


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
echo "======= Installing Node and npm ======="
echo "======================================="
echo ""
brew install node
node -v
npm -v

echo ""
echo "======================================="
echo "====== Installing Rbenv and Ruby ======"
echo "======================================="
echo ""
echo "Installing a ruby version manager: rbenv"
brew install readline
brew install rbenv ruby-build

# Add rbenv to bash so that it loads every time you open a terminal
echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile
source ~/.bash_profile

# Install Ruby
echo "Install newest ruby version $RUBY_VERSION"
rbenv install $RUBY_VERSION
rbenv install $SECOND_RUBY_VERSION
echo "Setting newest version of ruby for global use"
rbenv global $RUBY_VERSION
echo "Install bundler gem globally"
gem install bundler
echo "======================================="
ruby -v
bundle -v

echo "=========== Install Rails ============="
#!/usr/local/bin/bash
echo "Installing required libs for a rails dependency 'nokogiri'"
brew install libxml2 libxslt

echo "Installing nokogiri gem with OS X specific libxml2 and libxslt versions"
gem install nokogiri -- \
  --use-system-libraries \
  --with-xml2-include=/usr/local/opt/libxml2/include/libxml2 \
  --with-xml2-lib=/usr/local/opt/libxml2/lib \
  --with-xslt-dir=/usr/local/opt/libxslt/lib

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
echo "======= Installing PostgreSQL ========="
echo "======================================="
echo ""
brew install postgresql
brew services start postgresql
echo "======================================="
brew services list

echo ""
echo "======================================="
echo "========== Installing redis ==========="
echo "======================================="
echo ""
brew install redis
brew services start redis


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
echo "======================================="
aws --version
echo "======================================="
aws configure
echo "======================================="
aws iam list-users

echo ""
echo "======================================="
echo "========= Installing Docker ==========="
echo "======================================="
echo ""
brew cask install docker-toolbox
bash --login '/Applications/Docker/Docker Quickstart Terminal.app/Contents/Resources/Scripts/start.sh'

echo ""
echo "======================================="
echo "========= Installing Chrome ==========="
echo "======================================="
echo ""
brew cask install google-chrome
# source ~/.bashrc

echo ""
echo "======================================="
echo "========== Installing Slack ==========="
echo "======================================="
echo ""
brew cask install slack
# source ~/.bashr

echo ""
echo "======================================="
echo "====== Installing github-desktop ======"
echo "======================================="
echo ""
brew cask install github-desktop
echo ""
echo "======================================="
echo "           CONGRATULATIONS!            "
echo "        INSTALLATION COMPLETED!        "
echo ""
echo "You should do the following steps to be"
echo "ready to develop:"
echo ""
echo "Go to https://github.com/settings/keys and add the following key"
echo ""
cat ~/.ssh/id_rsa.pub
echo ""
echo "You can check it with check with $ ssh -T git@github.com"
echo "======================================="
echo ""