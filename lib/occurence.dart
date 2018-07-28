
class Occurence {
  final String id;
  final String time;
  final String user;
  final String what;
  final String detail;

  Occurence(this.id, this.time, this.user, this.what, this.detail);

  Occurence.fromJson(Map json)
      : id = json['id'],
        time = json['time'],
        user = json['user'],
        what = json['what'],
        detail = json['detail'];
}