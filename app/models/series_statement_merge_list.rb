class SeriesStatementMergeList < ActiveRecord::Base
  attr_accessible :title
  has_many :series_statement_merges, :dependent => :destroy
  has_many :series_statements, :through => :series_statement_merges
  validates_presence_of :title

  paginates_per 10

  def merge_series_statements(selected_series_statement)
    series_statements.each do |series_statement|
      if series_statement == selected_series_statement
        series_statement.root_manifestation.update_attributes!({
          :original_title => selected_series_statement.original_title,
          :title_transcription => selected_series_statement.title_transcription,
          :title_alternative => selected_series_statement.title_alternative
        }) if series_statement.root_manifestation
      else
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

