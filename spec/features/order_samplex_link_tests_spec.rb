require 'spec_helper'

describe "LinkTests" do
  describe "GET /order_samplex_link_tests" do
    mini_btn = 'btn btn-mini '
    ActionView::CompiledTemplates::BUTTONS_CLS =
        {'default' => 'btn',
         'mini-default' => mini_btn + 'btn',
         'action'       => 'btn btn-primary',
         'mini-action'  => mini_btn + 'btn btn-primary',
         'info'         => 'btn btn-info',
         'mini-info'    => mini_btn + 'btn btn-info',
         'success'      => 'btn btn-success',
         'mini-success' => mini_btn + 'btn btn-success',
         'warning'      => 'btn btn-warning',
         'mini-warning' => mini_btn + 'btn btn-warning',
         'danger'       => 'btn btn-danger',
         'mini-danger'  => mini_btn + 'btn btn-danger',
         'inverse'      => 'btn btn-inverse',
         'mini-inverse' => mini_btn + 'btn btn-inverse',
         'link'         => 'btn btn-link',
         'mini-link'    => mini_btn +  'btn btn-link'
        }
    before(:each) do
      @pagination_config = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'pagination', :argument_value => 30)
      z = FactoryGirl.create(:zone, :zone_name => 'hq')
      type = FactoryGirl.create(:group_type, :name => 'employee')
      ug = FactoryGirl.create(:sys_user_group, :user_group_name => 'ceo', :group_type_id => type.id, :zone_id => z.id)
      @role = FactoryGirl.create(:role_definition)
      ur = FactoryGirl.create(:user_role, :role_definition_id => @role.id)
      ul = FactoryGirl.build(:user_level, :sys_user_group_id => ug.id)
      @u = FactoryGirl.create(:user, :user_levels => [ul], :user_roles => [ur])
      
      ua1 = FactoryGirl.create(:user_access, :action => 'index', :resource => 'order_samplex_samples', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "OrderSamplex::Sample.scoped.order('delivery_date DESC')")
      ua1 = FactoryGirl.create(:user_access, :action => 'create', :resource => 'order_samplex_samples', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "")
      ua1 = FactoryGirl.create(:user_access, :action => 'update', :resource => 'order_samplex_samples', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "")
      user_access = FactoryGirl.create(:user_access, :action => 'show', :resource =>'order_samplex_samples', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      user_access = FactoryGirl.create(:user_access, :action => 'create_order_sample', :resource => 'commonx_logs', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        
      @cust = FactoryGirl.create(:kustomerx_customer) 
      @rfq = FactoryGirl.create(:jobshop_rfqx_rfq, :customer_id => @cust.id, :sales_id => @u.id)
      @rfq1 = FactoryGirl.create(:jobshop_rfqx_rfq, :product_name => 'new name', :drawing_num => '12345', :customer_id => @cust.id, :sales_id => @u.id)
      @quote = FactoryGirl.create(:jobshop_quotex_quote, :rfq_id => @rfq.id)
      @quote1 = FactoryGirl.create(:jobshop_quotex_quote, :rfq_id => @rfq1.id)
      @o = FactoryGirl.create(:mfg_orderx_order, :rfq_id => @rfq.id, :quote_id => @quote.id)
      @o1 = FactoryGirl.create(:mfg_orderx_order, :rfq_id => @rfq1.id, :quote_id => @quote1.id)
      
      visit '/'
      #save_and_open_page
      fill_in "login", :with => @u.login
      fill_in "password", :with => 'password'
      click_button 'Login'
    end
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      o = FactoryGirl.create(:order_samplex_sample,  :order_id => @o.id)
      visit samples_path
      page.should have_content('Samples')
      click_link('Edit')
      page.should have_content('Edit Sample')
      
      visit samples_path
      click_link(o.id.to_s)
      #save_and_open_page
      page.should have_content('Sample Info')
      click_link('New Log')
      #save_and_open_page
      page.should have_content('Log')
      
      visit samples_path(:order_id => @o.id)
      click_link('New Sample')
      page.should have_content('New Sample')
    end
  end
end
