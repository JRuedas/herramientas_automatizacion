require 'spec_helper'

describe 'blog::default' do

    platform 'ubuntu'

    context 'LAMP recipes should be included Ubuntu' do

        it 'should have `apache` recipe included' do
            expect(chef_run).to include_recipe('blog::apache')
        end

        it 'should have `php` recipe included' do
            expect(chef_run).to include_recipe('blog::php')
        end

        it 'should have `mysql` recipe included' do
            expect(chef_run).to include_recipe('blog::mysql')
        end

        it 'should have `wordpress` recipe included' do
            expect(chef_run).to include_recipe('blog::wordpress')
        end
    end

    context 'Default attributes should be correct Ubuntu' do

        it "should have default document root '/var/www/html'" do
            expect(chef_run.node['blog']['document_root']).to eq('/var/www/html') 
        end
    
        it "should have default apache port '8080'" do
            expect(chef_run.node['blog']['apache_port']).to eq('8080') 
        end

        it "should have default mysql port '3306'" do
            expect(chef_run.node['blog']['mysql_port']).to eq('3306') 
        end

        it "should have default mysql version '8.0'" do
            expect(chef_run.node['blog']['mysql_version']).to eq('8.0') 
        end

        it "should have default wordpress version '5.7'" do
            expect(chef_run.node['blog']['wp_version']).to eq('5.7') 
        end

        it "should have default wordpress owner 'vagrant'" do
            expect(chef_run.node['blog']['wp_owner']).to eq('vagrant') 
        end

        it "should have default wordpress host 'localhost'" do
            expect(chef_run.node['blog']['wp_host']).to eq('localhost') 
        end

        it "should have default database name 'wordpress'" do
            expect(chef_run.node['blog']['db_name']).to eq('wordpress') 
        end

        it "should have default database user 'wpuser'" do
            expect(chef_run.node['blog']['db_user']).to eq('wpuser') 
        end

        it "should have default database password 'wppass'" do
            expect(chef_run.node['blog']['db_pass']).to eq('wppass') 
        end
    end

    context 'LAMP recipes should be included CentOS' do

        platform 'centos'

        it 'should have `apache` recipe included' do
            expect(chef_run).to include_recipe('blog::apache')
        end

        it 'should have `php` recipe included' do
            expect(chef_run).to include_recipe('blog::php')
        end

        it 'should have `mysql` recipe included' do
            expect(chef_run).to include_recipe('blog::mysql')
        end

        it 'should have `wordpress` recipe included' do
            expect(chef_run).to include_recipe('blog::wordpress')
        end
    end

    context 'Default attributes should be correct Ubuntu' do

        platform 'centos'

        it "should have default document root '/var/www/html'" do
            expect(chef_run.node['blog']['document_root']).to eq('/var/www/html') 
        end
    
        it "should have default apache port '8080'" do
            expect(chef_run.node['blog']['apache_port']).to eq('8080') 
        end

        it "should have default mysql port '3306'" do
            expect(chef_run.node['blog']['mysql_port']).to eq('3306') 
        end

        it "should have default mysql version '8.0'" do
            expect(chef_run.node['blog']['mysql_version']).to eq('8.0') 
        end

        it "should have default wordpress version '5.7'" do
            expect(chef_run.node['blog']['wp_version']).to eq('5.7') 
        end

        it "should have default wordpress owner 'vagrant'" do
            expect(chef_run.node['blog']['wp_owner']).to eq('vagrant') 
        end

        it "should have default wordpress host 'localhost'" do
            expect(chef_run.node['blog']['wp_host']).to eq('localhost') 
        end

        it "should have default database name 'wordpress'" do
            expect(chef_run.node['blog']['db_name']).to eq('wordpress') 
        end

        it "should have default database user 'wpuser'" do
            expect(chef_run.node['blog']['db_user']).to eq('wpuser') 
        end

        it "should have default database password 'wppass'" do
            expect(chef_run.node['blog']['db_pass']).to eq('wppass') 
        end
    end
end