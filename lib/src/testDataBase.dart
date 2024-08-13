import 'package:campus_pro/src/databaseHelperClass.dart';
import 'package:flutter/material.dart';

class TestDataBase extends StatefulWidget {
  const TestDataBase({Key? key}) : super(key: key);

  @override
  _TestDataBaseState createState() => _TestDataBaseState();
}

class _TestDataBaseState extends State<TestDataBase> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
              onPressed: () {
                //DataBaseHelper.createItem(title: "First", description: "Done");
              },
              child: Text("Add Data")),
          TextButton(
              onPressed: () {
                DataBaseHelper.deleteItem(1);
              },
              child: Text("Delete Data")),
          TextButton(
              onPressed: () {
                DataBaseHelper.getItems();
              },
              child: Text("show Data")),
          TextButton(
              onPressed: () {
                DataBaseHelper.updateItem(
                    id: 1, title: "Second", description: "Done1");
              },
              child: Text("update Data")),
        ],
      ),
    );
  }
}
