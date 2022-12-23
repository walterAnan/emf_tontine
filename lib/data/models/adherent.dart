
class Adherent {
  final int id;
  final String name;
  final int age;

  const Adherent({
    required this.id,
    required this.name,
    required this.age,
  });

  Map<String, dynamic> toJason() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }
  @override
  String toString() {
    return 'Adherent{id: $id, name: $name, age: $age}';
  }


}
