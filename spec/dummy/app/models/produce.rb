class Produce < ActiveRecord::Base
  belongs_to :patron
  belongs_to :manifestation
end
