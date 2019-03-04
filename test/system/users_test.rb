require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit users_url
  #
  #   assert_selector "h1", text: "Users"
  # end

  test 'creating a user' do
    visit '/'
    click_on 'Sign Up'

    fill_in 'Name', with: 'Tobias'
    fill_in 'Email', with: 'tobias@mc.com'

    click_on 'Create user'

    assert_text 'Creating an user'
  end
end
