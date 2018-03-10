class Entry < ApplicationRecord
    belongs_to :feed
    self.per_page = 10
end
