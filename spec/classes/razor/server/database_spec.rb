describe 'razor::server::database' do
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
            :ensure => 'running',
            :enable => true
          }
        end

        it { should compile.with_all_deps }
        it { should create_class('razor::server::database') }
        it { should contain_postgresql__server__db('razor') }
      end
    end
  end
end
