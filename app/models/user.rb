class User < ApplicationRecord
    has_many :participants
    has_many :results, through: :participants
end
