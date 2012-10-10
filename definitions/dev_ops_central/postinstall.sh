#http://chrisadams.me.uk/2010/05/10/setting-up-a-centos-base-box-for-development-and-testing-with-vagrant/

date > /etc/vagrant_box_build_time

cat > /etc/yum.repos.d/puppetlabs.repo << EOM
[puppetlabs]
name=puppetlabs
baseurl=http://yum.puppetlabs.com/el/6/products/x86_64/
gpgcheck=0
EOM

cat > /etc/yum.repos.d/epel.repo << EOM
[epel]
name=epel
baseurl=http://download.fedoraproject.org/pub/epel/6/x86_64/
gpgcheck=0
EOM

# base installation
yum -y install gcc make gcc-c++ kernel-devel-`uname -r` zlib-devel openssl-devel readline-devel sqlite-devel perl vim
# everything for puppet and ruby
yum -y install puppet facter ruby ruby-devel rubygems
# dependencies for graphite
yum -y install wget gcc zlib-devel curl curl-devel openssl rpm-build python python-ldap python-memcached python-sqlite2 pycairo python-twisted Django django-tagging bitmap bitmap-fonts python-devel glibc-devel openssl-devel python-zope-interface httpd memcached mod_wsgi

gem install --no-ri --no-rdoc chef hiera hiera-puppet hiera-json
cat > /etc/puppet/hiera.yaml << EOM
---
:logger: console
:backends:
  - json
:hierarchy: 
  - default
:json:
  :datadir: /etc/puppet/hieradb
EOM

mkdir /etc/puppet/hieradb
cat > /etc/puppet/hieradb/default.json << EOM
{}
EOM

# Cleaning up
yum -y clean all

# Installing vagrant keys
mkdir /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh
cd /home/vagrant/.ssh
curl -L -o authorized_keys https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub
chown -R vagrant /home/vagrant/.ssh

# Installing the virtualbox guest additions
VBOX_VERSION=$(cat /home/vagrant/.vbox_version)
cd /tmp
curl -L -o VBoxGuestAdditions_$VBOX_VERSION.iso http://download.virtualbox.org/virtualbox/$VBOX_VERSION/VBoxGuestAdditions_$VBOX_VERSION.iso
mount -o loop VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
sh /mnt/VBoxLinuxAdditions.run
umount /mnt

rm VBoxGuestAdditions_$VBOX_VERSION.iso

sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

dd if=/dev/zero of=/tmp/clean || rm /tmp/clean

exit
