class Admin::DashboardController < Admin::LoginController

  def show
    @products = Product.count
    @categories = Category.count
  end

end
