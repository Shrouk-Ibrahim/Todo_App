import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/my-theme.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_application/providers/auth-provider.dart';
import '../../firebase-utils.dart';
import '../../models/task.dart';
import '../../providers/list-provider.dart';

class TaskWidgetItem extends StatefulWidget {
  Task task ;


  TaskWidgetItem({required this.task});

  @override
  State<TaskWidgetItem> createState() => _TaskWidgetItemState();
}

class _TaskWidgetItemState extends State<TaskWidgetItem> {

  bool isDone = false ;
  @override

  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context, listen: false);
    return Slidable(
      // // Specify a key if the Slidable is dismissible.
      // key: const ValueKey(0),

      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        extentRatio: 0.25,
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),
        // A pane can dismiss the Slidable.
        // dismissible: DismissiblePane(onDismissed: () {}),
        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(borderRadius: BorderRadius.only(
              topLeft:Radius.circular(15) ,
          bottomLeft:Radius.circular(15) ),
            onPressed: (context) {
              //delete el task
              var authProvider = Provider.of<AuthProvider>(context, listen: false);
              FireBaseUtils.deleteTaskFromFireStore(widget.task,authProvider.currentUser?.id??'' )
                  .
              timeout(Duration(milliseconds: 500),onTimeout: (){
                print('task deleted');
                listProvider.getAllTasksFromFireStore(authProvider.currentUser?.id??'');
              });

            },
            backgroundColor: MyTheme.redColor,
            foregroundColor: MyTheme.whiteColor,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Container(
        margin: EdgeInsets.all(12),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: MyTheme.whiteColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              color:   isDone
                  ? MyTheme.greenColor
                  : Theme.of(context).primaryColor,
              height: 80,
              width: 4,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.task.title ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(
                          color: isDone
                              ? MyTheme.greenColor
                              : Theme.of(context).primaryColor
                      ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.task.description ?? '',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: isDone
                            ? Colors.green
                            : Theme.of(context).primaryColor
                      )),
                )
              ],
            )
            ),

            Container(
              padding: EdgeInsets.symmetric(vertical: 7, horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                color: Colors.transparent

              ),
              child: isDone ?
                  TextButton(style: TextButton.styleFrom(
                    backgroundColor: MyTheme.whiteColor,
                    elevation: 0,
                    iconColor: MyTheme.whiteColor,
                    disabledBackgroundColor:Colors.white ,
                  ),
                      onPressed: (){
                    done();
                  },
                      child:Text('Done!',style: TextStyle(
                        color: MyTheme.greenColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        backgroundColor: Colors.transparent,

                      ),) )
              :

              IconButton(
                  color: MyTheme.primaryLight,
                  onPressed: (){
                    done();

                  },
                  icon: Icon(Icons.check,color: MyTheme.primaryLight
                    ,size: 40,))
            )
          ],
        ),
      ),
    );
  }
   done() {

     setState(() {
       isDone = !isDone;
     });
  }
 

}
