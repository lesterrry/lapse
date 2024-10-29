module LifetimesHelper
    def friendly_date(date)
        date.strftime('%-d %b %Y')
    end

    def years_from_periods(periods)
        p periods.map { |i| i.start.year }.uniq
    end
end
