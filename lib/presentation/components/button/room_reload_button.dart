import 'package:flutter/material.dart';

class RoomReloadButton extends StatelessWidget {
  final VoidCallback onPressed;

  const RoomReloadButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.refresh, color: Colors.white),
        label: const Text(
          "Reload",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.grey[600]!, width: 1.5), // 枠線の色と太さ
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // 角丸
          ),
          padding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 16), // 余白調整
        ),
      ),
    );
  }
}
