class JobPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all.last(50)
    end
  end
end
