# Chef InSpec test for recipe blog::default

# The Chef InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

require 'spec_helper'

########### Apache ###########

describe port(8080) do
    it { should be_listening }
end
  
describe port(80) do
    it { should_not be_listening }
end

if os[:family] == 'ubuntu'
    describe service('apache2') do
        it { should be_running }
    end

    describe file('/etc/apache2/sites-available/localhost.conf') do
        it { should exist }
        it { should be_file }
        it { should contain "<VirtualHost *:8080>" }
        it { should contain "DocumentRoot /var/www/html" }
        it { should contain "<Directory /var/www/html>" }
    end

    describe file('/etc/apache2/sites-enabled/localhost.conf') do
        it { should exist }
        it { should be_symlink }
    end
end

if os[:family] == 'redhat'
    describe service('httpd') do
        it { should be_running }
    end

    describe file('/etc/httpd/sites-available/localhost.conf') do
        it { should exist }
        it { should be_file }
        it { should contain "<VirtualHost *:8080>" }
        it { should contain "DocumentRoot /var/www/html" }
        it { should contain "<Directory /var/www/html>" }
    end

    describe file('/etc/httpd/sites-enabled/localhost.conf') do
        it { should exist }
        it { should be_symlink }
    end
end

########### PHP ###########
 
if os[:family] == 'ubuntu'
    describe package('php7.4-mysql') do
      it { should be_installed }
    end
end
  
if os[:family] == 'redhat'
    describe package('php-mysqlnd') do
        it { should be_installed }
    end

    describe package('php-json') do
        it { should be_installed }
    end
end

########### MySQL ###########

describe port(3306) do
    it { should be_listening }
end

describe service('mysql') do
    it { should be_running }
end

########### Wordpress ###########

describe file('/usr/bin/wp') do
    it { should exist }
    it { should be_file }
    it { should be_executable }
end

describe file('/var/www/html/wp-config.php') do
    it { should exist }
    it { should be_file }
    it { should contain "define( 'DB_NAME', 'wordpress' );" }
    it { should contain "define( 'DB_USER', 'wpuser' );" }
    it { should contain "define( 'DB_PASSWORD', 'wppass' );" }
end