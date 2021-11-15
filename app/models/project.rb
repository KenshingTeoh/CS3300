class Project < ApplicationRecord
    # Check if it is empty for title and description while creating a new project
    validates_presence_of :title, :description
end
