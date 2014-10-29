module Feeder
  module Concerns::Models::Report
    extend ActiveSupport::Concern

    included do
      belongs_to :reporter, polymorphic: true
      belongs_to :item

      validates :item, presence: true

      scope :by, ->(reporter) { where reporter: reporter }
      scope :handled, -> { where('handled_at <= ?', Time.now.utc) }
      scope :unhandled, -> { where('handled_at IS NULL OR handled_at > ?', Time.now.utc) }

      def handle
        update handled_at: Time.now
      end

      def reopen
        update handled_at: nil
      end
    end
  end
end
