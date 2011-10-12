class DefaultLocalesGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  argument :locale, :type => :string, :default => 'en'

  def copy_default_locales
    case locale
      when "en"
        template "en.action_view.yml", "config/locales/en.action_view.yml"
        template "en.active_model.yml", "config/locales/en.active_model.yml"
        template "en.active_record.yml", "config/locales/en.active_record.yml"
        template "en.active_support.yml", "config/locales/en.active_support.yml"
      else
        raise "Locale not supported"
    end
  end
end
