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

    def get_agent_merge_list
      @agent_merge_list = AgentMergeList.find(params[:agent_merge_list_id]) if params[:agent_merge_list_id]
    end

    def get_series_statement_merge_list
      @series_statement_merge_list = SeriesStatementMergeList.find(params[:series_statement_merge_list_id]) if params[:series_statement_merge_list_id]
    end
  end
end

ActionController::Base.send(:include, EnjuResourceMerge)
