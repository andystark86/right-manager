module RightManager
  class Role < ApplicationRecord

    has_many :roles_rights, dependent: :destroy
    accepts_nested_attributes_for :roles_rights, allow_destroy: true, reject_if: :default_value


    has_many :rights, through: :roles_rights
    has_many :users, class_name: RightManager.user_class.to_s, foreign_key: RightManager.role_foreign_key

    validates :name, presence: true, uniqueness: true

    scope :sorted, -> {order("right_manager_roles.name ASC")}


    # default value is always RightManager::Right::NO
    # so we don't have to save all roles<-->rights access_level NO combinations
    def default_value(attributes)
      exists = attributes['id'].present?
      obsolete = attributes['access_level'].to_i == RightManager::Right::NO
      attributes[:_destroy] = 1 if exists && obsolete # destroy FALSE Rights
      return (!exists && obsolete) # reject FALSE Right
    end

  end
end
