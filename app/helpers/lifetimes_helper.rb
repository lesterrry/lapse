module LifetimesHelper
	def friendly_date(date)
		date.strftime('%-d %b %Y')
	end

	def years_from_periods(periods)
		p periods.map { |i| i.start.year }.uniq
	end

	def periods_of_year(periods, year)
		periods.select do |i|
			i.start.year == year
		end
	end
end
