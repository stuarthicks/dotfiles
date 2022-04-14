# vi: set ft=ruby sw=2 ts=2 expandtab :

%w[
  stuarthicks/brews
].each { |t| tap t }

case `uname`.chomp
when 'Darwin'
  cask 'homebrew/casks'
  %w[
  ].each { |c| cask b }

  %w[
  ].each { |b| brew b }
when 'Linux'
  %w[
  ].each { |b| brew b }
end

%w[
  kubernetes-cli
  neovim
  starship
  terraform
  tstools
].each { |b| brew b }
