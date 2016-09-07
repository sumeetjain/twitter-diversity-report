require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.new
  end

  it 'is valid with a twitter id' do
    @user.twitter_id = 123456790
    expect(@user.valid?).to be true
  end

  it 'is invalid without a twitter id' do
    @user.twitter_id =
    expect(@user.valid?).to be false
  end

  describe '#ethnicities_textarea' do
    before do
      @user.ethnicities.new(value: "value1")
      @user.ethnicities.new(value: "value2")
    end

    it 'generates a string from existing ethnicities' do
      expect(@user.ethnicities_textarea).to eq("value1\r\nvalue2")
    end

    it 'sets ethnicities based on a string' do
      @user.ethnicities_textarea = "value1\r\nvalue2\r\nvalue3"
      expect(@user.ethnicities[2].value).to eq("value3")
    end
  end
end
