import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toodooapp/my_theme.dart';
import 'package:toodooapp/provider/app_config_provider.dart';
import 'package:toodooapp/settings/settings_tab.dart';
import 'package:toodooapp/task_list/task_bottom_sheet.dart';
import 'package:toodooapp/task_list/task_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'To Do List',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: provider.appTheme == ThemeMode.light ? MyTheme.white : MyTheme.black,
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (index) {
              selectedIndex = index;
              setState(() {});
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.list), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
            ]),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: context, builder: (context) => TaskBottomSheet());
          },
          child: Icon(
            Icons.add,
            size: 33,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabs[selectedIndex],
    );
  }

  List<Widget> tabs = [TaskTab(), SettingsTab()];
}
