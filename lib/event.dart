
class Event {
  final String id;
  final String name;
  final String description;

  Event(this.id, this.name, this.description);

  Event.fromJson(Map json)
      : id = json['id'],
        name = json['event_name'],
        description = json['event_description'];
}