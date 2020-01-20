require 'rails_helper'

describe Ability do
  subject { Ability.new(user) }

  context 'guest' do
    let(:user) { nil }

    shared_examples 'guest abilities' do
      it 'can read' do
        expect(subject.can?(:read, object)).to be_truthy
      end

      it 'cannot manage' do
        expect(subject.can?(:manage, object)).to be_falsey
      end
    end

    describe 'articles' do
      let(:object) { create(:article) }

      it_behaves_like 'guest abilities'
    end

    describe 'comments' do
      let(:object) { create(:comment) }

      it_behaves_like 'guest abilities'
    end
  end

  context 'user' do
    let(:user) { create(:user) }

    shared_examples 'user abilities' do
      it 'can manage own objects' do
        expect(subject.can?(:manage, object)).to be_truthy
      end

      it 'cannot manage other users objects' do
        expect(subject.can?(:manage, other_object)).to be_falsey
      end
    end

    describe 'articles' do
      let(:object) { create(:article, user: user) }
      let(:other_object) { create(:article) }

      it_behaves_like 'user abilities'
    end

    describe 'comments' do
      let(:object) { create(:comment, user: user) }
      let(:other_object) { create(:comment) }

      it_behaves_like 'user abilities'
    end
  end

  context 'user with admin role' do
    let(:user) { create(:user, :admin) }

    shared_examples 'admin abilities' do
      it 'can manage any objects' do
        expect(subject.can?(:manage, object)).to be_truthy
      end
    end

    describe 'articles' do
      let(:object) { create(:article) }

      it_behaves_like 'admin abilities'
    end

    describe 'comments' do
      let(:object) { create(:comment) }

      it_behaves_like 'admin abilities'
    end
  end
end