class Admin::LoginController < ApplicationController
  http_basic_authenticate_with name: ENV["name"], password: ENV["password"]

  def show
  end
end
