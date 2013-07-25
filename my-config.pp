$homedir  = "/home/${id}"
$codepath = "${homedir}/code"

# Dotfiles repo
vcsrepo { "${codepath}/dotfiles":
  ensure   => present,
  provider => git,
  source   => 'https://github.com/jivagoalves/dotfiles.git'
}

# .gitconfig from my dotfiles repo
file { "${homedir}/.gitconfig":
  ensure  => link,
  target  => "${codepath}/dotfiles/gitconfig",
  require => Vcsrepo["${codepath}/dotfiles"]
}


# vim-pathogen
include vim

# .vimrc from my dotfiles repo
file { "${vim::vimrc}":
  ensure  => link,
  target  => "${codepath}/dotfiles/vimrc",
  require => Vcsrepo["${codepath}/dotfiles"]
}

# My vim's plugins
vim::bundle { [
  'tpope/vim-rails',
]: }
