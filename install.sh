#/bin/bash

set -ex

# Install oh-my-zsh.
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || echo "No stdin"


# Install the spaceship theme.
ZSH_CUSTOM=~/.oh-my-zsh
echo $ZSH_CUSTOM
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

# Install syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install ruby
sudo apt-get update && sudo apt-get install -y ruby-full build-essential
sudo gem install colorls -v 1.2.0

cp ./.zshrc ~/.zshrc
mkdir -p ~/.config
cp -r ./colorls ~/.config/colorls