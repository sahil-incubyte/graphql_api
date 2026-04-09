# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    def self.expose_resource(name:, type:, model:)
      plural_name = name.to_s.pluralize

      field plural_name, [ type ], null: false
      define_method(plural_name) do
        model.all
      end

      field name, type, null: true do
        argument :id, ID, required: true
      end
      define_method(name) do |id:|
        model.find_by(id: id)
      end
    end

    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [ Types::NodeType, null: true ], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ ID ], required: true, description: "IDs of the objects."
    end

    expose_resource name: :user, type: Types::UserType, model: User
    expose_resource name: :post, type: Types::PostType, model: Post

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World!"
    end
  end
end
