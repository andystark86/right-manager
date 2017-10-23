module RightManager
  class Group < ApplicationRecord

    has_many :rights

    validates :name, presence: true

    scope :sorted, -> {order("right_manager_groups.name ASC")}

  end
end
