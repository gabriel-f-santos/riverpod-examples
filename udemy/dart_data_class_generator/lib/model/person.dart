class Person {
  final String name;
  final int age;
  final String email;

  Person({
    required this.name,
    required this.age,
    required this.email,
  });

  @override
  String toString() {
    return 'Person{name: $name, age: $age, email: $email}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Person && other.name == name && other.age == age;
  }

  @override
  int get hashCode => name.hashCode ^ age.hashCode;

  Person copyWith({
    String? name,
    int? age,
    String? email,
  }) {
    return Person(
      name: name ?? this.name,
      age: age ?? this.age,
      email: email ?? this.email,
    );
  }
}