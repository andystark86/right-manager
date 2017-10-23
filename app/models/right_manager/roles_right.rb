module RightManager
  class RolesRight < ApplicationRecord

    belongs_to :role
    belongs_to :right

    validates :right, presence: true
    validates :role, presence: true, uniqueness: {scope: :right}

  end
end
