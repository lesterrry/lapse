module LifetimesHelper
	def friendly_date(date)
		date.strftime('%-d.%m.%Y')
	end

	def years_from_periods(periods)
		periods.map { |i| (i.start.year..i.end.year).to_a }.flatten.uniq
	end

	def periods_of_year(periods, year)
		periods.select do |i|
			i.start.year <= year && i.end.year >= year
		end
	end
end
