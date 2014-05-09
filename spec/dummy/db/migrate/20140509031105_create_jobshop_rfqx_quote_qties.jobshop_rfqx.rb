# This migration comes from jobshop_rfqx (originally 20140208052737)
class CreateJobshopRfqxQuoteQties < ActiveRecord::Migration
  def change
    create_table :jobshop_rfqx_quote_qties do |t|
      t.integer :rfq_id
      t.integer :qty

      t.timestamps
    end
  end
end
