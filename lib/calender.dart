class Calendar {
  final int year;
  final int month;
  final int day;
  bool isSelect;

  Calendar({
    required this.year,
    required this.month,
    required this.day,
    this.isSelect = false,
  });

  bool get isToday {
    DateTime today = DateTime.now();
    return today.year == year && today.month == month && today.day == day;
  }
}

class Event {
  final Calendar date;
  String event;

  Event({
    required this.date,
    this.event = "(제목 없음)",
  });
}

class EventManager {
  List<Event> events = [];

  void addEvent(Calendar date, String event) {
    events.add(Event(date: date, event: event));
  }

  void deleteEvent(Calendar date, int index){
    events.removeAt(index);
  }

  List<Event> getEventsForDate(Calendar date) {
    return events.where((event) => event.date.year == date.year && event.date.month == date.month && event.date.day == date.day).toList();
  }
}