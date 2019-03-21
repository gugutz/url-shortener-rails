require 'test_helper'

class UrlTest < ActiveSupport::TestCase

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

end
