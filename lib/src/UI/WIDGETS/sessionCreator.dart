String? getCustomYear() {
  final todayDate = DateTime.now();
  if (todayDate.month != 1 && todayDate.month != 2 && todayDate.month != 3) {
    final session =
        "${DateTime(todayDate.year).year}-${DateTime(todayDate.year + 1).year}";
    return session;
  } else {
    final session =
        "${DateTime(todayDate.year - 1).year}-${DateTime(todayDate.year).year}";
    return session;
  }
}
