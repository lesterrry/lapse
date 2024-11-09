User.delete_all

User.create(username: 'lesterrry') do |user|
	user.first_name = 'aydar'
	user.last_name = 'prikol'
	user.email = 'me@aydar.media'

	Lifetime.create(title: 'Мемуары лил пипа', description: "isn't life beautiful", user:)

	lifetime = Lifetime.create(title: 'Эры Тейлор Свифт', description: '(taylor\'s version)', user:)

	Period.create(title: 'Taylor Swift', description: 'First studio album', start: DateTime.parse('2006-10-24 00:00:00'), end: DateTime.parse('2007-11-10 23:59:59'), lifetime:)

	Period.create(title: 'Fearless', description: 'Second studio album', start: DateTime.parse('2008-11-11 00:00:00'), end: DateTime.parse('2010-01-01 00:00:00'), lifetime:)

	Period.create(title: 'Speak Now', description: 'Third studio album', start: DateTime.parse('2010-10-25 00:00:00'), end: DateTime.parse('2012-10-21 23:59:59'), lifetime:)

	Period.create(title: 'Red', description: 'Fourth studio album', start: DateTime.parse('2012-10-22 00:00:00'), end: DateTime.parse('2014-10-26 23:59:59'), lifetime:)

	Period.create(title: '1989', description: 'Fifth studio album', start: DateTime.parse('2017-01-01 00:00:00'), end: DateTime.parse('2017-11-09 23:59:59'), lifetime:)

	Period.create(title: 'Reputation', description: 'Sixth studio album', start: DateTime.parse('2017-11-10 00:00:00'), end: DateTime.parse('2019-08-22 23:59:59'), lifetime:)

	Period.create(title: 'Lover', description: 'Seventh studio album', start: DateTime.parse('2019-08-23 00:00:00'), end: DateTime.parse('2020-07-23 23:59:59'), lifetime:)

	Period.create(title: 'Folklore', description: 'Eighth studio album', start: DateTime.parse('2020-07-24 00:00:00'), end: DateTime.parse('2021-04-08 23:59:59'), lifetime:)

	Period.create(title: 'Fearless (Taylor\'s Version)', description: 'First re-recorded album', start: DateTime.parse('2021-04-09 00:00:00'), end: DateTime.parse('2022-07-11 23:59:59'), lifetime:)
end
