class Ability
  include CanCan::Ability

  def initialize(user)

    if user.nil?
        can [:read] , [Article, Comment, Category]
    elsif user.role? "admin"
        can [:create,:destroy,:update], :all #[:Article,:Comment,:Category,:Role]
        can :read, :all
    elsif user.role?  "author"
        can :create, [Article,Comment]
        can :update, Article do|article|
            article.user == user
        end
        can :read , [Article,Category]
    elsif user.role? "moderator"
        can :read, [Article,Comment]
        can :update, Article
    elsif user.role? "user"
        can :read, [Article,Comment,Category]
        can :create , Comment
        can :destroy , Comment do |comment|
            comment.user == user
        end
    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
