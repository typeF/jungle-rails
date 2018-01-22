require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js:true do
  #Setup
  before :each do
    @user = User.create(first_name: "John", last_name: "Smith", email: "test@test.com", password: "123", password_confirmation: "123")
  end
  
  scenario "Users should be able to login and taken back to the home page" do
    #Act
    visit login_path
    fill_in 'email', with: 'test@test.com'
    fill_in 'password', with: '123'
    click_on 'Submit'

    #DEBUG
    # save_screenshot
  
    #VERIFY
    expect(page).to have_content("Logout")
  end

end  






