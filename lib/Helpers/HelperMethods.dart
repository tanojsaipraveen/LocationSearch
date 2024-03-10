class HelperMethods {
  static String getDayName(int dayIndex) {
    List<String> dayNames = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    if (dayIndex < 1 || dayIndex > 7) {
      return 'Invalid day index';
    }
    return dayNames[dayIndex - 1];
  }

  static String getMonthName(int monthIndex) {
    List<String> monthNames = [
      ' Jan',
      ' Feb',
      ' Mar',
      ' Apr',
      ' May',
      ' Jun',
      ' Jul',
      ' Aug',
      ' Sep',
      ' Oct',
      ' Nov',
      ' Dec',
    ];

    // Ensure monthIndex is within valid range
    if (monthIndex < 1 || monthIndex > 12) {
      return 'Invalid month index';
    }

    return monthNames[monthIndex - 1];
  }
}
