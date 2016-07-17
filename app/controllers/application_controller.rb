class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def hello
    render html: "Fragrant Vagrant's Character Port.fol.io"
  end
end
