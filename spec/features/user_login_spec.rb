require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do
  before :each do
    @user = User.create! first_name: "Paul", last_name: "Chen", email: "pc647@gmail.com", password: "password123", password_confirmation: "password123"

  
  end

  scenario "Log In successfully" do
    # ACT
    visit root_path

    # DEBUG / VERIFY
    # expect(page).to have_content "My Cart (0)" 
    # first("article.product").find('.button-add').click
    # page.save_screenshot
    # expect(page).to have_content "My Cart (1)" 
    
    # page.save_screenshot
    # puts page.html

    click_link 'Login'
    fill_in :email, with: 'pc647@gmail.com'
    fill_in :password, with: 'password123'

    
    click_on "Submit"
    expect(page).to have_content "Signed in as Paul Chen" 
    page.save_screenshot
  end
end
