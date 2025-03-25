// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeScreen();
    },
  );
}

/// generated route for
/// [RoomManagementScreen]
class RoomManagementRoute extends PageRouteInfo<void> {
  const RoomManagementRoute({List<PageRouteInfo>? children})
      : super(
          RoomManagementRoute.name,
          initialChildren: children,
        );

  static const String name = 'RoomManagementRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RoomManagementScreen();
    },
  );
}
