class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionHelper
  before_filter :redirect_unless_signed_in
end
