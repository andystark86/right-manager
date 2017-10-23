require "right_manager/engine"
require "right_manager/error"

module RightManager

  mattr_accessor :role_foreign_key
  mattr_accessor :user_class
  mattr_accessor :available_rights

  class << self
    def user_class
      @@user_class.constantize
    end

    def available_rights
      @@available_rights ||= []
    end
  end

end
