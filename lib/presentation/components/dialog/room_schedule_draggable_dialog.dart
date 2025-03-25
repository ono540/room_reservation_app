import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:room_reservation_app/presentation/components/dialog/room_schedule_input_dialog.dart';
import 'package:room_reservation_app/presentation/providers/time_schedule_provider.dart';


class RoomScheduleDraggableDialog extends StatefulWidget {
  const RoomScheduleDraggableDialog({
    super.key,
    required this.registrationDate,
    required this.registrationType,
  });

  final String registrationDate;
  final String registrationType;

  @override
  RoomScheduleDraggableDialogState createState() =>
      RoomScheduleDraggableDialogState();
}

class RoomScheduleDraggableDialogState
    extends State<RoomScheduleDraggableDialog> {
  @override
  void initState() {
    super.initState();
    // Optionally, initialize any state you need
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final dialogWidth = screenSize.width / 2;
    final dialogHeight = screenSize.height / 2;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Stack(
          children: [
            Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return GestureDetector(
                onTap: () {
                  ref.read(timeScheduleNotifierProvider.notifier).reset();
                  Navigator.of(context).pop();
                },
                child: Container(
                  color: Colors.black.withOpacity(0.1),
                ),
              );
            }),
            Center(
              child: Material(
                elevation: 4.0,
                child: RoomScheduleInputDialog(
                  width: dialogWidth,
                  height: dialogHeight,
                  registrationDate: widget.registrationDate,
                  registrationType: widget.registrationType,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
