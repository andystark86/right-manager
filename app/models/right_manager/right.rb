module RightManager
  class Right < ApplicationRecord

    ACCESS_OF_ROLE = 2.freeze
    YES = 1.freeze
    NO = 0.freeze

    belongs_to :group, optional: true

    has_many :roles_rights, dependent: :destroy
    has_many :roles, through: :roles_rights

    has_many :users_rights, dependent: :destroy
    has_many :users, class_name: RightManager.user_class.to_s, through: :users_rights

    validates :name, presence: true, uniqueness: true

    scope :sorted, -> {order("right_manager_rights.name ASC")}

    scope :sorted_by_group, -> {includes(:group).order('right_manager_groups.name ASC', 'right_manager_rights.name ASC')}

  end
end
