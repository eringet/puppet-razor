describe 'razor::server::service' do
  context 'without ::razor::server' do
    it { should raise_error(Puppet::Error, /Use of private class #{class_name} from /) }
  end

  context 'as part of ::razor::server' do
    context 'with default parameters' do
      let (:pre_condition) { 'include ::razor::server' }

      let (:default_params) do
        {
          :ensure => 'running',
          :enable => true
        }
      end

      it { should compile.with_all_deps }
      it { should create_class('razor::server::service') }
      it { should contain_service('razor-server').with(default_params) }
    end
  end
end
