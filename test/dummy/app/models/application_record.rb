class ApplicationRecord < ActiveRecord::Base
  include Hyper::App
  self.abstract_class = true
end
