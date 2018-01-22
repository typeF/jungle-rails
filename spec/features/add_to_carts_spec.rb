require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
  
  #Setup
  before :each do
    @category = Category.create! name: 'Apparel'
  
    1.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end
  
  scenario "The cart count should increase by one after clicking the add to cart button" do
    #Act
    visit root_path
    first('article footer a', 'Add').click

    #DEBUG
    # save_screenshot
  
    #VERIFY
    expect(page).to have_content("My Cart (1)")
  end


end  






