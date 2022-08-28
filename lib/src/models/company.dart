class Company {
  final String name;
  final String link;

  Company({required this.name, required this.link});

  factory Company.fromRTDB(Map<String, dynamic> data) {
    return Company(
        name: data['Name'] ?? 'Tesla', link: data['Link'] ?? 'www.Tesla.com');
  }
}
