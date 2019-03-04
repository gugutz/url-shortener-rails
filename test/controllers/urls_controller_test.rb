require 'test_helper'

class UrlsControllerTest < ActionDispatch::IntegrationTest

  test 'it should encode an integer into a Base62 hash' do
    @url = UrlsController.new
    hash = @url.encode(100)

    assert_equal('1C', hash)
  end

  test 'it should only save valid URLs' do
    @url = Url.new(original_url: 'testing with an invalid url')
    @url.save

    assert_equal(true, @url.new_record?)
  end

  test 'it should save urls to the db' do
    @url = Url.new(original_url: 'http://teste.com', hits: 5)
    @url.save

    assert_equal(false, @url.new_record?)
  end

  test 'it should increase hits' do
    @url = Url.new(original_url: 'http://teste.com', hits: 3)
    @url.hit
    assert_equal(4, @url.hits)
  end

  test 'should return an base10 id when given a hash' do
    @url = UrlsController.new
    hash = @url.decode('1C')

    assert_equal(100, hash)
  end

  test 'should return a hash when given a url' do
  end
end
