require 'reddit_archiver'
require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)

YAML_CONTENT = <<-EOF
  username: foo
  password: bar
  directory: spec/output/foobar
EOF

PARSED_YAML = YAML.load(YAML_CONTENT)

EXAMPLE_COMMENT = {"data" => {"subreddit_id"=>"t5_aaaaa", "link_title"=>"Test Test Test", "banned_by"=>nil, "subreddit"=>"test", "link_author"=>"test", "likes"=>true, "replies"=>nil, "saved"=>false, "id"=>"abc123", "gilded"=>0, "author"=>"me", "parent_id"=>"t3_aaaaa", "approved_by"=>nil, "body"=>"Hello.", "edited"=>false, "author_flair_css_class"=>"", "downs"=>1, "body_html"=>"&lt;div class=\"md\"&gt;&lt;p&gt;Hello.&lt;/p&gt;\n&lt;/div&gt;", "link_id"=>"t3_bbbbb", "score_hidden"=>false, "name"=>"t1_cccccc", "created"=>1379564977.0, "author_flair_text"=>"flair", "created_utc"=>1379561377.0, "ups"=>4, "num_reports"=>0, "distinguished"=>nil}}

EXAMPLE_SUBMISSION = {"data" => {"subreddit_id"=>"t5_aaaaa", "link_title"=>"Test Test Test", "banned_by"=>nil, "subreddit"=>"test", "link_author"=>"test", "likes"=>true, "replies"=>nil, "saved"=>false, "id"=>"abc123", "gilded"=>0, "author"=>"me", "parent_id"=>"t3_aaaaa", "approved_by"=>nil, "body"=>"Hello.", "edited"=>false, "author_flair_css_class"=>"", "downs"=>1, "body_html"=>"&lt;div class=\"md\"&gt;&lt;p&gt;Hello.&lt;/p&gt;\n&lt;/div&gt;", "link_id"=>"t3_bbbbb", "score_hidden"=>false, "name"=>"t1_cccccc", "created"=>1379564977.0, "author_flair_text"=>"flair", "created_utc"=>1379561377.0, "ups"=>4, "num_reports"=>0, "distinguished"=>nil, "permalink" => "http://example.com", "title" => "Test post", "is_self" => true, "selftext" => "&gt; Hello.", "selftext_html" => "&nbsp;Hello.", "url" => "http://google.com"}}

RSpec.configure do |config|
  config.before(:each) do
    YAML.stub(:load_file).and_call_original
    YAML.stub(:load_file).with('config.yml').and_return(PARSED_YAML)
  end
  config.after(:all) { system('rm -Rf spec/output/*') }
end

