require 'rails_helper'

describe Comment, type: :model do
  subject { build(:comment) }

  describe 'validators' do
    describe 'content' do
      before { subject.content = nil }

      it 'should no be empty' do
        expect(subject.valid?).to be_falsey
        expect(subject.errors.full_messages).to include('Content can\'t be blank')
      end
    end
  end
end
