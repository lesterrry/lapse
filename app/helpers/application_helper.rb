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

    def top_link_to(name, url)
        link_to(name, url, data: { turbo_action: 'advance' })
    end
end
