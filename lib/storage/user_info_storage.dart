import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:sylas_ai/auth/typedefs/user_id.dart';
import 'package:sylas_ai/storage/constants/firestore_collection_name.dart';
import 'package:sylas_ai/storage/payloads/user_info_payload.dart';

import 'constants/firestore_field_names.dart';

@immutable
class UserInfoStorage {
  const UserInfoStorage();

  Future<bool> saveUserInfo({
    required UserId userId,
    required String? displayName,
    required String? email,
  }) async {
    try {
      final userInfo = await FirebaseFirestore.instance
          .collection(FireStoreCollectionName.users)
          .where(FireStoreFieldName.userId, isEqualTo: userId)
          .limit(1)
          .get();

      if (userInfo.docs.isNotEmpty) {
        await userInfo.docs.first.reference.update({
          FireStoreFieldName.displayName: displayName ?? '',
          FireStoreFieldName.email: email ?? ''
        });

        return true;
      }

      final payload = UserInfoPayload(
        userId: userId,
        displayName: displayName,
        email: email,
      );

      await FirebaseFirestore.instance
          .collection(FireStoreCollectionName.users)
          .add(payload);

      return true;
    } catch (e) {
      return false;
    }
  }
}
