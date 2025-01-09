import 'package:flutter/material.dart';

class RouteObservers extends NavigatorObserver{

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print("Ok");
  }
}