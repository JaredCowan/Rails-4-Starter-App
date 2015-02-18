class UsersController < ApplicationController
  load_and_authorize_resource
  require 'net/http'

  def show
    @user = User.find_by(first_name: params[:first_name])
    if !@user
      @user = User.find_by(id: params[:id])
    end
  end
end
