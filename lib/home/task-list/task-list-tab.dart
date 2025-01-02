import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/firebase-utils.dart';
import 'package:todo_application/models/task.dart';
import 'package:todo_application/providers/auth-provider.dart';
import '../../my-theme.dart';
import '../../providers/list-provider.dart';
import 'task-widget.dart';

class TaskListTab extends StatefulWidget {
  @override
  State<TaskListTab> createState() => _TaskListTabState();
}

class _TaskListTabState extends State<TaskListTab> {

  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
var authProvider = Provider.of<AuthProvider>(context,listen: false);

      listProvider.getAllTasksFromFireStore(authProvider.currentUser?.id??'');


    return Column(
      children: [
        CalendarTimeline(
          initialDate: listProvider.selectDate,
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (date) {
            listProvider.changeSelectedDate(date,authProvider.currentUser?.id??'');
          },
          leftMargin: 20,
          monthColor: MyTheme.blackColor,
          dayColor: MyTheme.blackColor,
          activeDayColor: Colors.white,
          activeBackgroundDayColor: Theme.of(context).primaryColor,
          dotsColor: MyTheme.whiteColor,
          selectableDayPredicate: (date) =>  true,//date.day != 23,
          locale: 'en_ISO',
        ),
        Expanded(
          child: ListView.builder(
              itemBuilder: (context, index) {
                return TaskWidgetItem(task:listProvider.tasksList[index]);
              },
          itemCount: listProvider.tasksList.length,
          ),
        )
      ],
    );
  }

}
