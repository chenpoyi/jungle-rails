require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "Click add button changes cart item number" do
    # ACT
    visit root_path

    # DEBUG / VERIFY
    expect(page).to have_content "My Cart (0)" 
    first("article.product").find('.button-add').click
    page.save_screenshot
    expect(page).to have_content "My Cart (1)" 
    
    page.save_screenshot
    puts page.html
  end
end
