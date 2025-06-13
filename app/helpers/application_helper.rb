module ApplicationHelper
    def cn(*classes)
        classes.join(' ')
    end

    def qualify(entity, *additional)
        entity_name = entity.class.name.downcase
        entity_id = entity.id

        all = [entity_name, entity_id, *additional]
        all.join('_')
    end

    def extract_errors(obj)
        obj&.errors&.full_messages&.to_sentence(words_connector: "\n", two_words_connector: "\n", last_word_connector: "\n")
    end

    def top_link_to(name, url, **params)
        link_to(name, url, data: { turbo_action: 'advance' }, **params)
    end

    def shared(name, locals = {})
        render(partial: "shared/#{name}", locals:)
    end

    def notification
        devise_error = devise_error_messages! rescue nil

        some_alert = (flash[:notice] || flash[:alert] || flash[:error] || devise_error).to_s
        color = (flash[:alert] || flash[:error]) && 'red'

        shared 'notification', { content: some_alert, color:, delay: 2000 } unless some_alert.empty?
    end

    def image(src, *params)
        ApplicationController.helpers.image_tag(ActionController::Base.helpers.asset_path(src), *params)
    end

    def global_asset(src)
        Rails.root.join('public', ActionController::Base.helpers.asset_path(src).sub(%r{\A/}, ''))
    end
end
