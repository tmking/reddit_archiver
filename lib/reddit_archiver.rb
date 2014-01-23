require "reddit_archiver/version"
require "reddit_archiver/config"
require "reddit_archiver/account"
require "reddit_archiver/file_writer"
require "reddit_archiver/post"
require "reddit_archiver/comment"
require "reddit_archiver/submission"

module RedditArchiver
  def self.config
    RedditArchiver::Config.new
  end
end
