require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録が正常に行われるとき' do
      it 'すべての入力項目が存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'パスワードが6文字以上かつ、半角英数字であれば登録できる' do
        @user.password = '123abc'
        @user.password_confirmation = '123abc'
        expect(@user).to be_valid
      end
      it '苗字が全角(漢字/平仮名/カタカナ)であれば登録できる' do
        @user.last_name = '山田'
        expect(@user).to be_valid
      end
      it '名前が全角(漢字/平仮名/カタカナ)であれば登録できる' do
        @user.first_name = '陸太郎'
        expect(@user).to be_valid
      end
      it '苗字のフリガナが全角カタカナであれば登録できる' do
        @user.last_name = 'ヤマダ'
        expect(@user).to be_valid
      end
      it '名前のフリガナが全角カタカナであれば登録できる' do
        @user.last_name = 'リクタロウ'
        expect(@user).to be_valid
      end
    end

    context '新規登録が正常に行われないとき' do
      it 'ニックネームが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'メールアドレスが空だと登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'メールアドレスが既に登録されており重複していると登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it 'パスワードが空だと登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank", 'Password Include both characters and numbers', "Password confirmation doesn't match Password")
      end
      it 'パスワード(確認用)が空だと登録できない' do
        @user.password = '123abc'
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'パスワード(確認用含)が5文字以下だと登録できない' do
        @user.password = 'ab123'
        @user.password_confirmation = 'ab123'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'パスワード(確認用含)が半角英数字でないと登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password Include both characters and numbers')
      end
      it '苗字が全角(漢字/平仮名/カタカナ)でないと登録できない' do
        @user.last_name = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid")
      end
      it '名前が全角(漢字/平仮名/カタカナ)でないと登録できない' do
        @user.first_name = 'rikutaro'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid")
      end
      it '苗字のフリガナが全角カタカナでないと登録できない' do
        @user.last_name_kana = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid")
      end
      it '名前のフリガナが全角カタカナでないと登録できない' do
        @user.first_name_kana = 'りくたろう'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid")
      end
      it '生年月日が空だと登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
      it 'メールアドレスに＠を含まない場合は登録できない' do
        @user.email = 'samplegmail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it '英字のみのパスワードでは登録できない' do
        @user.password = 'aabbcc'
        @user.password_confirmation = 'aabbcc'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password Include both characters and numbers")
      end
      it '全角文字を含むパスワード(確認用含)では登録できない' do
        @user.password = 'パスワード'
        @user.password_confirmation = 'パスワード'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)", "Password Include both characters and numbers")
      end
      it '苗字(全角)が空だと登録できない' do
        @user.last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank", "Last name is invalid")
      end
      it '名前(全角)が空だと登録できない' do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank", "First name is invalid")
      end
      it '苗字(カタカナ)が空だと登録できない' do
        @user.last_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank", "Last name kana is invalid")
      end
      it '名前(カタカナ)が空だと登録できない' do
        @user.first_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank", "First name kana is invalid")
      end
      it 'パスワード(確認用含)は数字のみでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password Include both characters and numbers")
      end
      it 'パスワードとパスワード(確認用)は、値が一致しなければ登録できない' do
        @user.password = '123abc'
        @user.password_confirmation = 'abc123'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
  end
end
