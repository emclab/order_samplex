module OrderSamplex
  class Sample < ActiveRecord::Base
    attr_accessor :oked_noupdate
    attr_accessible :delivery_date, :oked, :oked_date, :order_id, :qty, :quality_feedback, :sample_requirement, :shipping_date, 
                    :shipping_instruction, :shipping_tracking, :last_updated_by_id,
                    :as => :role_new
    attr_accessible :delivery_date, :oked, :oked_date, :order_id, :qty, :quality_feedback, :sample_requirement, :shipping_date, 
                    :shipping_instruction, :shipping_tracking,
                    :oked_noupdate,
                    :as => :role_update
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    belongs_to :order, :class_name => OrderSamplex.order_class.to_s
    
    validates :order_id, :presence => true,
                         :numericality => {:greater_than => 0}
    validates :qty, :presence => true,
                    :numericality => {:greater_than => 0, :message => I18n.t('Qty > 0')}                     
    validates_presence_of :delivery_date                
  end
end
