shared_context 'admin user' do
  let(:admin_user) { create(:user, :admin) }
  let(:http_auth_header) { encode_credentials(admin_user) }
end

shared_context 'another user' do
  let(:another_user) { create(:user) }
  let(:http_auth_header) { encode_credentials(another_user) }
end

shared_examples 'access is forbidden' do
  context 'invalid user credentials' do
    let(:fake_user) { double(email: 'fake@mail.com', password: '123123123') }
    let(:http_auth_header) { encode_credentials(fake_user)}
    it { expect(response).to be_forbidden }
  end

  context 'guest without credentials' do
    let(:http_auth_header) { '' }
    it { expect(response).to be_forbidden }
  end
end
