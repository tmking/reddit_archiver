module RedditArchiver
  class Submission < Post
    attr_reader :permalink, :title, :url, :selftext, :score, :is_self

    def initialize(submission)
      @permalink = submission["permalink"]
      @title = submission["title"]
      @url = submission["url"]
      @selftext = HTMLEntities.new.decode(submission["selftext"])
      @score = submission["score"]
      @is_self = submission["is_self"]
      super
    end

    def body
      is_self ? selftext : url
    end

    def file_contents
      <<-EOF.gsub(/^ {8}/, '')
        Date: #{created}
        Subreddit: /r/#{subreddit}
        Link: http://reddit.com#{permalink}
        Score: #{score}

        # #{title}

        #{body}
      EOF
    end
  end
end
