require 'spec_helper'

module OrderSamplex
  describe Sample do
    it "should be OK" do
      c = FactoryGirl.create(:order_samplex_sample)
      c.should be_valid
    end
    
    it "should reject 0 order_id" do
      c = FactoryGirl.build(:order_samplex_sample, :order_id => 0)
      c.should_not be_valid
    end
    
    it "should reject 0 qty" do
      c = FactoryGirl.build(:order_samplex_sample, :qty => 0)
      c.should_not be_valid
    end
      
    it "should reject nil delivery_date" do
      c = FactoryGirl.build(:order_samplex_sample, :delivery_date => nil)
      c.should_not be_valid
    end
  end
end
