import 'package:check/model/dataModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'history_items_view.dart';
import 'home_view.dart';

class DataView extends StatefulWidget {
  late String position;
  DataView({required this.position});

  @override
  _DataViewState createState() => _DataViewState();
}

class _DataViewState extends State<DataView> {
  tableHeader(BuildContext context) {
    return TableRow(children: [
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Text(
          "N",
          textAlign: TextAlign.center,
        ),
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Text(
          "Title",
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Text(
          "Employee decision",
          textAlign: TextAlign.center,
        ),
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Text(
          "Manager decision",
          textAlign: TextAlign.center,
        ),
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Text(
          "Date",
          textAlign: TextAlign.center,
        ),
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: IconButton(
            icon: Icon(
              Icons.info_outline_rounded,
              size: 15,
            ),
            onPressed: () {}),
      )
    ]);
  }

  table(List<TableRow> tableRows) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Table(
          border: TableBorder(
            horizontalInside: BorderSide(width: 0.8),
            verticalInside: BorderSide(width: 0.8),
            bottom: BorderSide(width: 0.8),
            left: BorderSide(width: 0.8),
            right: BorderSide(width: 0.8),
            top: BorderSide(width: 0.8),
          ),
          columnWidths: {0: FlexColumnWidth(0.5), 5: FlexColumnWidth(0.4)},
          children: tableRows,
        ),
      ),
    ]);
  }

  StreamBuilder streamTable() {
    return StreamBuilder(
      stream: dataRef.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: Center(child: CircularProgressIndicator()));
        }
        List documents = snapshot.data.docs;
        List<HistoryItemsView> itemsList = [];
        documents.forEach((element) {
          print("@@@ ${element.data()}");
          itemsList.add(HistoryItemsView(
              context: context,
              dataModel: DataModel.fromSnapshot(element.data()),
              index: itemsList.length,
              position: widget.position));
        });
        return ListView(
          children: itemsList,
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("History"),
          centerTitle: true,
        ),
        body: streamTable()
        );
  }
}
