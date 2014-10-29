module Feeder
  module Concerns::Models::Report
    extend ActiveSupport::Concern

    included do
      belongs_to :reporter, polymorphic: true
      belongs_to :item

      validates :item, presence: true

      scope :by, ->(reporter) { where reporter: reporter }
    end
  end
end
