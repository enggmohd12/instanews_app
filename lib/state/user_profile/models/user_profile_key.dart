
import 'package:flutter/foundation.dart' show immutable;

@immutable 
class UserProfileKey{
  static const userId = 'uid';
  static const bio = 'bio';
  static const filename = 'file_name';
  static const fileUrl = 'file_url';
  static const profileImageStorageId = 'profile_image_storage_id';
  static const displayname = 'display_name';

  const UserProfileKey._();
}