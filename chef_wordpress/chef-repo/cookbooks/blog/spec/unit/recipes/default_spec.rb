require 'spec_helper'

describe 'blog::default' do

    context 'LAMP recipes should be included in Ubuntu' do

        platform 'ubuntu'

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

    context 'LAMP recipes should be included in CentOS' do

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
end