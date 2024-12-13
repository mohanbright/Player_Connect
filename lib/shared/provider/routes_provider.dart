import 'package:flutter/material.dart';

class RoutesProvider extends ChangeNotifier {
  static String getCurrentRoutes(BuildContext context) {
    ModalRoute<Object?>? currentRoute = ModalRoute.of(context);
    if (currentRoute != null) {
      String? routeName = currentRoute.settings.name;

      if (routeName != null) {
        return routeName;
      }
    }

    return 'UnknownScreen';
  }
   String? currentClassName;

   String getCurrentClassName(BuildContext context) {
    var currentWidget = context.widget;
    String className = currentWidget.runtimeType.toString();
    currentClassName=className;
    print("currentClassName:$currentClassName");
    return className;
  }
}
