require 'rails_helper'

describe Article, type: :model do
  subject { build(:article) }

  describe '#owner' do
    let(:user) { create(:user) }
    before { subject.user = user }

    specify do
      expect(subject.owner).to eq(user.email)
    end
  end

  describe 'validators' do
    shared_examples 'should no be empty' do
      specify do
        expect(subject.valid?).to be_falsey
        expect(subject.errors.full_messages).to include("#{field} can't be blank")
      end
    end

    describe 'title' do
      let(:field) { 'Title' }
      before { subject.title = nil }

      it_behaves_like 'should no be empty'
    end

    describe 'content' do
      let(:field) { 'Content' }
      before { subject.content = nil }

      it_behaves_like 'should no be empty'
    end
  end

  describe 'comments relation' do
    let!(:article) { create(:article) }
    let!(:comments) { create_list(:comment, 10, article_id: article.id) }

    specify do
      expect(article.comments).to match_array(comments)
    end

    context 'delete' do
      let(:count) { comments.count }

      specify do
        expect { article.destroy }.to change { Comment.count }.by(-count)
      end
    end
  end
end
