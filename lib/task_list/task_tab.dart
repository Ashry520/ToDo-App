import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toodooapp/my_theme.dart';
import 'package:toodooapp/provider/list_provider.dart';
import 'package:toodooapp/task_list/task_widget.dart';

import '../provider/app_config_provider.dart';

class TaskTab extends StatefulWidget {
  @override
  State<TaskTab> createState() => _TaskTabState();
}

class _TaskTabState extends State<TaskTab> {
  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    if (listProvider.taskList.isEmpty) {
      listProvider.getAllTasksFromFireStore();
    }
    var provider = Provider.of<AppConfigProvider>(context);
    return Column(
      children: [
        Stack(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              height: MediaQuery.of(context).size.height * 0.092,
            ),
            CalendarTimeline(
              initialDate: listProvider.selectDate,
              firstDate: DateTime.now().subtract(Duration(days: 365)),
              lastDate: DateTime.now().add(Duration(days: 365)),
              onDateSelected: (date) => listProvider.changeSelectedDate(date),
              leftMargin: 20,
              monthColor: MyTheme.black,
              dayColor: MyTheme.black,
              activeDayColor: Theme.of(context).primaryColor,
              activeBackgroundDayColor: provider.appTheme == ThemeMode.light
                  ? MyTheme.white
                  : MyTheme.black,
              dotsColor: Theme.of(context).primaryColor,
              selectableDayPredicate: (date) => true,
              locale: 'en_ISO',
            ),
          ],
        ),
        Expanded(
            child: ListView.builder(
          itemBuilder: (context, index) => TaskWidgetItem(
            task: listProvider.taskList[index],
          ),
          itemCount: listProvider.taskList.length,
        ))
      ],
    );
  }
}
