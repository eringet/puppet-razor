describe 'razor::client' do
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
        :ensure   => 'installed',
        :provider => nil
      }
    end

    it { should compile.with_all_deps }
    it { should create_class('razor::client') }
    it { should contain_package('razor-client').with(default_params) }
  end
end
