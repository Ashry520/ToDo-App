import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toodooapp/firestore_utility.dart';
import 'package:toodooapp/model/task.dart';

class ListProvider extends ChangeNotifier {
  List<Task> taskList = [];
  DateTime selectDate = DateTime.now();
  void getAllTasksFromFireStore() async {
    QuerySnapshot<Task> querySnapshot =
        await FirebaseUtils.getTasksCollection().get();
    taskList = querySnapshot.docs.map((doc) => doc.data()).toList();
    taskList = taskList.where((task) {
      if (task.dateTime?.day == selectDate.day &&
          task.dateTime?.month == selectDate.month &&
          task.dateTime?.year == selectDate.year) {
        return true;
      }
      return false;
    }).toList();
    taskList.sort(
        (Task task1, Task task2) => task1.dateTime!.compareTo(task2.dateTime!));

    notifyListeners();
  }

  Future<void> updateTaskInFirestore(Task updatedTask) async {
    try {
      await FirebaseUtils.updateTaskFromFireStore(updatedTask);

      int index = taskList.indexWhere((task) => task.id == updatedTask.id);
      taskList[index] = updatedTask;
      notifyListeners();
    } catch (e) {
      print('Error updating task: $e');
    }
  }

  Future<void> deleteTaskFromFireStore(Task task) async {
    try {
      await FirebaseUtils.deleteTaskFromFireStore(task);
      taskList.removeWhere((task) => task.id == task.id);
      notifyListeners();
    } catch (e) {
      print('Error deleting task: $e');
    }
  }

  void changeSelectedDate(DateTime newDate) {
    selectDate = newDate;
    getAllTasksFromFireStore();
    notifyListeners();
  }
}
