import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toodooapp/my_theme.dart';
import 'package:toodooapp/provider/app_config_provider.dart';
import 'package:toodooapp/shared/constant.dart';
import 'package:toodooapp/shared/shared_pref.dart';

class ThemeBottomSheet extends StatefulWidget {
  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      color:
          provider.appTheme == ThemeMode.light ? MyTheme.white : MyTheme.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              CacheHelper.saveData(key: 'isLight', value: true)
                  .then((value) => provider.changeTheme(ThemeMode.light));
            },
            child: provider.appTheme == ThemeMode.light
                ? getSelectedItem('light')
                : getUnselectedItem('light'),
          ),
          InkWell(
            onTap: () {
              CacheHelper.saveData(key: 'isLight', value: false)
                  .then((value) => provider.changeTheme(ThemeMode.dark));
            },
            child: provider.appTheme == ThemeMode.dark
                ? getSelectedItem('dark')
                : getUnselectedItem('dark'),
          ),
        ],
      ),
    );
  }

  Widget getSelectedItem(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).primaryColor)),
          Icon(Icons.check, color: Theme.of(context).primaryColor)
        ],
      ),
    );
  }

  Widget getUnselectedItem(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: MyTheme.grey)),
        ],
      ),
    );
  }
}
