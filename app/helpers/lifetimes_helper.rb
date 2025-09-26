module LifetimesHelper
  def friendly_date(date)
    date.strftime('%-d.%m.%Y')
  end

  def years_from_periods(periods)
    periods.map { |i| (i.start.year..i.end.year).to_a }.flatten.uniq.sort
  end

  def periods_of_year(periods, year)
    periods.select do |i|
      i.start.year <= year && i.end.year >= year
    end
  end

  def position_label(deg)
    {
      style: "margin-left: calc(var(--offset) * cos(#{deg}deg)); margin-top: calc(var(--offset) * sin(#{deg}deg))"
    }
  end

  def set_param(*params, current_params: nil)
    current_params ||= request.query_parameters.dup

    set = lambda do |key, value|
      if value
        current_params[key] = value
      else
        current_params.delete(key)
      end
    end

    if params[0].is_a? Array
      params.each { |param| set.call(param[0], param[1]) }
    else
      set.call(params[0], params[1])
    end

    "#{request.path}?#{current_params.to_query}"
  end
end
