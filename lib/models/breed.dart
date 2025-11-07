class Breed {
  final String name;

  Breed({required this.name});

  factory Breed.fromJson(String key) => Breed(name: key);
}
