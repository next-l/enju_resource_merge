require 'spec_helper'

describe SeriesStatementMergeList do
  fixtures :all

  it "should merge series_statment" do
    series_statement_merge_list = series_statement_merge_lists(:series_statement_merge_list_00001)
    series_statement_merge_list.merge_series_statements(SeriesStatement.find(1)).should be_true
    Manifestation.find(2).series_statement.id.should eq 1
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

