require_dependency "order_samplex/application_controller"

module OrderSamplex
  class SamplesController < ApplicationController
    before_filter :require_employee
    before_filter :load_parent_record
    
    def index
      @title = t('Samples')
      @samples = params[:order_samplex_samples][:model_ar_r]
      @samples = @samples.where(:order_id => @order.id) if @order
      @samples = @samples.page(params[:page]).per_page(@max_pagination)
      @erb_code = find_config_const('sample_index_view', 'order_samplex_samples')
    end
  
    def new
      @title = t('New Sample')
      @sample = OrderSamplex::Sample.new()
      @erb_code = find_config_const('sample_new_view', 'order_samplex_samples')
    end
  
    def create
      @sample = OrderSamplex::Sample.new(params[:sample], :as => :role_new)
      @sample.last_updated_by_id = session[:user_id]
      if @sample.save
        redirect_to CGI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Saved!")
      else
        flash[:notice] = t('Data Error. Not Saved!')
        render 'new'
      end
    end
  
    def edit
      @title = t('Update Sample')
      @sample = OrderSamplex::Sample.find_by_id(params[:id])
      @erb_code = find_config_const('sample_edit_view', 'order_samplex_samples')
    end
  
    def update
      @sample = OrderSamplex::Sample.find_by_id(params[:id])
      @sample.last_updated_by_id = session[:user_id]
      if @sample.update_attributes(params[:sample], :as => :role_update)
        redirect_to CGI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Updated!")
      else
        flash[:notice] = t('Data Error. Not Updated!')
        render 'edit'
      end
    end
  
    def show
      @title = t('Sample Info')
      @sample = OrderSamplex::Sample.find_by_id(params[:id])
      @erb_code = find_config_const('sample_show_view', 'order_samplex_samples')
    end
    
    protected
    def load_parent_record
      @order = OrderSamplex.order_class.find_by_id(params[:order_id]) if params[:order_id].present?
      @order = OrderSamplex.order_class.find_by_id(OrderSamplex::Sample.find_by_id(params[:id]).order_id) if params[:id]
    end
  end
end
