require 'rails_helper'

RSpec.describe OrderPayment, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_payment = FactoryBot.build(:order_payment, user_id: user.id, item_id: item.id)
  end

  describe '商品購入情報の保存' do
    context '商品購入情報が保存できるとき' do
      it '全ての情報(値)が正しく入力できていれば保存できる' do
        expect(@order_payment).to be_valid
      end
      it '建物情報(building)は空でも保存できる' do
        @order_payment.building = ''
        expect(@order_payment).to be_valid
      end
    end

    context '商品購入情報が保存できないとき' do
      it '郵便番号(postcode)が空だと保存できない' do
        @order_payment.postcode = ''
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Postcode can't be blank")
      end
      it '都道府県(prefecture_id)が空だと保存できない' do
        @order_payment.prefecture_id = ''
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '区市町村(city)が空だと保存できない' do
        @order_payment.city = ''
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("City can't be blank")
      end
      it '区市町村以下(address)が空だと保存できない' do
        @order_payment.address = ''
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Address can't be blank")
      end
      it '電話番号(phone_number)が空だと保存できない' do
        @order_payment.phone_number = ''
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'クレジットカード情報(token)が空だと保存できない' do
        @order_payment.token = nil
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Token can't be blank")
      end
      it '郵便番号(postcode)はハイフンが無いと保存できない' do
        @order_payment.postcode = '1234567'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Postcode is invalid")
      end
      it '郵便番号(postcode)は半角英数字混合だと保存できない' do
        @order_payment.postcode = '123-abcd'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Postcode is invalid")
      end
      it '郵便番号(postcode)は全角だと保存できない' do
        @order_payment.postcode = '１２３-４５６７'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Postcode is invalid")
      end
      it '都道府県(prefecture_id)は未選択だと保存できない' do
        @order_payment.prefecture_id = 1
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Prefecture must be other than 1")
      end
      it '電話番号(phone_number)は9桁だと保存できない' do
        @order_payment.phone_number = '090123456'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Phone number is invalid")
      end
      it '電話番号(phone_number)は12桁だと保存できない' do
        @order_payment.phone_number = '090123456789'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Phone number is invalid")
      end
      it '電話番号(phone_number)は半角英数字混合だと保存できない' do
        @order_payment.phone_number = '090abcdefgh'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Phone number is invalid")
      end
      it '電話番号(phone_number)は全角だと保存できない' do
        @order_payment.phone_number = '０９０１２３４５６７８'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Phone number is invalid")
      end
      it '購入者(order_id)が空だと保存できない' do
        @order_payment.order_id = ''
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Order can't be blank")
      end
      it '購入商品(item_id)が空だと保存できない' do
        @order_payment.item_id = ''
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end