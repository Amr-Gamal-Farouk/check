import 'dart:convert';

import 'package:check/model/employee_model.dart';
import 'package:check/view/screen/home_view.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TeamView extends StatefulWidget {
  @override
  _TeamViewState createState() => _TeamViewState();
}

class _TeamViewState extends State<TeamView> {
  late List<EmployeeModel> employeeList = [];
  bool isLoading = false;
  void getEmployee() async {
    await employeeData.once().then((DataSnapshot snapshot) {
      employeeList = employeeModelFromJson(jsonEncode(snapshot.value));
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    getEmployee();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Our Team"),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: (isLoading)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: employeeList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.withOpacity(0.4)),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () => print(index),
                            dense: true,
                            leading: Icon(
                              Icons.person,
                              size: 30,
                              color: Theme.of(context).primaryColor,
                            ),
                            title: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  employeeList[index].fuLlName,
                                  textAlign: TextAlign.start,
                                )),
                            subtitle: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                    "${employeeList[index].jobTitle} (${employeeList[index].branch})")),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 70),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.alternate_email,
                                  color: Colors.grey.withOpacity(0.8),
                                  size: 15,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    employeeList[index].email,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.withOpacity(0.8)),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 70, vertical: 8),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.phone_iphone,
                                  color: Colors.grey.withOpacity(0.8),
                                  size: 15,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  employeeList[index].mobile,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.withOpacity(0.8)),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ));
  }
}
