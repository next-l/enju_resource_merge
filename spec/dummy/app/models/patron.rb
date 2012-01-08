# -*- encoding: utf-8 -*-
class Patron < ActiveRecord::Base
  scope :readable_by, lambda{|user| {:conditions => ['required_role_id <= ?', user.try(:user_has_role).try(:role_id) || Role.where(:name => 'Guest').select(:id).first.id]}}
  belongs_to :user
  belongs_to :patron_type
  belongs_to :required_role, :class_name => 'Role', :foreign_key => 'required_role_id', :validate => true
  belongs_to :language

  validates :full_name, :presence => true, :length => {:maximum => 255}

  def self.per_page
    10
  end
end
