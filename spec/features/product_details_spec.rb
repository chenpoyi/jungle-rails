require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do

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

  scenario "Click on a product on home page" do
    # ACT
    visit root_path

    # DEBUG / VERIFY
    first("article.product").find('.button-details').click
    
    expect(page).to have_content "Quantity" 
    
    page.save_screenshot
    puts page.html
  end
end
