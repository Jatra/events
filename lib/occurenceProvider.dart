import 'package:events/api.dart';
import 'package:events/occurenceBloc.dart';
import 'package:flutter/widgets.dart';

class OccurenceProvider extends InheritedWidget {
  final OccurenceBloc occurenceBloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static OccurenceBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(OccurenceProvider) as OccurenceProvider)
          .occurenceBloc;

  OccurenceProvider({Key key, OccurenceBloc occurenceBloc, Widget child})
      : this.occurenceBloc = occurenceBloc ?? OccurenceBloc(API()),
        super(child: child, key: key);
}
