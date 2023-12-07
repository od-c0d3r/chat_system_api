module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    mapping do
      indexes :body, type: 'text'
    end

    def self.search(query)
      params = {
        query: {
          multi_match: {
            query: query,
            fields: %w[body],
            fuzziness: 'AUTO'
          }
        }
      }

      __elasticsearch__.search(params).records.to_a
    end
  end
end
