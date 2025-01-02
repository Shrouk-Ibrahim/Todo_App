import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/dialog_utils.dart';
import 'package:todo_application/firebase-utils.dart';
import 'package:todo_application/models/task.dart';
import 'package:todo_application/providers/auth-provider.dart';
import 'package:todo_application/providers/list-provider.dart';
import 'package:todo_application/providers/list-provider.dart';
import '../../providers/list-provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime selectedDate = DateTime.now();
  String formattedSelectedDate = '';
  var formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  late ListProvider listProvider  ;
  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of<ListProvider>(context);
    return Container(
      padding: EdgeInsets.all(12),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Add new Task',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: (text){
                          title = text ;
                        },
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'please enter title task';
                          }
                          return null;
                        },
                        decoration: InputDecoration(hintText: 'Enter task title'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: (text){
                          description = text ;
                        },
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'please enter task description';
                          }
                          return null;
                        },
                        decoration:
                            InputDecoration(hintText: 'Enter task Description'),
                        maxLines: 4,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'select date',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showCalendar();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(formattedSelectedDate,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleSmall),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          addTask();
                        },
                        child: Text(
                          'Add',
                          style: Theme.of(context).textTheme.titleLarge,
                        ))
                  ],
                ))
          ],
        ),
      ),
    );
  }

  void showCalendar() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (chosenDate != null) {
      selectedDate = chosenDate;
      formattedSelectedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
      setState(() {});
    }
  }

  void addTask() {
    if(formKey.currentState?.validate()== true){

      Task task =Task(title: title,
          dateTime: selectedDate,
          description: description);
      var authProvider = Provider.of<AuthProvider>(context,listen: false);
      DialogUtils.showLoading(context, 'Waiting,,,,');
      FireBaseUtils.addTaskToFireStore(task, authProvider.currentUser?.id?? '').
      then((value) {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context, 'Task Added Successfully',
        positiveActionName: 'ok',
          positiveAction: (){
          Navigator.pop(context);
          }
        );
      })

          .
      timeout(
          Duration(milliseconds: 500),
      onTimeout: (){
            print('task added succes');
            listProvider.getAllTasksFromFireStore(authProvider.currentUser?.id??'');
            Navigator.pop(context);
      }
      );

    }
  }
}
