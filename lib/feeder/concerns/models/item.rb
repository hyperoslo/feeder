require 'acts_as_votable'

module Feeder
  module Concerns::Models::Item
    extend ActiveSupport::Concern

    included do
      include Feeder::Concerns::Helpers::Filter

      acts_as_votable

      scope :unblocked, -> { where blocked: false }
      scope :blocked,   -> { where blocked: true }

      belongs_to :feedable, polymorphic: true

      def type
        feedable_type.underscore
      end

      def report
        update reported: true
      end

      def block
        update blocked: true
      end

      def unreport
        update reported: false
      end

      def unblock
        update blocked: false
      end

      def recommend
        self.update recommended: true
      end

      def unrecommend
        self.update recommended: false
      end

      def liked_by?(voter, scope = nil)
        self.find_votes_for(voter: voter, vote_scope: scope).any?
      end

      def likes scope = nil
        self.find_votes_for(vote_scope: scope)
      end

      def liked? scope = nil
        likes(scope).any?
      end
    end
  end
end
