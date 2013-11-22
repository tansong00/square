class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    if user.root?
      can :manage, :all
    elsif user.present?

      can :download, Album do |album|
        user.has_role? :designer, album
      end
      can :new_attach, Album
      can :create_attach, Album

      can :download, Attachment
      can :manage, Attachment do |attach|
        attach.user.id = user.id
      end

      can :create, Task
      can :tmp, Task
      can :remove_album, Task
      can :add_pic, Task
      can :list_pic, Task
      can :publish, Task

      basic_read
    else
      basic_read
    end
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
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end

  def basic_read
    can :read, Album
    can :read, Task
  end
end
