require 'rails_helper'

RSpec.describe Fund, type: :model do
  # normal
  it "is invalid without user" do
    user = create(:user)
    expect(build(:fund)).to be_valid
  end

  # name
  it "is invalid without name" do
    expect(build(:fund, name: nil)).to be_invalid
  end

  # user
  it "is invalid without user_id" do
    expect(build(:fund, user_id: nil)).to be_invalid
  end

  # amount
  it "is invalid without amount" do
    expect(build(:fund, amount: nil)).to be_invalid
  end

  it "is invalid without amount: should be a number" do
    fund = build(:fund, amount: "invalid")
    fund.valid?
    expect(fund).to be_invalid
    expect(fund.errors[:amount]).to include("is not a number")
  end

  # collection_deadline
  it "is invalid without colleciton_deadline" do
    expect(build(:fund, colleciton_deadline: nil)).to be_invalid
  end

  # earning
  it "is invalid without earning: be a number" do
    fund = build(:fund, earning: nil)
    fund.valid?
    expect(fund).to be_invalid
    expect(fund.errors[:earning]).to include("is not a number")
  end

  # state
  it "is invalid without state" do
    fund = build(:fund, state: nil)
    expect(fund).to be_invalid
    expect(fund.errors[:state]).to include("can't be blank")
  end

  it "is invalid without state: only 'on' and 'off'" do
    fund = build(:fund, state: "invalid")
    fund.valid?
    expect(fund).to be_invalid
    expect(fund.errors[:state]).to include("is not included in the list")
  end

  it "is valid when state is 'on' or 'off' " do
    expect(build(:fund, state: "on")).to be_valid
    expect(build(:fund, state: "off")).to be_valid
  end

  # private_check
  it "is invalid when private_check is nil" do
    fund = build(:fund, private_check: nil)
    fund.valid?
    expect(fund).to be_invalid
    expect(fund.errors[:private_check]).to include("is not included in the list")
  end

  # minimum
  it "is valid when minimum is nil" do
    fund = build(:fund, minimum: nil)
    fund.valid?
    expect(fund).to be_valid
  end

  it "is invalid when invest_starting_date is nil" do
    expect(build(:fund, invest_starting_date: nil)).to be_invalid
  end

  it "is invalid when invest_ending_date is nil" do
    expect(build(:fund, invest_ending_date: nil)).to be_invalid
  end
end