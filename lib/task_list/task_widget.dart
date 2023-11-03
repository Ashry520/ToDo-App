import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:toodooapp/firestore_utility.dart';
import 'package:toodooapp/model/task.dart';
import 'package:toodooapp/my_theme.dart';
import 'package:toodooapp/provider/list_provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:toodooapp/task_list/task_save.dart';
import '../provider/app_config_provider.dart';

class TaskWidgetItem extends StatefulWidget {
  Task task;
  TaskWidgetItem({required this.task});

  @override
  State<TaskWidgetItem> createState() => _TaskWidgetItemState();
}

class _TaskWidgetItemState extends State<TaskWidgetItem> {
  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    var provider = Provider.of<AppConfigProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.25,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                FirebaseUtils.deleteTaskFromFireStore(widget.task).timeout(
                  Duration(milliseconds: 500),
                  onTimeout: () {
                    Fluttertoast.showToast(
                        msg: "Task deleted Successfully",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: MyTheme.primaryLight,
                        textColor: MyTheme.white,
                        fontSize: 16.0);
                    listProvider.getAllTasksFromFireStore();
                  },
                );
              },
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12)),
              backgroundColor: Color(0xFFEC4B4B),
              foregroundColor: MyTheme.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12)),
            color: provider.appTheme == ThemeMode.light
                ? MyTheme.white
                : MyTheme.black,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: widget.task.isDone!
                    ? Colors.green
                    : Theme.of(context).primaryColor,
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width * 0.01,
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.task.title ?? '',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: widget.task.isDone!
                                      ? Colors.green
                                      : Theme.of(context).primaryColor,
                                ),
                      ),
                      Text(
                        widget.task.description ?? '',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: provider.appTheme == ThemeMode.light
                                ? MyTheme.darkgrey
                                : MyTheme.white),
                      ),
                    ],
                  ),
                ),
              )),
              InkWell(
                onTap: () {
                  markAsDone();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                      color: widget.task.isDone!
                          ? Colors.green
                          : Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Icon(Icons.check, color: MyTheme.white),
                ),
              ),
              SizedBox(width: 10),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(TaskSave.routeName);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Icon(Icons.edit_document, color: MyTheme.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void markAsDone() {
    widget.task.isDone = true;
    setState(() {});

    // Update the isDone field in Firestore
    FirebaseUtils.updateTaskIsDone(widget.task).then((_) {
      // Handle the update success if necessary
    }).catchError((error) {
      // Handle errors if the update fails
      print('Error updating isDone field: $error');
    });
  }
}
