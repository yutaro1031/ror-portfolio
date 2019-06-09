class ArticlePolicy < ApplicationPolicy
  def index?
    true
  end

  class Scope
    attr_reader :user, :scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user && user.admin_flg
        scope.all
      else
        scope.where(publish_flg: true)
      end
    end
  end
end
