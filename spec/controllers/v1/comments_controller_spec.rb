require 'rails_helper'

describe V1::CommentsController, type: :controller do
  render_views

  let(:user) { create(:user) }
  let(:article) { create(:article, user: user) }
  let(:http_auth_header) { encode_credentials(user) }

  before do
    @request.env['HTTP_AUTHORIZATION'] = http_auth_header
  end

  describe 'GET #index' do
    let(:total) { 12 }
    let!(:comments) { create_list(:comment, total, article: article) }
    let(:response) { get :index, params: { article_id: article.id } }

    it 'returns successful response status' do
      expect(response).to be_successful
    end

    it 'returns expected payload' do
      expect(response.content_type).to eq('application/json')
      expect(parsed_body.keys).to contain_exactly('comments', 'page', 'total')
      expect(parsed_body['comments'].length).to eq(10)
      expect(parsed_body['page']).to eq(1)
      expect(parsed_body['total']).to eq(total)
    end

    describe 'pagination' do
      let(:page) { 2 }
      let(:response) { get :index, params: { article_id: article.id, page: page } }

      it 'returns expected payload' do
        expect(parsed_body['comments'].length).to eq(2)
        expect(parsed_body['page']).to eq(page)
        expect(parsed_body['total']).to eq(total)
      end
    end
  end

  describe 'POST #create' do
    let(:payload) { attributes_for(:comment) }
    let(:response) { post :create, params: { article_id: article.id, comment: payload } }
    let(:last_comment) { article.comments.reload.last }

    it 'returns created response status' do
      expect(response).to be_created
    end

    it 'returns expected payload' do
      expect(parsed_body['id']).to eq(last_comment.id)
      expect(parsed_body['owner']).to eq(user.email)
      expect(parsed_body['content']).to eq(last_comment.content)
    end

    it_behaves_like 'access is forbidden'
  end

  describe 'DELETE #destroy' do
    let!(:comment) { create(:comment, user: user, article: article) }
    let(:response) { delete :destroy, params: { article_id: article.id, id: comment.id } }

    specify do
      expect { response }.to change { user.comments.count }.by(-1)
      expect(response).to be_no_content
    end

    it_behaves_like 'access is forbidden' do
      include_examples 'another user' do
        specify { expect(response).to be_forbidden }
      end
    end

    include_examples 'admin user' do
      it 'admin is able to delete any comment' do
        expect { response }.to change { user.comments.count }.by(-1)
      end
    end
  end
end
