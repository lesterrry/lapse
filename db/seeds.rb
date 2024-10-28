# User.delete_all; exit 0

User.find_or_create_by(username: 'lesterrry') do |user|
	user.first_name = 'aydar'
	user.last_name = 'prikol'
	user.email = 'me@aydar.media'

	Lifetime.create(title: 'Мемуары лил пипа', description: "isn't life beautiful", user:)
	lifetime = Lifetime.create(title: 'Жизнь моего деда', description: 'Подлинная история', user:)

	Period.create(title: 'Поиск работы', description: 'I was looking for a job and then I found a job', start: DateTime.parse('2023-02-01 00:00:00'), end: DateTime.parse('2023-07-26 00:00:00'), lifetime:)
	Period.create(title: 'хааххаха', description: 'мяу', start: DateTime.parse('2023-07-27 00:00:00'), end: DateTime.parse('2023-08-01 00:00:00'), lifetime:)
	Period.create(title: 'др', description: 'с др', start: DateTime.parse('2023-08-16 00:00:00'), end: DateTime.parse('2023-10-01 00:00:00'), lifetime:)
end
