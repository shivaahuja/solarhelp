class Company {
  final String name;
  final String link;
  final int rating;
  final String logolink;

  Company(
      {required this.name,
      required this.link,
      required this.rating,
      required this.logolink});

  factory Company.fromRTDB(Map<String, dynamic> data) {
    return Company(
      name: data['Name'] ?? 'Tesla',
      link: data['Link'] ?? 'www.Tesla.com',
      rating: data['Rating'] ?? 3,
      logolink:
          data['LogoLink'] ?? 'https://c.tenor.com/6gHLhmwO87sAAAAj/gg.gif',
    );
  }
}
