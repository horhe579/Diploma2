# test/system/cards_test.rb

require "application_system_test_case"

class CardsTest < ApplicationSystemTestCase
  setup do
    login_as users(:accountant)
    @card = Card.ordered.first # Reference to the first fixture card
  end

  test "Creating a new card" do
    # When we visit the Cards#index page
    # we expect to see a title with the text "Cards"
    visit cards_path
    assert_selector "h1", text: "Cards"

    # When we click on the link with the text "New card"
    # we expect to land on a page with the title "New card"
    click_on "New card"
    fill_in "Name", with: "Capybara card"
    
    # When we fill in the name input with "Capybara card"
    # and we click on "Create card"
    assert_selector "h1", text: "Cards"
    click_on "Create card"

    # We expect to be back on the page with the title "Cards"
    # and to see our "Capybara card" added to the list
    assert_selector "h1", text: "Cards"
    assert_text "Capybara card"
  end

  test "Showing a card" do
    visit cards_path
    click_link @card.name

    assert_selector "h1", text: @card.name
  end

  test "Updating a card" do
    visit cards_path
    assert_selector "h1", text: "Cards"

    click_on "Edit", match: :first
    fill_in "Name", with: "Updated card"
    
    assert_selector "h1", text: "Cards"
    click_on "Update card"

    assert_selector "h1", text: "Cards"
    assert_text "Updated card"
  end

  test "Destroying a card" do
    visit cards_path
    assert_text @card.name

    click_on "Delete", match: :first
    assert_no_text @card.name
  end
end