import 'dart:async';
import 'dart:convert';

import 'package:events/event.dart';
import 'package:events/urls/urls.dart';
import 'package:events/user.dart';
import 'package:events/occurence.dart';
import 'package:http/http.dart' as http;

class API {
  final http.Client _client = http.Client();


  Future<List<User>> getUsers(String query) async {
    List<User> list = [];
    var uri = Uri.parse(usersUrl.replaceFirst("{1}", query));
    await _client
        .get(uri)
        .then((res) => res.body)
        .then(json.decode)
        .then((users) => users.forEach((user) => (List<User> list, user) {
              list.add(User.fromJson(user));
            }(list, user)));

    return list;
  }

  Future<List<Event>> getEvents(String query) async {
    List<Event> list = [];
    var uri = Uri.parse(eventsUrl.replaceFirst("{1}", query));
    await _client
        .get(uri)
        .then((res) => res.body)
        .then(json.decode)
        .then((events) => events.forEach((event) => (List<Event> list, event) {
              list.add(Event.fromJson(event));
            }(list, event)));

    return list;
  }

  Future<List<Occurence>> getOccurences(String query) async {
    List<Occurence> list = [];
    var uri = Uri.parse(occurencesUrl.replaceFirst("{1}", query));
    await _client
        .get(uri)
        .then((res) => res.body)
        .then(json.decode)
        .then((occurences) => occurences.forEach((occurence) => (List<Occurence> list, occurence) {
              list.add(Occurence.fromJson(occurence));
            }(list, occurence)));

    return list;
  }
}
