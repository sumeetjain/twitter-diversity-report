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

  describe '#field_array' do
    before do
      @user.ethnicities.new(value: "value1")
      @user.ethnicities.new(value: "value2")
    end
    it 'gets an array of the values from that field' do
      expect(@user.instance_eval{ field_array 'ethnicities' }).to eq(["value1", "value2"])
    end
  end

  describe '#set_textarea' do
    before do
      @user.ethnicities.new(value: "value1")
      @user.ethnicities.new(value: "value2")
    end

    it 'returns a string of the values joined by line breaks' do
      expect(@user.instance_eval{ set_textarea "ethnicities" }).to eq("value1\r\nvalue2")
    end
  end

  describe '#get_textarea' do
    before do
      @user.instance_eval { get_textarea "ethnicities", "value3\r\nvalue4"}
    end
    it "sets a user's fields based on the text area value" do
      expect(@user.ethnicities[1].value).to eq("value4")
    end
  end
end
