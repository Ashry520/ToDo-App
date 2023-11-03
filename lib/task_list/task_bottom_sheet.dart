import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:toodooapp/firestore_utility.dart';
import 'package:toodooapp/model/task.dart';
import 'package:toodooapp/my_theme.dart';
import 'package:toodooapp/provider/app_config_provider.dart';
import 'package:toodooapp/provider/list_provider.dart';

class TaskBottomSheet extends StatefulWidget {
  @override
  State<TaskBottomSheet> createState() => _TaskBottomSheetState();
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
  DateTime selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  late ListProvider listProvider;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    listProvider = Provider.of<ListProvider>(context);
    return Container(
      color:
          provider.appTheme == ThemeMode.light ? MyTheme.white : MyTheme.black,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text('Add a new task',
                style: Theme.of(context).textTheme.titleMedium),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        onChanged: (text) {
                          title = text;
                        },
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'must be filled';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'task title',
                          hintStyle: TextStyle(
                            color: provider.appTheme == ThemeMode.light
                                ? MyTheme.black
                                : MyTheme.white,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: provider.appTheme == ThemeMode.light
                                    ? MyTheme.black
                                    : MyTheme
                                        .white), // Set the border color here
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        onChanged: (text) {
                          description = text;
                        },
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'must be filled';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'description',
                          hintStyle: TextStyle(
                            color: provider.appTheme == ThemeMode.light
                                ? MyTheme.black
                                : MyTheme.white,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: provider.appTheme == ThemeMode.light
                                    ? MyTheme.black
                                    : MyTheme
                                        .white), // Set the border color here
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('Set Date',
                          style: Theme.of(context).textTheme.titleSmall),
                    ),
                    InkWell(
                      onTap: () {
                        showCalender();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                            '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                            style: Theme.of(context).textTheme.titleSmall,
                            textAlign: TextAlign.center),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    ElevatedButton(
                        onPressed: () {
                          addTask();
                        },
                        child: Text('Add task',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(color: MyTheme.white)))
                  ],
                ))
          ],
        ),
      ),
    );
  }

  void showCalender() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(
          Duration(days: 365),
        ));
    if (chosenDate != null) {
      selectedDate = chosenDate;
    }
    setState(() {});
  }

  void addTask() {
    if (formKey.currentState?.validate() == true) {
      Task task = Task(
        title: title,
        description: description,
        dateTime: selectedDate,
      );
      FirebaseUtils.addTaskToFireStore(task).timeout(
        Duration(milliseconds: 500),
        onTimeout: () {
          Fluttertoast.showToast(
              msg: "Task Added Successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: MyTheme.primaryLight,
              textColor: MyTheme.white,
              fontSize: 16.0);
          listProvider.getAllTasksFromFireStore();
          Navigator.pop(context);
        },
      );
    }
  }
}
