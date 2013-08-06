/usr/bin/env sh

#Symlink files requested by Capistrano
ln -nfs ../deploy/config/deploy.rb ../config
ln -nfs ../deploy/Capfile ..
ln -nfs ../deploy/config/capistrano ../config