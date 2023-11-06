import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/model/manage_information.dart';
import '../../../api/model/user_infmation.dart';
import '../../../api/request/manager_request.dart';
import '../../../helper/constants/format_calendart.dart';
import 'family_user.dart';
import 'set_yard.dart';

class UserHome extends StatefulWidget {
  const UserHome(
      {super.key, required this.email, required this.userInformationAPI});

  final String email;
  final UserInformationAPI userInformationAPI;
  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  final TextEditingController _searchController = TextEditingController();
  RxString selectedDay = dateFormat.format(DateTime.now()).obs;

  final List<String> _data = [];

  List<String> _filteredData = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    ManagerRequest.getFootballField().then((value) {
      setState(() {
        _data.addAll(value);
      });
    });
    _filteredData = _data;
    _searchController.addListener(_performSearch);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _performSearch() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 1000));

    setState(() {
      _filteredData = _data
          .where((element) => element
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green.shade500, Colors.lightGreen],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: TextField(
            controller: _searchController,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            decoration: const InputDecoration(
              hintText: 'Search...',
              hintStyle: TextStyle(color: Colors.white54),
              border: InputBorder.none,
            ),
          ),
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Colors.white),
              )
            : ListView.builder(
                itemCount: _filteredData.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    ManageInformationAPI manageInformationAPI =
                        ManageInformationAPI(
                      email: '',
                      permission: false,
                      nameFootballField: '',
                      nameManage: '',
                      totalYards: 0,
                    );
                    ManagerRequest.getInformationdByNameFootballField(
                      _filteredData[index],
                    ).then(
                      (value) {
                        manageInformationAPI = value;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FamilyUser(
                              userInformationAPI: widget.userInformationAPI,
                              child: SetYard(
                                nameFootballField:
                                    manageInformationAPI.nameFootballField,
                                selectedDay: selectedDay,
                                totalYards: manageInformationAPI.totalYards,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: ListTile(
                    title: Text(
                      _filteredData[index],
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
        backgroundColor: Colors.lightGreen.shade700,
      ),
    );
  }
}
