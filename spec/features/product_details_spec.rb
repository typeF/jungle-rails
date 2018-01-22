require 'rails_helper'

RSpec.feature "Visitor navigates from home page to product page", type: :feature, js: true do
  #Setup
  before :each do
    @category = Category.create! name: 'Apparel'
  
    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They can see the product detail page" do
    #Act
    visit root_path
    first('article header a').click

    #DEBUG
    # save_screenshot
  
    #VERIFY
    expect(page).to have_css('section.products-show')
  end


end



