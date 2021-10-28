import 'package:check/model/dataModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryItemsView extends StatefulWidget {
  BuildContext context;
  DataModel dataModel;
  int index;
  String position;
  HistoryItemsView(
      {required this.context,
      required this.dataModel,
      required this.index,
      required this.position});
  @override
  _HistoryItemsViewState createState() => _HistoryItemsViewState(
      position: position, context: context, data: dataModel, index: index);
}

class _HistoryItemsViewState extends State<HistoryItemsView> {
  BuildContext context;
  DataModel data;
  int index;
  String position;
  _HistoryItemsViewState(
      {required this.context,
      required this.data,
      required this.index,
      required this.position});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Container(
        color: Colors.white,
        child: ListTile(
          leading: Icon(
            Icons.history,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(data.title),
          subtitle: Text(
            DateFormat('dd-MM-yyyy').format(DateTime.fromMicrosecondsSinceEpoch(
                data.timesTemp.microsecondsSinceEpoch)),
          ),
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Container(
                  height: MediaQuery.of(context).size.height,
                  child: Image(
                    image: NetworkImage(data.mediaUrl),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
