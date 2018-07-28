
class User {
  final String id;
  final String name;
  final String notes;

  User(this.id, this.name, this.notes);

  User.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        notes = json['notes'];
}