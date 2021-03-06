require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class MoneyRecord < ActiveRecord::Base
  money_column :price
end

describe "MoneyColumn" do

  it "typecasts string to money" do
    m = MoneyRecord.new(:price => "100")

    m.price.should == Money.new(100)
  end

  it "typecasts numeric to money" do
    m = MoneyRecord.new(:price => 100)

    m.price.should == Money.new(100)
  end

  it "typecasts blank to nil" do
    m = MoneyRecord.new(:price => "")

    m.price.should == nil
  end

  it "ypecasts invalid string to empty money" do
    m = MoneyRecord.new(:price => "magic")

    m.price.should == Money.new(0)
  end

  it "typecasts value that does not respond to to_money as nil" do
    m = MoneyRecord.new(:price => true)

    m.price.should == nil
  end
end
