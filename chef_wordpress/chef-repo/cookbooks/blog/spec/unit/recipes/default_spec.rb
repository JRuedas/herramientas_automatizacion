require 'spec_helper'

describe 'blog::default' do
    platform 'ubuntu'

    context 'LAMP recipes should be included' do

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