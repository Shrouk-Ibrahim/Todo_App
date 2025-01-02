import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_application/models/task.dart';
import 'models/my_user.dart';

class FireBaseUtils {
  static CollectionReference<Task> getTasksCollection(String uId) {
    return getUsersCollection()
        .doc(uId)
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: (snapshot, options) =>
                Task.fromFireStore(snapshot.data()!),
            toFirestore: (task, options) => task.toFireStore());
  }

  static Future<void> addTaskToFireStore(Task task, String uId) {
    var taskCollection = getTasksCollection(uId);

    /// collection creation
    var docRef = taskCollection.doc();

    /// document creation
    task.id = docRef.id;

    /// this is the auto id in the fireBase
    return docRef.set(task);
  }

  static Future<void> deleteTaskFromFireStore(Task task, String uId) {
    return getTasksCollection(uId).doc(task.id).delete();
  }

  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
            fromFirestore: (snapshot, options) =>
                MyUser.fromFireStore(snapshot.data()!),
            toFirestore: (user, options) => user.toFireStore());
  }

  static Future<void> addUserToFireStore(MyUser myUser) {
    return getUsersCollection().doc(myUser.id).set(myUser);
  }
  // static Future<void>editIsDone(Task task , String uId){
  //
  // }

  static Future<MyUser?> readUserFromFireStore(String uId) async {
    var docSnapshot = await getUsersCollection().doc(uId).get();
    return docSnapshot.data();
  }
}
