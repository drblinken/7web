# test for fixing the slice method not to include nil values for update"
require_relative "app"

describe "Hash slicing " do

  it "slices an Hash" do
    h = {a: :b,c: :d, e: :f}
    expect(h.slice(*[:a,:e]).size).to eq(2)
  end

  it "ignores nils in whitelist" do
    h = {a: nil,c: :d, e: :f}
    expect(h.slice(*[:a,:e]).size).to eq(1)
  end
end
