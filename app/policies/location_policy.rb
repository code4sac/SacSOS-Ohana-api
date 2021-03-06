class LocationPolicy < ApplicationPolicy
  def new?
    return true if user.super_admin?
    Pundit.policy_scope!(user, Organization).present?
  end

  class Scope < Scope
    def resolve
      return scope.order(:name) if user.super_admin?
      scope.with_email(user.email)
    end
  end
end
