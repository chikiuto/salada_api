# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

# whenever 定期実行
# cronを実行する環境変数(:development, :product, :test)
rails_env = ENV['RAILS_ENV'] || :production
# rails_env = ENV['RAILS_ENV'] || :development

# Rails.root(Railsメソッド)を使用するために必要
require File.expand_path(File.dirname(__FILE__) + '/environment')

# .zshrcとrbenvのパスを指定するrakeを定義
# cronは.zshとrbenvの環境で動いてくれないためPATHを通す
job_type :rake, "source /Users/tokichi/.zshrc; export PATH=\"$HOME/.rbenv/bin:$PATH\"; eval \"$(rbenv init -)\"; cd :path && RAILS_ENV=:environment bundle exec rake :task :output"


# cronを実行する環境変数をセット
set :environment, rails_env

# cronのログの吐き出し場所
set :output, "#{Rails.root}/log/cron.log"

#/config/schedule.rb
set :job_template, "/bin/zsh -l -c ':job'"
job_type :rake, "export PATH=\"$HOME/.rbenv/bin:$PATH\"; eval \"$(rbenv init -)\"; cd :path && RAILS_ENV=:environment bundle exec rake :task :output"

# 毎日実行
every 1.day, at: '9:45 pm' do
  # rake 'ファイル名':タスク名'
  rake 'bat:update_category_table'
end