#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
yarn install

# jsファイルをesbuildでバンドルしているため
yarn build 

# cssはsprocketsを使っているため
bundle exec rake assets:precompile 

# migrateはridgepoleを使っているため（標準のmigrateを使うならbundle exec rails db:migrateで良いかと思います）
bundle exec ridgepole -c config/database.yml -E production --apply -f db/schemas/Schemafile 