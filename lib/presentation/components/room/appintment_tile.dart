import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentTile extends StatelessWidget {
  final Appointment appointment;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const AppointmentTile({
    super.key,
    required this.appointment,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: appointment.subject,
      child: Stack(
        children: [
          InkWell(
            onTap: onEdit,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: appointment.color,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  appointment.subject,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 2,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              constraints: const BoxConstraints(),
              icon: const Icon(Icons.delete, size: 12, color: Colors.white),
              onPressed: onDelete,
            ),
          ),
        ],
      ),
    );
  }
}
