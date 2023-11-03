import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:toodooapp/firestore_utility.dart';
import 'package:toodooapp/model/task.dart';
import 'package:toodooapp/my_theme.dart';
import 'package:toodooapp/provider/list_provider.dart';

import '../provider/app_config_provider.dart';

class TaskSave extends StatefulWidget {
  static const String routeName = 'Save-Task';
  @override
  State<TaskSave> createState() => _TaskSaveState();
}

class _TaskSaveState extends State<TaskSave> {
  DateTime selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();
  late ListProvider listProvider;
  String title = '';
  String description = '';
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    listProvider = Provider.of<ListProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'To Do List',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.07,
            horizontal: MediaQuery.of(context).size.width * 0.07),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: provider.appTheme == ThemeMode.light
                ? MyTheme.white
                : MyTheme.black,
            borderRadius: BorderRadius.circular(30)),
        child: Column(
          children: [
            Text('Edit Task', style: Theme.of(context).textTheme.titleMedium),
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
                          hintStyle: Theme.of(context).textTheme.titleMedium,
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
                          saveTask();
                        },
                        child: Text('Save',
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

  void saveTask() async {
    if (formKey.currentState?.validate() == true) {
      Task task = Task(
        title: title,
        description: description,
        dateTime: selectedDate,
      );
      try {
        await FirebaseUtils.updateTaskFromFireStore(task);
        Fluttertoast.showToast(
          msg: "Task Edited Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: MyTheme.primaryLight,
          textColor: MyTheme.white,
          fontSize: 16.0,
        );
        listProvider.getAllTasksFromFireStore();
        Navigator.pop(context);
      } catch (e) {
        print('Error updating task: $e');
        // Handle error if necessary
      }
    }
  }
}
