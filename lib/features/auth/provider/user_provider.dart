import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_app/features/auth/model/user_model.dart';
import 'package:video_app/features/auth/repository/user_data_service.dart';

final currentUserProvider = FutureProvider<UserModel>((ref) async {
  final UserModel user =
  await ref.watch(userDataServiceProvider).fetchCurrentUserData();
  return user;
});

final anyUserDataProvider = FutureProvider.family((ref, userId) async {
  final UserModel user =
  await ref.watch(userDataServiceProvider).fetchAnyUserData(userId);
  return user;
});