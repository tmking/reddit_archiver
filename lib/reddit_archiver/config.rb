require 'yaml'

module RedditArchiver
  class Config
    attr_reader :username, :password, :directory

    def initialize(args = {})
      @username, @password, @directory = YAML.load_file('config.yml').merge!(args).values_at("username", "password", "directory")
      @directory ||= username

      maybe_create_target_directory
      maybe_create_target_subdirectories
    end

    def subdirectories
      %w(submissions comments).map { |subdir| "#{directory}/#{subdir}" }
    end

    private

    def maybe_create_target_directory
      unless File.directory?(directory)
        Dir.mkdir(directory)
      end
    end

    def maybe_create_target_subdirectories
      %w(submissions comments).each do |subdir|
        target_subdir = File.join(directory, subdir)
        unless File.directory?(target_subdir)
          Dir.mkdir(target_subdir)
        end
      end
    end
  end
end