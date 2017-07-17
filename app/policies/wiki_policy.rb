class WikiPolicy < ApplicationPolicy
    attr_reader :user, :wiki

    def initialize(user, wiki)
        @user = user
        @wiki = wiki
    end

    def create?
        user.present?
    end

    def show?
      if wiki.private?
        user.premium? || user.admin? || wiki.user == user
      else
        true
      end
    end

    def new?
        create?
    end

    def update?
        user.present? && (@wiki.user == user)
    end

    def edit?
        update?
    end

    def destroy?
        user.admin? || (@wiki.user == user)
    end
end
