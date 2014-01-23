require 'spec_helper'

describe RedditArchiver::Account do
  let(:connection) { double(Snoo::Client).as_null_object }
  let(:parsed_response) {{ "json" => { "errors" => [] }}}
  let(:http_response) { double("HTTP response", code: "200") }
  let(:httparty_response) { double(HTTParty::Response,
                               parsed_response: parsed_response,
                               response: http_response) }

  subject(:account) { RedditArchiver::Account.new }

  before do
    allow(Snoo::Client).to receive(:new).and_return(connection)
  end

  it "retreives the posts three times" do
    expect(connection).to receive(:get_user_listing).exactly(3).times
    account.comments
  end
end
