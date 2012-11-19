require 'spec_helper'

describe SeriesStatementMergeList do
  fixtures :all

  it "should merge series_statment" do
    series_statement_merge_list = series_statement_merge_lists(:series_statement_merge_list_00001)
    series_statement = SeriesStatement.find(2)
    series_statement_merge_list.merge_series_statements(series_statement).should be_true
    Manifestation.find(2).series_statement.id.should eq 2
    Manifestation.find(3).series_statement.id.should eq 2
    Manifestation.find(3).series_statement.original_title.should eq series_statement.original_title
  end
end

# == Schema Information
#
# Table name: series_statement_merge_lists
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

