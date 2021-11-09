require 'rails_helper'
# Some feature with Porjects
RSpec.feature "Projects", type: :feature do
  # When creating new project
  context "Create new project" do
    before(:each) do
      visit new_project_path
      within("form") do
        fill_in "Title", with: "Test title"
      end
    end
    # Should run successfully with testing decription in Description section while creating new project
    scenario "should be successful" do
      fill_in "Description", with: "Test description"
      click_button "Create Project"
      expect(page).to have_content("Project was successfully created")
    end
    # Should return fail when create a new project with empty description
    scenario "should fail" do
      click_button "Create Project"
      expect(page).to have_content("Description can't be blank")
    end
  end
  # When doing Update for the project
  context "Update project" do
    let(:project) { Project.create(title: "Test title", description: "Test content") }
    before(:each) do
      visit edit_project_path(project)
    end
    # Should run successfully when updating or editing the new description content
    scenario "should be successful" do
      within("form") do
        fill_in "Description", with: "New description content"
      end
      # When the user click update project button should return "Project was successfully updated" message
      click_button "Update Project"
      expect(page).to have_content("Project was successfully updated")
    end
    # Should return fail when update the project description with empty string or message
    scenario "should fail" do
      within("form") do
        fill_in "Description", with: ""
      end
      # Return error message when user click "Update Project" button
      click_button "Update Project"
      expect(page).to have_content("Description can't be blank")
    end
  end
  # The "Remove Project" Feature
  context "Remove existing project" do
    let!(:project) { Project.create(title: "Test title", description: "Test content") }
    scenario "remove project" do
      visit projects_path
      # When user click "Destroy" return "Destroyed succesfully" Message
      click_link "Destroy"
      expect(page).to have_content("Project was successfully destroyed")
      expect(Project.count).to eq(0)
    end
  end
end
# The ProjectsController getting index with the project title and description
RSpec.describe ProjectsController, type: :controller do
  context "GET #index" do
    it "returns a success response" do
      get :index
      # expect(response.success).to eq(true)
      expect(response).to be_success
    end
  end

  context "GET #show" do
    let!(:project) { Project.create(title: "Test title", description: "Test description") }
    it "returns a success response" do
      get :show, params: { id: project }
      expect(response).to be_success
    end
  end
end
