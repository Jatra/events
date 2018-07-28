import 'package:events/api.dart';
import 'package:events/event.dart';
import 'package:events/eventBloc.dart';
import 'package:events/eventProvider.dart';
import 'package:events/occurenceBloc.dart';
import 'package:events/occurenceProvider.dart';
import 'package:events/userBloC.dart';
import 'package:events/userProvider.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OccurenceProvider(
      occurenceBloc: OccurenceBloc(API()),
      child: UserProvider(
        userBloc: UserBloc(API()),
        child: EventProvider(
          eventBloc: EventBloc(API()),
          child: new MaterialApp(
            title: 'Flutter Demo',
            theme: new ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: new HomePage(),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userBloc = UserProvider.of(context);
    final eventBloc = EventProvider.of(context);
    final occurenceBloc = OccurenceProvider.of(context);
    occurenceBloc.query.add("");
    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
          ),
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (builder) {
                  return SheetContainer(key: GlobalKey());
                });
          }),
      body: Column(
        children: <Widget>[
          Flexible(
            child: StreamBuilder(
              stream: occurenceBloc.results,
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: Text("no results"),
                  );
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) => ListTile(
                        leading: Text(snapshot.data[index].id),
                        title: Text(
                            "${snapshot.data[index].what} ${snapshot.data[index]
                                .detail}"),
                        subtitle:
                            Text("${snapshot.data[index].user} - ${snapshot
                            .data[index].time}"),
                      ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Function onInput(UserBloc userBloc, EventBloc eventBloc) {
    return eventBloc.query.add;
  }
}

class SheetContainer extends StatelessWidget {
  SheetContainer({Key key}) : super(key: key);

  Iterable<Widget> _getWidgets(List<Event> events, BuildContext context) sync* {
    for (Event event in events) {
      yield ActionChip(
          backgroundColor: Colors.blue,
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
          label: new Text("${event.name}, ${event.description}"),
          onPressed: () {
            print("${event.name}");
            Navigator.pop(context);
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final eventBloc = EventProvider.of(context);
    eventBloc.query.add("");
    return Container(
        color: Colors.blueGrey,
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            Flexible(
              child: StreamBuilder(
                  stream: eventBloc.results,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: Text("loading..."));
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        runSpacing: 4.0,
                        spacing: 8.0,
                        children: _getWidgets(snapshot.data, context).toList(),
                      ),
                    );
                  }),
            ),
          ],
        ),
    );
  }
}
