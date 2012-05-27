class SeriesStatementMergeList < ActiveRecord::Base
  attr_accessible :title
  has_many :series_statement_merges, :dependent => :destroy
  has_many :series_statements, :through => :series_statement_merges
  validates_presence_of :title

  def self.per_page
    10
  end

  def merge_series_statements(selected_series_statement)
    series_statements.each do |series_statement|
      unless series_statement == selected_series_statement
        series_statement.manifestations.each do |manifestation|
          manifestation.series_statement = selected_series_statement
          manifestation.save!
        end
        series_statement.destroy
      end
    end
  end
end

# == Schema Information
#
# Table name: series_statement_merge_lists
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

