module EnjuResourceMerge
  class Ability
    include CanCan::Ability

    def initialize(user, ip_address = nil)
      case user.try(:role).try(:name)
      when 'Administrator'
        can :manage, [
          AgentMerge,
          AgentMergeList
        ]
      when 'Librarian'
        can :manage, [
          AgentMerge,
          AgentMergeList
        ]
      end
    end
  end
end
