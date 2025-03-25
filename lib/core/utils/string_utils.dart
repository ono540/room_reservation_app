bool isTextValid(String? text) {
  return text != null && text.trim().isNotEmpty;
}

String formatRoomScheduleText({
  required String startTime,
  String? endTime,
  required String content,
  required String matchingType,
}) {
  if (endTime == null || endTime.isEmpty) {
    return '$matchingType:$startTime \n$content';
  } else {
    return '$matchingType:$startTime - $endTime\n$content';
  }
}
