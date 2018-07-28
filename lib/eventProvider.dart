import 'package:events/api.dart';
import 'package:events/eventBloc.dart';
import 'package:flutter/widgets.dart';

class EventProvider extends InheritedWidget {
  final EventBloc eventBloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static EventBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(EventProvider) as EventProvider)
          .eventBloc;

  EventProvider({Key key, EventBloc eventBloc, Widget child})
      : this.eventBloc = eventBloc ?? EventBloc(API()),
        super(child: child, key: key);
}
