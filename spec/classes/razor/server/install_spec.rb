describe 'razor::server::install' do
  context 'without ::razor::server' do
    it { should raise_error(Puppet::Error, /Use of private class #{class_name} from /) }
  end

  [ 'Debian', 'RedHat' ].each do |osfamily|
    context 'as part of ::razor::server' do
      context "with default parameters on #{osfamily}" do
        let (:pre_condition) { 'include ::razor::server' }

        let (:facts) do
          {
            :operatingsystem => osfamily,
            :lsbdistid       => osfamily,
            :osfamily        => osfamily,
          }
        end

        let (:default_params) do
          {
            :ensure => 'installed'
          }
        end

        it { should compile.with_all_deps }
        it { should create_class('razor::server::install') }
        it { should contain_package('razor-server').with(default_params) }

        it do
          should contain_archive('microkernel.tar')
            .with_source('http://links.puppetlabs.com/razor-microkernel-latest.tar')
        end
      end
    end
  end
end
