require "rails_helper"
# Here is where other user or visitor to view the uploaded projects on Home Page
RSpec.feature "Visiting the homepage", type: :feature do
  scenario "The visitor should see projects" do
    visit root_path
    expect(page).to have_text("Projects")
  end
end