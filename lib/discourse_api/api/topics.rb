module DiscourseApi
  module API
    module Topics
      # :category OPTIONAL name of category, not ID
      # :skip_validations OPTIONAL boolean
      # :auto_track OPTIONAL boolean
      def create_topic(title:, raw:, category: nil, skip_validations: nil, auto_track: nil)
        post("/posts",
             title: title,
             raw: raw,
             category: category,
             skip_validations: skip_validations,
             auto_track: auto_track)
      end

      def latest_topics(*args)
        response = get('/latest.json', args)
        response[:body]['topic_list']['topics']
      end

      def new_topics(*args)
        response = get("/new.json", args)
        response[:body]['topic_list']['topics']
      end

      def rename_topic(topic_id, title)
        put("/t/#{topic_id}.json", { topic_id: topic_id, title: title })
      end

      def recategorize_topic(topic_id, category_id)
        put("/t/#{topic_id}.json", { topic_id: topic_id, category_id: category_id })
      end

      def topic(id, *args)
        response = get("/t/#{id}.json", args)
        response[:body]
      end

      def topics_by(username, *args)
        response = get("/topics/created-by/#{username}.json", args)
        response[:body]['topic_list']['topics']
      end

      def delete_topic(id)
        delete("/t/#{id}.json")
      end
    end
  end
end