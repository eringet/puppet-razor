describe 'razor' do
  context "in every situation" do
    it { should raise_error(Puppet::Error, /Please use ::razor::server and\/or ::razor::client instead!/) }
  end
end
