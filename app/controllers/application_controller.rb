class ApplicationController < ActionController::Base
  def index
    puts "Método index do ApplicationController está sendo chamado"
    render 'layouts/application'
  end

  def render_json(data)
    render json: data
  end
end
