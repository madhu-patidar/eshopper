class Banner < ActiveRecord::Base
  has_many :pictures, as: :imageable, dependent: :destroy
end
