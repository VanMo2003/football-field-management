import 'dart:async';

import 'package:rxdart/rxdart.dart';

class SelectedDayStreams {
  final selectedDaySubject = BehaviorSubject<String>();

  var selectedDayTransformer = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      sink.add(data);
    },
  );

  Stream<String> get selectedDayStreams =>
      selectedDaySubject.stream.transform(selectedDayTransformer);

  Sink<String> get selectedDaySink => selectedDaySubject.sink;

  void dispose() {
    selectedDaySubject.close();
  }

  // String selectedDay = dateFormat.format(DateTime.now());

  // StreamController<String?> selectedDayController = StreamController<String?>();

  // Stream<String?> get selectedDayStream => selectedDayController.stream;

  // void setSelectedDay(String selectedDay) {
  //   selectedDayController.sink.add(selectedDay);
  // }

  // void dispose() {
  //   selectedDayController.close();
  // }
}
