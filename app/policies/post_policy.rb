class PostPolicy < ApplicationPolicy  

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end
    
    def resolve
      if user.admin? || user.moderator?
        scope.all
      elsif user.present?
        scope.where(:user_id => user)
      end
    end
  end

  def index?
    true
  end
end