require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    attributes_for = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
  end
  describe 'Name and email' do
    context 'when name or email is blank' do
      it 'is not accepted' do
        @user.name = ' '
        @user.email = ' '
        expect(@user).to be_invalid
        @user.name = ''
        @user.email = ''
        expect(@user).to be_invalid
        @user.name = nil
        @user.email = nil
        expect(@user).to be_invalid
      end
    end
    context 'when name and email is too long' do
      it 'is not accepted' do
        @user.name = 'a' * 51
        expect(@user).to be_invalid
        @user.email = "#{'a' * 244}@example.com"
        expect(@user).to be_invalid
      end
    end
    context 'when email is proper format' do
      it 'is accepted' do
        valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
        valid_addresses.each do |valid_address|
          @user.email = valid_address
          expect(@user).to be_valid
        end
      end
    end
    context 'when email is not proper format' do
      it 'is not accepted' do
        invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
        invalid_addresses.each do |invalid_address|
          @user.email = invalid_address
          expect(@user).to be_invalid
        end
      end
    end
    context 'when an email address is already in database' do
      it 'is not accepted' do
        duplicate_user = @user.dup
        duplicate_user.email = @user.email.upcase
        @user.save
        expect(duplicate_user).to be_invalid
      end
    end
    context 'when email address has mixed upper and down' do
      it 'is saved in all downcase letter' do
        mixed_case_email = "Foo@ExAMPle.CoM"
        @user.email = mixed_case_email
        @user.save
        expect(@user.reload.email).to eq mixed_case_email.downcase
      end
    end
  end

  describe 'Passsword' do
    context 'when password is entered' do
      it 'has no blanks' do
        @user.password = @user.password_confirmation = " " * 6
        expect(@user).to be_invalid
      end
      it 'has minimum six letters' do
        @user.password = @user.password_confirmation = "a" * 5
        expect(@user).to be_invalid
      end
    end
  end
end
