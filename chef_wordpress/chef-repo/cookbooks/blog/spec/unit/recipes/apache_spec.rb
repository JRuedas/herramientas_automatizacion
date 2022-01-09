require 'spec_helper'

describe 'blog::default' do
    platform 'ubuntu'

    context 'with default attributes' do
        it 'should have default document root to `/var/www/html`' do
            expect(chef_run.node['blog']['document_root']).to eq('/var/www/html')
        end

        it 'should have `apache` recipe included' do
            expect(chef_run).to include_recipe('blog::apache')
        end
    end
end