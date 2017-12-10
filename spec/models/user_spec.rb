require 'rails_helper'

describe User, type: :model do
  describe '#admin?' do
    let(:default_user) { create(:user) }
    let(:admin_user) { create(:user, :admin) }

    it 'check if user have an admin role' do
      expect(default_user.admin?).to be_falsey
      expect(admin_user.admin?).to be_truthy
    end
  end

  describe 'validators' do
    subject { build(:user) }

    describe 'role' do
      let(:role) { described_class::ROLES.sample }

      before do
        subject.role = role
      end

      it 'only specified roles is allowed' do
        expect(subject.valid?).to be_truthy
      end

      context 'failure' do
        let(:role) { 'other' }

        specify do
          expect(subject.valid?).to be_falsey
        end
      end
    end

    describe 'email' do
      context 'uniqueness' do
        before do
          subject.email = create(:user).email
        end

        specify do
          expect(subject.valid?).to be_falsey
          expect(subject.errors.full_messages).to include('Email has already been taken')
        end
      end

      context 'presence' do
        before do
          subject.email = nil
        end

        specify do
          expect(subject.valid?).to be_falsey
          expect(subject.errors.full_messages).to include('Email can\'t be blank')
        end
      end
    end
  end
end
