require 'rails_helper'

RSpec.describe Ethnicity, type: :model do
  before do
    @user = User.create(twitter_id: 99999999)
    @ethnicity = @user.ethnicities.new
  end

  it 'is valid with a text value' do
    @ethnicity.value = "value"
    expect(@ethnicity.valid?).to be true
  end

  it 'is invalid without a text value' do
    expect(@ethnicity.valid?).to be false
  end

end
