require 'spec_helper'

describe RedditArchiver::Submission do
  let(:post) { EXAMPLE_SUBMISSION["data"] }
  subject { RedditArchiver::Submission.new(post) }

  its(:subdirectory) { should eq('submissions') }
  its(:filename) { should eq('2013-09-19_00-29-37_test-post') }

  context "When the post has its own text" do
    its(:body) { should eq("> Hello.") }
  end

  context "When the post is just a link" do
    before { post.merge!("is_self" => false) }
    its(:body) { should eq("http://google.com") }
  end

  context "The file" do
    let(:submission) { RedditArchiver::Submission.new(post) }

    before { submission.write }

    it "is created" do
      expect(File.exists?(submission.filename_with_full_path)).to be_true
    end

    it "has the contents of the post" do
      file = File.read(submission.filename_with_full_path)
      expect(file).to eq(submission.file_contents)
    end

    it "truncates the name to 97 characters" do
      long_filename = "f"*101
      post = EXAMPLE_COMMENT["data"].merge!("title" => long_filename)
      expect(RedditArchiver::Submission.new(post).filename.size).to eq(97)
    end
  end
end
