import 'dart:async';
import 'package:events/user.dart';
import 'package:events/api.dart';

import 'package:rxdart/rxdart.dart';

class UserBloc {
  final API api;

  Stream<List<User>> _results = Stream.empty();
  Stream<String> _log = Stream.empty();

  ReplaySubject<String> _query = ReplaySubject<String>();

  Stream<String> get log => _log;
  Stream<List<User>> get results => _results;
  Sink<String> get query => _query;

  UserBloc(this.api) {
    _results = _query.distinct().asyncMap(api.getUsers).asBroadcastStream();

    _log = Observable(results)
      .withLatestFrom(_query.stream, (_, query) => 'Results for $query')
      .asBroadcastStream();
  }

  void dispose() {
    _query.close();
  }
}