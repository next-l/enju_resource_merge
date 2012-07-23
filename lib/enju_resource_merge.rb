require "enju_resource_merge/engine"

module EnjuResourceMerge
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def enju_resource_merge
      include EnjuResourceMerge::InstanceMethods
    end
  end

  module InstanceMethods
    private

    def get_patron_merge_list
      @patron_merge_list = PatronMergeList.find(params[:patron_merge_list_id]) if params[:patron_merge_list_id]
    end

    def get_series_statement_merge_list
      @series_statement_merge_list = SeriesStatementMergeList.find(params[:series_statement_merge_list_id]) if params[:series_statement_merge_list_id]
    end
  end
end

ActionController::Base.send(:include, EnjuResourceMerge)
