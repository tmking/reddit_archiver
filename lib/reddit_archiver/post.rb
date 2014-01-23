require 'htmlentities'
require 'active_support/inflector'

I18n.enforce_available_locales = false

module RedditArchiver
  class Post
    include RedditArchiver::FileWriter

    attr_reader :created, :subreddit, :reddit_id, :title

    def initialize(post)
      @created = Time.at(post["created"])
      @subreddit = post["subreddit"]
      @reddit_id = post["name"]
    end

    def title_url
      title.parameterize
    end

    def submission_title
      nil
    end

    def year_month_date
      created.strftime('%F_%H-%M-%S')
    end
  end
end
