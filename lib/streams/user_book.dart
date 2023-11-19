import 'package:football_field_management/api/model/user_data.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class UserBookStreams {
  final listSubject = BehaviorSubject<List<UserData>>();
  List<UserData> list = [];

  var listStreamTransformer =
      StreamTransformer<List<UserData>, List<UserData>>.fromHandlers(
    handleData: (data, sink) {
      data.sort(
        (a, b) {
          int sortSelectedDate = a.selectedDay.compareTo(b.selectedDay);
          if (sortSelectedDate == 0) {
            int sortName = a.nameFootballField.compareTo(b.nameFootballField);
            if (sortName == 0) {
              int sortNumberYard = a.numberYard.compareTo(b.numberYard);
              if (sortNumberYard == 0) {
                return a.timeSlot.compareTo(b.timeSlot);
              }
              return sortNumberYard;
            }
            return sortName;
          }
          return -sortSelectedDate;
        },
      );
      sink.add(data);
    },
  );

  Stream<List<UserData>> get listStreams =>
      listSubject.stream.transform(listStreamTransformer);

  Sink<List<UserData>> get listSink => listSubject.sink;
  void dispose() {
    listSubject.close();
  }

  void clearData() {
    listSubject.value.clear();
  }
}
