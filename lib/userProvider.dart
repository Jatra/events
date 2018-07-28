import 'package:events/api.dart';
import 'package:events/userBloC.dart';
import 'package:flutter/widgets.dart';

class UserProvider extends InheritedWidget {
  final UserBloc userBloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static UserBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(UserProvider) as UserProvider)
          .userBloc;

  UserProvider({Key key, UserBloc userBloc, Widget child})
      : this.userBloc = userBloc ?? UserBloc(API()),
        super(child: child, key: key);
}
