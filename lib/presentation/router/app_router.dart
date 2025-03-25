import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

import '../screen/home_screen.dart';
import '../screen/room_management_screen.dart';
import '../state/schedule_state/schedule_state.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: '/', page: HomeRoute.page, initial: true, children: [
          AutoRoute(path: 'RoomManagement', page: RoomManagementRoute.page),
        ]),
      ];
}
