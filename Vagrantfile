# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'
IMAGE_USERID=`id -u`

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define "db" do |db|
    db.vm.provider 'docker' do |d|
      d.image  = 'mariadb:latest'
      d.name   = 'hackweek_db'
      d.ports  = ['3306:3306']
      d.env    = {'MYSQL_ROOT_PASSWORD' => 'opensuse'}
    end
  end

  config.vm.define "web" do |web|
    web.vm.provider 'docker' do |d|
      d.build_dir       = "."
      d.name            = 'hackweek_web'
      d.create_args     = ['-i', '-t']
      d.build_args      = ['--build-arg', "IMAGE_USERID=#{IMAGE_USERID}"]
      d.cmd             = ['/bin/bash', '-l']
      d.remains_running = false
      d.ports           = ['3000:3000']

      d.link('hackweek_db:db')
    end
  end

end
