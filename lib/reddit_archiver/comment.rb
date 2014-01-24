module RedditArchiver
  class Comment < Post
    attr_reader :subreddit, :body, :score, :link_title, :link_id, :link_author

    def initialize(comment)
      @body = comment["body"]
      @score = comment["ups"] - comment["downs"]
      @link_title = comment["link_title"]
      @link_id = comment["link_id"]
      @link_author = comment["link_author"]
      super
    end

    def submission_link
      "http://reddit.com/r/#{subreddit}/comments/#{link_id.split('_').last}"
    end

    def title
      "#{submission_title}-#{reddit_id}"
    end

    def submission_title
      link_title.parameterize[0..96]
    end

    def file_contents
      <<-EOF.gsub(/^ {8}/, '')
        Date: #{created}
        On Post: #{link_title} by #{link_author}
        Subreddit: /r/#{subreddit}
        Link: #{submission_link}
        Score: #{score}

        #{body}
      EOF
    end
  end
end
