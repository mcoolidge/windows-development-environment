#-------------------------------------------------------------------------------#
#                                                                               #
# This script installs all the stuff I need to develop the things I develop.    #
# Run PowerShell with admin priveleges, type `env-windows`, and go make coffee. #
#                                                                               #
#                                                                        -James #
#                                                                               #
#-------------------------------------------------------------------------------#

#
# Functions
#

function Update-Environment-Path
{
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") `
        + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

#
# Package Managers
#

# Choco
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
Invoke-WebRequest https://chocolatey.org/install.ps1 -UseBasicParsing | iex
Update-Environment-Path

#
# Git
#

choco install git --yes
choco install tortoisegit --yes
Update-Environment-Path
git config --global alias.pom 'pull origin master'
git config --global alias.last 'log -1 HEAD'
git config --global alias.ls "log --pretty=format:'%C(yellow)%h %ad%Cred%d %Creset%s%Cblue [%cn]' --decorate --date=short"
git config --global alias.ammend "commit -a --amend"
git config --global alias.standup "log --since yesterday --author $(git config user.email) --pretty=short"
git config --global alias.everything "! git pull && git submodule update --init --recursive"
git config --global alias.aliases "config --get-regexp alias"

#
# MinGW
# 

choco install mingw --yes
Update-Environment-Path

# Get-Command mingw32-make

# todo: Alias `make` to `mingw32-make` in Git Bash
# todo: Write `mingw32-make %*` to make.bat in MinGW install directory

#
# Caddy HTTP Server
#

choco install caddy --yes
Update-Environment-Path

#
# Languages
#
# choco install php --yes
# choco install ruby --yes
# choco install ruby2.devkit --yes
choco install python2 --yes
choco install jdk8 --yes
Update-Environment-Path

# Node
choco install nodejs.install --yes
Update-Environment-Path
npm install --global --production npm-windows-upgrade
npm-windows-upgrade --npm-version latest
npm install -g gulp-cli 

#
# Docker
# 

# Hyper-V required for docker and other things
Enable-WindowsOptionalFeature -Online -FeatureName:Microsoft-Hyper-V -All -NoRestart

choco install docker --yes
choco install docker-machine --yes
choco install docker-compose --yes
choco install docker-for-windows --yes

Update-Environment-Path

# WSL
choco install -y wsl


# Bower
npm install -g bower

# Grunt
npm install -g grunt-cli

# ESLint
npm install -g eslint

#
# VS Code
#

choco install visualstudiocode --yes # includes dotnet
Update-Environment-Path
code --install-extension robertohuertasm.vscode-icons
code --install-extension CoenraadS.bracket-pair-colorizer

# PowerShell support
code --install-extension ms-vscode.PowerShell

# CSharp support
code --install-extension ms-vscode.csharp

# HTML, CSS, JavaScript support
code --install-extension Zignd.html-css-class-completion
code --install-extension lonefy.vscode-JS-CSS-HTML-formatter
# code --install-extension robinbentley.sass-indented
code --install-extension dbaeumer.vscode-eslint
code --install-extension RobinMalfait.prettier-eslint-vscode
code --install-extension flowtype.flow-for-vscode
# code --install-extension dzannotti.vscode-babel-coloring
code --install-extension esbenp.prettier-vscode
code --install-extension formulahendry.auto-rename-tag

# NPM support
code --install-extension eg2.vscode-npm-script
code --install-extension christian-kohler.npm-intellisense

# Docker support
code --install-extension PeterJausovec.vscode-docker

# PlantUML support
code --install-extension jebbs.plantuml

#
# Android Studio
# 

choco install androidstudio --yes

#
# Basic Utilities
#

choco install slack --yes
choco install notepadplusplus --yes
choco install rapidee --yes

# File Management
choco install beyondcompare --yes
choco install 7zip --yes
choco install filezilla --yes
choco install dropbox --yes

# Media Viewers
choco install irfanview --yes
choco install vlc --yes

# Browsers
choco install googlechrome --yes
choco install firefox --yes

# Misc
choco install sysinternals --yes
choco install procexp --yes
choco install awscli --yes
choco install firacode --yes # See https://www.youtube.com/watch?v=KI6m_B1f8jc

Update-Environment-Path

Write-Output "Finished! Run `choco upgrade all` to get the latest software"
