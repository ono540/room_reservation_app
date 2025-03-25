import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../providers/loading_provider.dart';
import '../router/app_router.dart';

bool initNWCheckStart = false;

@RoutePage()
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading =
        ref.watch(loadingStateProvider.select((state) => state.isLoading));

    return Stack(
      children: [
        AutoTabsRouter(
          routes: [
            // const MeetingRoomManagementRoute(),
            RoomManagementRoute()
          ],
          builder: (context, child) {
            final tabsRouter = AutoTabsRouter.of(context);
            return Scaffold(
              body: Row(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: NavigationRail(
                          selectedIndex: tabsRouter.activeIndex,
                          onDestinationSelected: tabsRouter.setActiveIndex,
                          labelType: NavigationRailLabelType.selected,
                          destinations: const [
                            NavigationRailDestination(
                              icon: Icon(Icons.schedule),
                              label: Text('Room'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: child),
                ],
              ),
            );
          },
        ),
        if (isLoading)
          Positioned.fill(
            child: LayoutBuilder(
              builder: (context, constraints) => Stack(
                children: [
                  ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.grey.withOpacity(0.5),
                      BlendMode.srcOver,
                    ),
                    child: AbsorbPointer(
                      absorbing: true,
                      child: Container(
                        color: Colors.blue.withOpacity(0.5),
                        child: Center(
                          child: LoadingAnimationWidget.staggeredDotsWave(
                            color: Colors.white,
                            size: 100,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
