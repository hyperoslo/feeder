module Feeder
  module Concerns::Helpers::Filter
    extend ActiveSupport::Concern

    included do
      scope :filter, ->(*options) {
        args = []
        types = []
        scopes = {}
        wheres = []

        options.each do |opt|
          if opt <= ::ActiveRecord::Base && opt.instance_of?(Class) # Model class name as argument
            types << opt.name
          elsif opt.class.name.eql? "ActiveRecord::Relation"
            model = opt.model.name
            scopes[model] = [] unless scopes[model].present?
            scopes[model] << opt
          end
        end

        combine_scopes(scopes, wheres, args) unless scopes.empty?
        combine_types(types, wheres, args) unless types.empty?
        where(wheres.join(" OR "), *(args))
      }

      def self.combine_scopes(all_scopes, wheres, args)
        all_scopes.each do |model, scopes|
          scope = scopes.shift
          scope = scopes.inject(scope) { |res, scope| res.merge(scope) } unless scopes.empty?
          wheres << "(feedable_type = ? AND feedable_id in (?))"

          args << model << scope.pluck(:id)
        end
      end

      def self.combine_types(types, wheres, args)
         unless types.empty?
          wheres << "(feedable_type in (?))"
          args << types
        end
      end
    end
  end
end
