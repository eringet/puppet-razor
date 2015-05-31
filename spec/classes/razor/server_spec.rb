describe 'razor::server' do
  context 'with Puppet <= 3.7.0' do
    let (:facts) do
      {
        :puppetversion => '3.6.0'
      }
    end

    it { should raise_error(Puppet::Error, /This module requires the use of Puppet v3.7.0 or newer./) }
  end

  context 'with default parameters' do
    let (:default_params) do
      {
        :package_name   => nil,
        :package_ensure => nil,
        :service_name   => nil,
        :service_ensure => nil,
        :service_enable => nil,
      }
    end

    it { should compile.with_all_deps }
    it { should create_class('razor::server') }
    it { should contain_class('razor::server::install').that_comes_before('Class[razor::server::config]') }
    it { should contain_class('razor::server::config').that_notifies('Class[razor::server::service]') }
    it { should contain_class('razor::server::service').that_subscribes_to('Class[razor::server::config]') }
  end
end
