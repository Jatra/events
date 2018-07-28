import 'dart:async';
import 'package:events/occurence.dart';
import 'package:events/api.dart';

import 'package:rxdart/rxdart.dart';

class OccurenceBloc {
  final API api;

  Stream<List<Occurence>> _results = Stream.empty();
  Stream<String> _log = Stream.empty();

  ReplaySubject<String> _query = ReplaySubject<String>();

  OccurenceBloc(this.api) {
    _results = _query.distinct().asyncMap(api.getOccurences).asBroadcastStream();

    _log = Observable(results)
      .withLatestFrom(_query.stream, (_, query) => 'Results for $query')
      .asBroadcastStream();
  }

  Stream<String> get log => _log;

  Stream<List<Occurence>> get results => _results;
  Sink<String> get query => _query;

  void dispose() {
    _query.close();
  }
}