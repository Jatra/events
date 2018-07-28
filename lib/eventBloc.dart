import 'dart:async';
import 'package:events/event.dart';
import 'package:events/api.dart';

import 'package:rxdart/rxdart.dart';

class EventBloc {
  final API api;

  Stream<List<Event>> _results = Stream.empty();
  Stream<String> _log = Stream.empty();

  ReplaySubject<String> _query = ReplaySubject<String>();

  Stream<String> get log => _log;
  Stream<List<Event>> get results => _results;
  Sink<String> get query => _query;

  EventBloc(this.api) {
    _results = _query.asyncMap(api.getEvents).asBroadcastStream();
//    _results = _query.distinct().asyncMap(api.getEvents).asBroadcastStream();

    _log = Observable(results)
      .withLatestFrom(_query.stream, (_, query) => 'Results for $query')
      .asBroadcastStream();
  }

  void dispose() {
    _query.close();
  }
}