require "application_system_test_case"

class UrlsTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit '/'
  
    assert_selector 'h1', text: 'Shorten Your Links'
  end
end
