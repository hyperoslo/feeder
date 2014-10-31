require 'acts_as_votable'
require 'kaminari/config'
require 'kaminari/models/page_scope_methods'
require 'kaminari/models/configuration_methods'
require 'kaminari/models/active_record_model_extension'

module Feeder
  module Concerns::Models::Item
    extend ActiveSupport::Concern

    included do
      include Kaminari::ActiveRecordModelExtension
      include Feeder::Concerns::Helpers::Filter

      singleton_class.send(:alias_method, :kaminari_page, :page)

      acts_as_votable

      scope :unblocked, -> { where blocked: false }
      scope :blocked,   -> { where blocked: true }

      belongs_to :feedable, polymorphic: true
      has_many :reports

      def type
        feedable_type.underscore
      end

      def report(reporter = nil)
        if reporter
          return if reported_by?(reporter)
          reports.create! reporter: reporter
        else
          reports.create!
        end
      end

      def block
        update blocked: true
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

      def reported?
        reports.any?
      end

      def reported_by?(reporter)
        reports.by(reporter).any?
      end
    end
  end
end
