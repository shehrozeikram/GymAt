class ServicesController < ApplicationController
  def index

  end

  def shop
    @services = Service.all

  end

  def show
    @service = Service.find(params[:id])
  end

  def facilities
    @services = Service.all
  end

  def individual
    @services = Service.all
  end

  def appartments
    @services = Service.all
  end

end
