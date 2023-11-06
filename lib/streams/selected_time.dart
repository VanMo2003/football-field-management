import 'dart:async';

import '../helper/constants/format_calendart.dart';

class SelectedDayStreams {
  String selectedDay = dateFormat.format(DateTime.now());

  StreamController<String?> selectedDayController = StreamController<String?>();

  Stream get selectedDayStream => selectedDayController.stream;

  void setSelectedDay(String selectedDay) {
    selectedDayController.sink.add(selectedDay);
  }

  void dispose() {
    selectedDayController.close();
  }
}
