describe 'razor::server::config' do
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
            :owner => 'root',
            :group => 'root',
          }
        end

        let (:config_path) { '/etc/razor' }
        let (:repo_store_root) { '/var/lib/razor/repo-store' }

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

        it do
          should contain_file(repo_store_root).with({
            :ensure => 'directory',
            :owner  => 'razor',
            :group  => 'razor',
            :mode   => '0755',
          })
        end

        it do
          should contain_postgresql__validate_db_connection('razor_database_connection')
            .that_comes_before('Exec[migrate_razor_database]')
        end

        it do
          should contain_exec('migrate_razor_database')
            .that_requires('Postgresql::Validate_db_connection[razor_database_connection]')
            .with({
              :command => '/usr/sbin/razor-admin -e all migrate-database',
              :unless  => '/usr/sbin/razor-admin -e all check-migrations',
            })
        end
      end
    end
  end
end
