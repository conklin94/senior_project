class Verb < ApplicationRecord
  has_many :object_or_types, dependent: :destroy
end
