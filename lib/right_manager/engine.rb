module RightManager

  class Engine < ::Rails::Engine
    isolate_namespace RightManager
    require 'jquery-rails'
    require "bootstrap-sass"
    require "haml-rails"
    require "kaminari"
    require "bootstrap-kaminari-views"

    config.i18n.load_path += Dir["#{config.root}/config/locales/defaults/*.yml"]
    config.i18n.load_path += Dir["#{config.root}/config/locales/right_manager/*.yml"]

    config.to_prepare do
      #RightManager.user_class.send :include, Kaminari::ActiveRecordExtension
    end


  end

end
