class Project < ActiveRecord::Base
  attr_accessible :created_at, :description, :image_url, :progress, :star, :title, :updated_at
end
