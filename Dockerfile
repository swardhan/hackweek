FROM opensuse:42.2
ARG IMAGE_USERID

# Add repositories for ruby
RUN zypper -q --non-interactive addrepo -f 'http://download.opensuse.org/repositories/devel:/languages:/ruby/openSUSE_Leap_42.2/devel:languages:ruby.repo'

# Refresh repositories
RUN zypper -q --non-interactive --gpg-auto-import-keys refresh

# Install some system requirements
RUN zypper -q --non-interactive install timezone vim aaa_base glibc-locale sudo

# Install ruby
RUN zypper -q --non-interactive install ruby2.1 ruby2.1-devel ruby2.1-rubygem-mysql2

# Setup gem & sudo
RUN echo 'install: --no-format-executable' >> /etc/gemrc; \
echo 'vagrant ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

# Install bundler
RUN gem install bundler

# Install requirements for our rubygems 
RUN zypper -q --non-interactive install libxml2-devel libxslt-devel nodejs gcc-c++ ImageMagick libmysqlclient-devel make sqlite3-devel

# Add our user
RUN useradd -m vagrant -u $IMAGE_USERID -p vagrant 

USER vagrant
WORKDIR /vagrant
# Setup bundler
RUN bundle config build.nokogiri --use-system-libraries

CMD ["bundle", "exec", "rails", "server"] 
