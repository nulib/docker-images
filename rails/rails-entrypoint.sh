#!/bin/bash

chown app:app /home/app/gems
chown -R app:app /home/app/code/tmp /home/app/code/public
sudo -u app bash <<__EOF__
bundle install --path /home/app/gems
bundle exec rails server
__EOF__
