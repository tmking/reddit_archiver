module RedditArchiver
  module FileWriter

    def subdirectory
      self.class.name.split('::').last.downcase.pluralize
    end

    def subdirectories
      self.submission_title ? File.join(subdirectory, self.submission_title) : subdirectory
    end

    def filename
      "#{self.year_month_date}_#{self.title_url}"[0..96]
    end

    def ext
      ".md"
    end

    def filename_with_full_path
      File.join(File.dirname(__FILE__), '../../', RedditArchiver.config.directory, subdirectories, filename + ext)
    end

    def target_directory
      File.dirname(filename_with_full_path)
    end

    def write
      Dir.mkdir(target_directory) unless File.directory?(target_directory)
      file = File.new(filename_with_full_path, 'w')
      file.puts(self.file_contents)
      file.close
    end
  end
end
