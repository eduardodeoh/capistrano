capistrano
==========

Capistrano recipes for Rails Apps

1 - First, check my pre-setup via ansible: https://github.com/eduardodeoh/ansible

2 - git clone https://github.com/eduardodeoh/capistrano deploy

3 - check settings file - config/capistrano/settings.rb

4 - cd your_rails_app; ln -s deploy/Capfile;

5 - cd config; ln -s ../deploy/config/deploy.rb; ln -s ../deploy/config/capistrano; cd ..

6 - Verify files: config/deploy.rb and config/capistrano/var/*

7 - cap deploy:setup; cap deploy
