require "order_samplex/engine"

module OrderSamplex
  
  mattr_accessor :order_class, :show_order_path
  
  def self.order_class
    @@order_class.constantize
  end
end
