class City < ApplicationRecord
  validates :name, uniqueness: { scope: :state,
    message: "One [City, State] pair" }
end
