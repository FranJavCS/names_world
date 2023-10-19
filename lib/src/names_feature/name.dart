class Name {
  const Name(
      {required this.id,
      required this.name,
      required this.meaning,
      required this.gender});

  final String name;
  final int id;
  final String meaning;
  final String gender;

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      id: json['id'],
      name: json['name'],
      meaning: json['meaning'],
      gender: json['gender'],
    );
  }
}
