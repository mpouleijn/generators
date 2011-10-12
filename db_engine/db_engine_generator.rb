class DbEngineGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  argument :database_engine, :type => :string, :default => "sqlite"
    
  def check_for_valid_engine
    begin
      engine
    rescue NoMethodError
      raise NoMethodError, "The avalible database generators are (#{engines.join(', ')})"
    end
  end
  
  def check_if_required_gem_is_installed
    begin
      case database_engine
      when "mysql"
        require 'mysql2'
        engine = 'mysql'
      else
        require 'sqlite3'
        engine = 'sqlite'
      end
    rescue LoadError
      raise LoadError, "Make sure the #{database_engine} installed!"
    end
  end
  
  def copy_database_file
    File.delete("#{Rails.root}/config/database.yml") if File.exists?("#{Rails.root}/config/database.yml")
    template "database.#{engine}.yml", "config/database.yml"
  end
  
  private
  
  def engine
    engines = %w(sqlite mysql)
    
    if engines.include?(database_engine)
      return database_engine.to_s
    else
      raise NoMethodError, "The avalible database generators are (#{engines.join(', ')})"
      break
    end
  end
end
