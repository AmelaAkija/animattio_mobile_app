import 'dart:developer';

import 'package:animattio_mobile_app/pages/start_game_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final fireStore = FirebaseFirestore.instance;
  User? currentUser = FirebaseAuth.instance.currentUser;

  addAvatar(String avatar) {
    try {
      var userCollection = fireStore.collection("users");
      userCollection.doc(currentUser?.uid).update({'avatar': avatar});
    } catch (e) {
      log(e.toString());
    }
  }

  updateUserData(String username, String email) {
    try {
      var userCollection = fireStore.collection("users");
      userCollection
          .doc(currentUser?.uid)
          .update({'username': username, "email": email});
    } catch (e) {
      log(e.toString());
    }
  }

  Future<Map<String, String>> getUserData() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();

      String username = userData['username'];
      String email = userData['email'];

      return {'username': username, 'email': email};
    }

    return {'username': '', 'email': ''};
  }

  Future<String> getAvatar() async {
    try {
      var userCollection = fireStore.collection("users");
      var currentUserData = await userCollection.doc(currentUser?.uid).get();
      if (currentUserData.exists) {
        return currentUserData.data()?['avatar'] ??
            'assets/user_page/no_avatar.png';
      } else {
        return "User doesn't exists"; //!!!
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  // Future<String> getStimuli() async {
  //   try {
  //     CollectionReference games =
  //         FirebaseFirestore.instance.collection('games');
  //     QuerySnapshot lastGame =
  //         await games.orderBy('timestamp', descending: true).limit(1).get();
  //     if (lastGame.docs.isNotEmpty) {
  //       DocumentSnapshot lastGameRef = lastGame.docs.first;

  //       var stimuli = lastGameRef['stimuli'];
  //       return stimuli;
  //     } else {
  //       return "no stimuli";
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //     rethrow;
  //   }
  // }

    Future<String?> repeatGame() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      String userId = currentUser!.uid;
       CollectionReference games =
          FirebaseFirestore.instance.collection('games');
      QuerySnapshot lastGame =
          await games.orderBy('timestamp', descending: true).limit(1).get();
      if (lastGame.docs.isNotEmpty) {
        DocumentSnapshot lastGameRef = lastGame.docs.first;
        var mode = lastGameRef["mode"];
        var theme = lastGameRef["theme"];
        ChosenGame chosenGame =
          ChosenGame(userId: userId, mode: mode, theme: theme);

      DocumentReference newGame =
          await fireStore.collection('games').add(chosenGame.toMap());
      return newGame.id;

      }else{
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<String?> addGame(String userId, String mode, String theme) async {
    try {
      ChosenGame chosenGame =
          ChosenGame(userId: userId, mode: mode, theme: theme);

      DocumentReference newGame =
          await fireStore.collection('games').add(chosenGame.toMap());
      return newGame.id;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  deleteGame() {
    try {
      fireStore
          .collection("games")
          .orderBy('timestamp', descending: true)
          .get()
          .then((value) {
        value.docs.first.reference.delete();
      });
    } catch (e) {
      log(e.toString());
    }
  }

  updateGameWithResult(List<bool> result, List<String> images, int comission, int omission, int hitRate, List<int> rT, List<int> intervals) {
    try {
      fireStore
          .collection("games")
          .orderBy('timestamp', descending: true)
          .get()
          .then((value) {
        value.docs.first.reference
            .update({'result': result, 'shown images': images, 'comission errors': comission, "omission errors": omission, "hit rate": hitRate, "reaction times": rT, "intervals":intervals});
      });
    } catch (e) {
      log(e.toString());
    }
  }

  updateGameWithStimuli(String stimuli) {
    try {
      fireStore
          .collection("games")
          .orderBy('timestamp', descending: true)
          .get()
          .then((value) {
        value.docs.first.reference.update({'stimuli': stimuli});
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> moveUserData() async {
    try {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser?.uid)
          .get();

      await FirebaseFirestore.instance
          .collection('deleted users')
          .doc(currentUser?.uid)
          .set(userData.data() as Map<String, dynamic>);
    } catch (e) {
      log(e.toString());
    }
  }
}
