import 'dart:async';

import 'package:flutter/material.dart';
import 'package:spark_list_view/app_styles.dart';

class SparkListView extends StatefulWidget {

  const SparkListView({Key? key}) : super(key: key);

  @override
  _SparkListViewState createState() => _SparkListViewState();
}

class _SparkListViewState extends State<SparkListView> with SingleTickerProviderStateMixin{

  final double angle = 0.7;
  int previousDirection = -1;
  int? currentDirection;
  late AnimationController animationController;
  Animation? animation;
  StreamController<int> streamController = StreamController();

  @override
  void initState() {
    streamController.sink.add(previousDirection);
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    animation = Tween<double>(begin: 0, end: 0).animate(animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.key,
      appBar: AppBar(
        title: const Text('Spark'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: AppStyles.Gradient(context),
          ),
        ),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollStartNotification) {
            if(animation != null){
              animationController.reset();
              animation = null;
            }
          } else if (notification is ScrollUpdateNotification) {
            currentDirection = notification.scrollDelta!.isNegative? 1: -1;
            if(previousDirection != currentDirection){
              previousDirection = currentDirection!;
              streamController.sink.add(currentDirection!);
            }
          } else if (notification is ScrollEndNotification) {
            if(animation == null){
              animation = Tween<double>(begin: angle, end: 0).animate(animationController);
              animationController.forward();
            }
          }
          return true;
        },
        child: StreamBuilder<int>(
          stream: streamController.stream,
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: 1000,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: AnimatedBuilder(
                    animation: animationController,
                    builder: (context, child) {
                      return Transform(
                        transform: Matrix4.identity()..setEntry(3, 2, 0.002)..rotateX((animation == null? (snapshot.data! * angle): (snapshot.data! * animation!.value)).toDouble()),
                        alignment: FractionalOffset.center,
                        child: Container(
                            height: 75,
                            decoration: BoxDecoration(
                              border: const Border.symmetric(
                                vertical: BorderSide(width: 1, color: AppStyles.ActionColor),
                                horizontal: BorderSide(width: 0.5, color: AppStyles.ActionColor),
                              ),
                              gradient: AppStyles.Gradient(context),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Text(' ${index+1}', style: const TextStyle(color: AppStyles.ActionColor)),
                              ),
                              title: Text('Item No. ${index+1}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppStyles.ActionColor)),
                              subtitle: Row(
                                children: [
                                  Text('Item count is ${index+1}', style: const TextStyle(fontSize: 12, color: AppStyles.ActionColor)),
                                  const SizedBox(width:25,),
                                  Expanded(
                                    child: LinearProgressIndicator(
                                      value: (index+1)/1000,
                                      backgroundColor: Colors.white,
                                      valueColor: const AlwaysStoppedAnimation<Color>(AppStyles.ActionColor),
                                      minHeight: 7,
                                    )
                                  )
                                ],
                              ),
                              trailing: const Card(
                                child: Icon(Icons.menu, color: AppStyles.ActionColor)
                              ),
                            )
                        ),
                      );
                    }
                  ),
                );
              }
            );
          }
        ),
      )
    );
  }
}

