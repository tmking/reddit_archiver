require 'spec_helper'

describe RedditArchiver::Comment do
  let(:post) { EXAMPLE_COMMENT["data"] }

  subject { RedditArchiver::Comment.new(post) }

  its(:year_month_date) { should eq("2013-09-19_00-29-37") }
  its(:filename) { should eq('2013-09-19_00-29-37_test-test-test-t1_cccccc') }
  its(:body) { should eq('Hello.') }
  its(:score) { should eq(3) }
  its(:subdirectory) { should eq('comments') }
  its(:title) { should eq('test-test-test-t1_cccccc') }

  context "The file" do
    let(:comment) { RedditArchiver::Comment.new(post) }

    before { comment.write }

    it "is created" do
      expect(File.exists?(comment.filename_with_full_path)).to be_true
    end

    it "has the contents of the post" do
      file = File.read(comment.filename_with_full_path)
      expect(file).to eq(comment.file_contents)
    end
  end
end
