require 'test_helper'

class UrlsControllerTest < ActionDispatch::IntegrationTest

  test 'it should encode an integer into a Base62 hash' do
    @url = UrlsController.new
    hash = @url.encode(100)

    assert_equal('1C', hash)
  end


  test 'should return an base10 id when given a hash' do
    @url = UrlsController.new
    hash = @url.decode('1C')

    assert_equal(100, hash)
  end

  test 'should return a hash when given a url' do
  end
end
