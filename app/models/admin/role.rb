module Admin
  class Role < ApplicationRecord
    validates :email, format: /@/
  end
end