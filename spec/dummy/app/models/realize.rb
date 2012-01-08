class Realize < ActiveRecord::Base
  belongs_to :patron
  belongs_to :expression, :class_name => 'Manifestation', :foreign_key => 'expression_id'
end
