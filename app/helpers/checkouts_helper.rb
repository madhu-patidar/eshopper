module CheckoutsHelper
  def review(params)
     if !current_customer.addresses.pluck(:id).include?(params[:address_id].to_i)
      redirect_to root_path
    else
      @address = Address.find(params[:address_id])
      if @address.status == "inactive"
        redirect_to root_path
      end
    end
  end
end