require 'test_helper'

class UrlsControllerTest < ActionDispatch::IntegrationTest

  test "it should encode an integer into a Base62 hash" do
    hash = Base62.encode(100)

    assert_equals(200, hash)
  end

  test "it should add urls in the db" do
    @url = Url.new({id => 100, original_url => "http://teste.com", hits => 5})
    @url.save

    assert_not_empty(@url.id)

  end
  
end

