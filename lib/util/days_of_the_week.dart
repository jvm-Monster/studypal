class DaysOfTheWeek {
  // Helper method to parse selectedDay as a day of the week
  static int parseDayOfWeek(String selectedDay) {
    switch (selectedDay.toLowerCase()) {
      case 'sunday':
        return DateTime.sunday;
      case 'monday':
        return DateTime.monday;
      case 'tuesday':
        return DateTime.tuesday;
      case 'wednesday':
        return DateTime.wednesday;
      case 'thursday':
        return DateTime.thursday;
      case 'friday':
        return DateTime.friday;
      case 'saturday':
        return DateTime.saturday;
      default:
        throw ArgumentError('Invalid day of the week: $selectedDay');
    }
  }

  // Helper method to parse selectedDay as a day of the week
  static int parseNumberDayOfWeek(int selectedDay) {
    switch (selectedDay) {
      case 1:
        return DateTime.sunday;
      case 2:
        return DateTime.monday;
      case 3:
        return DateTime.tuesday;
      case 4:
        return DateTime.wednesday;
      case 5:
        return DateTime.thursday;
      case 6:
        return DateTime.friday;
      case 7:
        return DateTime.saturday;
      default:
        throw ArgumentError('Invalid day of the week: $selectedDay');
    }
  }
}
