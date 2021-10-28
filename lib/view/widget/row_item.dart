import 'package:check/model/dataModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../screen/home_view.dart';

tableRow(
    {required BuildContext context,
    required DataModel data,
    required int index,
    required String position}) {
  return TableRow(children: [
    TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Text(
        index.toString(),
        textAlign: TextAlign.center,
      ),
    ),
    TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Text(
        data.title,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Text(
        data.employee,
        textAlign: TextAlign.center,
      ),
    ),
    TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Text(
        data.manager,
        textAlign: TextAlign.center,
      ),
    ),
    TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Text(
        DateFormat('yyyy-MM-dd').format(DateTime.fromMicrosecondsSinceEpoch(
            data.timesTemp.microsecondsSinceEpoch)),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: IconButton(
          icon: Icon(
            Icons.info_outline_rounded,
            size: 15,
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: Container(
                      height: 420,
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Container(
                                height: 150,
                                color: Colors.red,
                                child: GestureDetector(
                                  child: Image(
                                    image: NetworkImage(data.mediaUrl),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Container(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            child: Image(
                                              image:
                                                  NetworkImage(data.mediaUrl),
                                            ),
                                          ),
                                        ));
                                  },
                                )),
                          ),
                          Table(
                            children: [
                              TableRow(children: [
                                Text("title"),
                                Text(data.title),
                              ]),
                              TableRow(children: [
                                Text("employee decision"),
                                Text(data.employee),
                              ]),
                              TableRow(children: [
                                Text("Manager decision"),
                                Text(data.manager.toString()),
                              ]),
                              TableRow(children: [
                                Text("Date"),
                                Text(DateFormat('yyyy-MM-dd').format(
                                    DateTime.fromMicrosecondsSinceEpoch(data
                                        .timesTemp.microsecondsSinceEpoch))),
                              ])
                            ],
                          ),
                          (position == "as Manager")
                              ? (data.manager == "approve")
                                  ? Container()
                                  : FlatButton(
                                      child: Text("approve"),
                                      onPressed: () {
                                        editOption(data, position, context);
                                      },
                                      color: Colors.green,
                                      minWidth: 300,
                                    )
                              : (data.employee == "approve")
                                  ? Container()
                                  : FlatButton(
                                      child: Text("approve"),
                                      onPressed: () {
                                        editOption(data, position, context);
                                      },
                                      color: Colors.green,
                                      minWidth: 300,
                                    ),
                          FlatButton(
                            child: Text("Delete"),
                            onPressed: () {
                              deleteOption(data.postId, context);
                            },
                            color: Colors.red,
                            minWidth: 300,
                          ),
                          FlatButton(
                            child: Text("Cancel"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: Colors.blue,
                            minWidth: 300,
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }),
    )
  ]);
}

deleteOption(String id, BuildContext context) async {
  Navigator.pop(context);
  await dataRef.doc(id).get().then((value) {
    if (value.exists) {
      value.reference.delete();
    }
  });
}

editOption(DataModel dataModel, String position, BuildContext context) async {
  String result;
  if (position == "as Manager") {
    dataModel.manager = "approve";
  } else {
    dataModel.employee = "approve";
  }
  print(dataModel.manager);
  try {
    await dataRef.doc(dataModel.postId).get().then((value) {
      if (value.exists) {
        dataRef.doc(dataModel.postId).update(dataModel.toJson());
        result = "done";
      } else {
        result = "not exist";
      }
    });
  } catch (e) {
    print("@@ Error $e");
  }
  Navigator.pop(context);
}
