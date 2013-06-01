class ApplicationController < ActionController::Base
  protect_from_forgery

  enju_resource_merge
  enju_leaf
  enju_biblio
  enju_library
end
