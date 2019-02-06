#! /bin/sh

set -e

service nginx start
exec bundle exec puma -C $@
