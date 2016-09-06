require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
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
end
