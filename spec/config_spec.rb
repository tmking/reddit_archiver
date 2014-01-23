require 'spec_helper'

describe RedditArchiver::Config do
  let(:yaml_data) { YAML.load(YAML_CONTENT) }

  before { allow(YAML).to receive(:load_file).
           with('config.yml').
           and_return(yaml_data) }

  context "With the values from the config file" do
    subject { RedditArchiver::Config.new }
    its(:username) { should eq('foo') }
    its(:password) { should eq('bar') }
    its(:directory) { should eq('spec/output/foobar') }
  end

  context "With no directory value" do
    subject { RedditArchiver::Config.new }

    before do
      yaml_data.delete('directory')
      Dir.stub(:mkdir).and_return(true)
    end

    its(:directory) { should eq('foo') }
  end

  context "Overriding the configuration values" do
    subject { RedditArchiver::Config.new('username' => 'something',
                                         'password' => 'else',
                                         'directory' => 'altogether')
    }

    its(:username) { should eq('something') }
    its(:password) { should eq('else') }
    its(:directory) { should eq('altogether') }
  end
end
