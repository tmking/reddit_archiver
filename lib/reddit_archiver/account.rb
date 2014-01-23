require 'snoo'

module RedditArchiver
  class Account
    attr_reader :connection, :config

    def initialize
      @config = RedditArchiver.config
      @connection = Snoo::Client.new(username: config.username,
                       password: config.password,
                       useragent: "RedditArchiver #{RedditArchiver::VERSION}")
    end

    def comments
      posts(:comments).map { |p| RedditArchiver::Comment.new(p) }
    end

    def submissions
      posts(:submitted).map { |p| RedditArchiver::Submission.new(p) }
    end

    private

    def posts(type)
      # Reddit's API only allows a maximum of 100 comments at a time.
      # To retrieve more than that (up to the hard limit of 1k), we
      # have to get the 'name' attribute of the last comment and then
      # request the next collection of comments that occur after it.
      posts = retrieve_posts(type: type.to_s)
      current_name = ""

      begin
        previous_name = current_name
        current_name = posts.last["name"]
        posts += retrieve_posts(type: type.to_s, after: current_name)
      end until previous_name == current_name

      posts
    end

    def retrieve_posts(args = {})
      args.merge!(sort: 'new', limit: 100)
      parse_response(connection.get_user_listing(connection.username, args))
    end

    def parse_response(http_response)
      http_response["data"]["children"].map { |p| p["data"] }
    end
  end
end
