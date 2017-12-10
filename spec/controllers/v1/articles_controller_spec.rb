require 'rails_helper'

RSpec.describe V1::ArticlesController, type: :controller do
  render_views

  let(:user) { create(:user) }
  let(:http_auth_header) { encode_credentials(user) }

  before do
    @request.env['HTTP_AUTHORIZATION'] = http_auth_header
  end

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

  describe 'GET #index' do
    let(:total) { 15 }
    let!(:articles) { create_list(:article, total) }
    let(:response) { get :index }

    it 'returns successful response status' do
      expect(response).to be_successful
    end

    it 'returns expected payload' do
      expect(response.content_type).to eq('application/json')
      expect(parsed_body.keys).to contain_exactly('articles', 'page', 'total')
      expect(parsed_body['articles'].length).to eq(10)
      expect(parsed_body['page']).to eq(1)
      expect(parsed_body['total']).to eq(total)
    end

    describe 'pagination' do
      let(:page) { 2 }
      let(:response) { get :index, params: { page: page} }

      it 'returns expected payload' do
        expect(parsed_body['articles'].length).to eq(5)
        expect(parsed_body['page']).to eq(page)
        expect(parsed_body['total']).to eq(total)
      end
    end

    context 'returns only active articles' do
      let!(:archived_article) { create(:article, :archived) }

      it 'archived articles is ignored' do
        expect(Article).to receive(:active_with_users).and_call_original
        parsed_body['articles'].each do |article|
          expect(article['id']).to_not eq(archived_article.id)
        end
      end
    end
  end

  describe 'POST #create' do
    let(:payload) { attributes_for(:article) }
    let(:response) { post :create, params: { article: payload } }
    let(:last_article) { Article.last }

    it 'returns created response status' do
      expect(response).to be_created
    end

    it 'returns expected payload' do
      expect(parsed_body['id']).to eq(last_article.id)
      expect(parsed_body['status']).to eq('active')
      expect(parsed_body['owner']).to eq(user.email)
      expect(parsed_body['title']).to eq(last_article.title)
      expect(parsed_body['content']).to eq(last_article.content)
      expect(parsed_body['comments_count']).to eq(0)
    end

    it_behaves_like 'access is forbidden'
  end

  describe 'PUT #update' do
    let!(:article) { create(:article, user: user) }
    let(:payload) { attributes_for(:article) }
    let(:response) { put :update, params: { id: article.id, article: payload } }

    it 'returns accepted response status' do
      expect(response).to be_accepted
    end

    it_behaves_like 'access is forbidden' do
      include_examples 'another user' do
        specify { expect(response).to be_forbidden }
      end
    end

    include_examples 'admin user' do
      let(:title) { 'Changed by admin' }
      let(:payload) { attributes_for(:article, title: title) }

      it 'admin is able to update any item' do
        expect(response).to be_accepted
        expect(article.reload.title).to eq(title)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:article) { create(:article, user: user) }
    let(:response) { delete :destroy, params: { id: article.id } }

    specify do
      expect { response }.to change { user.articles.count }.by(-1)
      expect(response).to be_no_content
    end

    it_behaves_like 'access is forbidden' do
      include_examples 'another user' do
        specify { expect(response).to be_forbidden }
      end
    end

    include_examples 'admin user' do
      it 'admin is able to delete any item' do
        expect { response }.to change { user.articles.count }.by(-1)
      end
    end
  end
end
