import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toodooapp/model/task.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: (snapshot, options) =>
                Task.fromFireStore(snapshot.data()!),
            toFirestore: (task, options) => task.toFireStorte());
  }

  static Future<void> addTaskToFireStore(Task task) {
    var taskCollection = getTasksCollection();
    var documentReference = taskCollection.doc();
    task.id = documentReference.id;
    return documentReference.set(task);
  }

  static updateTaskFromFireStore(Task task) {
    var taskCollection = getTasksCollection();
    var documentReference = taskCollection.doc(task.id);
    documentReference.update(task.toFireStorte());
  }

  static Future<void> updateTaskIsDone(Task task) async {
    var taskCollection = getTasksCollection();
    var documentReference = taskCollection.doc(task.id);
    await documentReference.update({
      'isDone': true,
    });
  }

  static Future<void> deleteTaskFromFireStore(Task task) {
    var taskCollection = getTasksCollection();
    var documentReference = taskCollection.doc(task.id);
    return documentReference.delete();
  }
}
