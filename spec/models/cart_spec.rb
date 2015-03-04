require "rails_helper"

describe Cart do
  it "is invalid when the name is blank" do
    entry = Product.new(name: "")

    expect(entry).not_to be_valid
    expect(entry.errors[:name].size).to eq(1)
    expect(entry.errors[:name]).to include("can't be blank")
  end

  it "is invalid when the price is blank" do
    entry = Product.new(price: "")

    expect(entry).not_to be_valid
    expect(entry.errors[:price].size).to eq(1)
    expect(entry.errors[:price]).to include("can't be blank")
  end

  it "is invalid when the quantity is blank" do
    entry = Product.new(quantity: "")

    expect(entry).not_to be_valid
    expect(entry.errors[:quantity].size).to eq(1)
    expect(entry.errors[:quantity]).to include("can't be blank")
  end

  it "is invalid when the description is blank" do
    entry = Product.new(description: "")

    expect(entry).not_to be_valid
    expect(entry.errors[:description].size).to eq(1)
    expect(entry.errors[:description]).to include("can't be blank")
  end

  it "is invalid when the description contains more than 1000 characters" do
    entry = Product.new(description: "x" * 1001)

    expect(entry).not_to be_valid
    expect(entry.errors[:description].size).to eq(1)
    expect(entry.errors[:description]).
      to include("is too long (maximum is 1000 characters)")
  end
end
