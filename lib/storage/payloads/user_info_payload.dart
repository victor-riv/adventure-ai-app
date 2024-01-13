import 'dart:collection';

import 'package:flutter/foundation.dart' show immutable;
import 'package:sylas_ai/storage/constants/firestore_field_names.dart';

import '../../auth/typedefs/user_id.dart';

@immutable
class UserInfoPayload extends MapView<String, String> {
  UserInfoPayload({
    required UserId userId,
    required String? displayName,
    required String? email,
  }) : super({
          FireStoreFieldName.userId: userId,
          FireStoreFieldName.displayName: displayName ?? '',
          FireStoreFieldName.email: email ?? ''
        });
}
