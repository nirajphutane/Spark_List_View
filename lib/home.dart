import 'package:flutter/material.dart';
import 'package:spark_list_view/spark_listview.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return const SparkListView();
  }
}
