import 'package:flutter/material.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  const DeleteConfirmationDialog(
      {super.key,
      required this.onConfirm,
      required this.content,
      required this.registrationDate});
  final String content;
  final String registrationDate;
  final VoidCallback onConfirm; // 削除を確認したときに呼び出されるコールバック

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      title: const Text(
        '削除確認',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
          color: Colors.redAccent,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'このアイテムを削除しますか？',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10.0),
          Divider(color: Colors.grey.shade300), // 区切り線を追加
          const SizedBox(height: 10.0),
          Text(
            '日付: $registrationDate\n内容: $content',
            style: const TextStyle(
              fontSize: 14.0,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey,
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop(); // ダイアログを閉じる
          },
          child: const Text('No'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onPressed: () {
            onConfirm(); // 削除を実行するコールバックを呼び出す
            Navigator.of(context).pop(); // ダイアログを閉じる
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
