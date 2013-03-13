module EnjuResourceMerge
  class Ability
    include CanCan::Ability

    def initialize(user, ip_address = nil)
      case user.try(:role).try(:name)
      when 'Administrator'
        can :manage, [
          PatronMerge,
          PatronMergeList,
          SeriesStatementMerge,
          SeriesStatementMergeList
        ]
      when 'Librarian'
        can :manage, [
          PatronMerge,
          PatronMergeList,
          SeriesStatementMerge,
          SeriesStatementMergeList
        ]
      end
    end
  end
end
