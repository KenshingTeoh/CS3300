require 'rails_helper'
# More Projects Features
RSpec.feature "Projects", type: :feature do
  # When creating a new project with "Test title" in title section
  context "Create new project" do
    before(:each) do
      visit new_project_path
      within("form") do
        fill_in "Title", with: "Test title"
      end
    end
    # Test case when you create a new project with testing description should return succesfully created
    scenario "should be successful" do
      fill_in "Description", with: "Test description"
      click_button "Create Project"
      expect(page).to have_content("Project was successfully created")
    end
    # Test case when you create a new project with empty description should return fail or error mesaage
    scenario "should fail" do
      click_button "Create Project"
      expect(page).to have_content("Description can't be blank")
    end
  end
  # When performing Update Project
  context "Update project" do
    let(:project) { Project.create(title: "Test title", description: "Test content") }
    before(:each) do
      visit edit_project_path(project)
    end
    # Test case when you update the description with some content should return succesfully updated
    scenario "should be successful" do
      within("form") do
        fill_in "Description", with: "New description content"
      end
      # When user click "Update Project" button
      click_button "Update Project"
      expect(page).to have_content("Project was successfully updated")
    end
    # Test case when you update the project with empty string should return fail or error message
    scenario "should fail" do
      within("form") do
        fill_in "Description", with: ""
      end
      # When user click "Update Project" button
      click_button "Update Project"
      expect(page).to have_content("Description can't be blank")
    end
  end
  # Remove existing project feature
  context "Remove existing project" do
    let!(:project) { Project.create(title: "Test title", description: "Test content") }
    scenario "remove project" do
      visit projects_path
      click_link "Destroy"
      expect(page).to have_content("Project was successfully destroyed")
      expect(Project.count).to eq(0)
    end
  end
end