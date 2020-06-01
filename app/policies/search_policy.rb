class SearchPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.active_search || user.admin
        scope.all
      else
        scope.first(5)
      end
    end
  end

  def index?
    false
  end

  def create?
    true
  end

  def show?
    user_is_owner_or_admin?
  end

  private

  def user_is_owner_or_admin?
    record.user == user || user.admin
  end

  def user_can_search_or_admin?
    user.active_search || user.admin
  end
end
