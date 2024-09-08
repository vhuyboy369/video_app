// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_app/features/auth/model/user_model.dart';

final userDataServiceProvider = Provider(
      (ref) => UserDataService(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

class UserDataService {
  FirebaseAuth auth;
  FirebaseFirestore firestore;
  UserDataService({
    required this.auth,
    required this.firestore,
  });
  // thêm infor user vào firebase database
  addUserDataToFirestore({
    required String displayName,
    required String username,
    required String email,
    required String description,
    required String profilePic,
  }) async {
    UserModel user = UserModel(
      displayName: displayName,
      username: username,
      email: email,
      profilePic: profilePic,
      subscriptions: [],
      videos: 0,
      userId: auth.currentUser!.uid,
      description: description,
      type: "user",
    );

    await firestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .set(user.toMap());
  }

  Future<UserModel> fetchCurrentUserData() async {
    final currentUserMap =
    await firestore.collection("users").doc(auth.currentUser!.uid).get();
    UserModel user = UserModel.fromMap(currentUserMap.data()!);
    return user;
  }

  Future<UserModel> fetchAnyUserData(userId) async {
    final currentUserMap =
    await firestore.collection("users").doc(userId).get();
    UserModel user = UserModel.fromMap(currentUserMap.data()!);
    return user;
  }
}