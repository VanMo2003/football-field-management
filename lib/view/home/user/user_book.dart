import 'package:flutter/material.dart';
import 'package:football_field_management/api/request/user_data_request.dart';
import 'package:football_field_management/helper/constants/time_slot_to_string.dart';

import '../../../api/model/user_data.dart';
import 'user_page.dart';

class UserBook extends StatefulWidget {
  const UserBook({super.key, required this.nameUser});

  final String nameUser;

  @override
  State<UserBook> createState() => _UserBookState();
}

class _UserBookState extends State<UserBook> {
  @override
  void initState() {
    super.initState();
    UserDataRequest.getUserBookData(widget.nameUser).then((value) {
      // userBookStreams.setListUserBook(value);
      UserPage.listUserBook.addAll(value);
      UserPage.userBookStreams.listSink.add(UserPage.listUserBook);
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (UserPage.listUserBook != []) {
      UserPage.userBookStreams.clearData();
      UserPage.listUserBook.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    // final familyUser = FamilyUser.of(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Booking'),
          centerTitle: true,
        ),
        body: StreamBuilder(
          stream: UserPage.userBookStreams.listStreams,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<UserData> userBookList = snapshot.data!;
              if (userBookList.isEmpty) {
                return const Center(
                  child: Text(
                    'List Empty',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                );
              }

              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: userBookList.length,
                itemBuilder: (context, index) {
                  String timeSlotString =
                      timeSlotToString(userBookList[index].timeSlot);
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 15.0),
                    padding: const EdgeInsets.all(8.0),
                    height: size.height * 0.2,
                    width: size.width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          offset: Offset(5.0, 5.0),
                          blurRadius: 10.0,
                          spreadRadius: 5.0,
                        )
                      ],
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userBookList[index].nameFootballField,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Text(
                          'Sân số ${userBookList[index].numberYard}($timeSlotString)',
                          style: const TextStyle(
                            fontSize: 24,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Text(
                          'ngày ${userBookList[index].selectedDay}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              const TextSpan(
                                text: 'status : ',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                              TextSpan(
                                text: userBookList[index].status,
                                style: TextStyle(
                                  color:
                                      statusToColor(userBookList[index].status),
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            return const Center(
              child: Text(
                'List Empty',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            );
          },
        ));
  }

  Color statusToColor(String status) {
    if (status == 'COMPLETED') {
      return Colors.red;
    } else {
      return Colors.amber;
    }
  }
}
