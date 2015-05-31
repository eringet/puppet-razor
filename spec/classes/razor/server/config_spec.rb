describe 'razor::server::config' do
  context 'without ::razor::server' do
    it { should raise_error(Puppet::Error, /Use of private class #{class_name} from /) }
  end

  context 'as part of ::razor::server' do
    let (:pre_condition) { 'include ::razor::server' }

    context 'with default parameters' do
      let (:default_params) do
        {
          :owner => 'root',
          :group => 'root',
        }
      end

      let (:config_path) { '/etc/razor' }

      it { should compile.with_all_deps }
      it { should create_class('razor::server::config') }

      it do
        should contain_file(config_path).with(default_params.merge({
          :ensure => 'directory',
          :mode   => '0755',
        }))
      end

      it do
        should contain_file("#{config_path}/config.yaml").with(default_params.merge({
          :ensure => 'file',
          :mode   => '0644',
        }))
      end
    end
  end
end
