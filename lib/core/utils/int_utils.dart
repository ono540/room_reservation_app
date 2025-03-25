/// 文字列が有効な整数値かどうかをチェック
bool isIntValid(int? id) {
  return id != null;
}

/// 文字列を整数に変換（失敗時はnullを返す）
int? toInt(String? text) {
  if (text == null || text.trim().isEmpty) return null;
  try {
    return int.parse(text);
  } catch (e) {
    return null;
  }
}

/// 整数値が指定範囲内かどうかをチェック
bool isInRange(int value, int min, int max) {
  return value >= min && value <= max;
}

/// 整数値が正の数かどうかをチェック
bool isPositive(int value) {
  return value > 0;
}

/// 整数値が0以上かどうかをチェック
bool isNonNegative(int value) {
  return value >= 0;
}
