import 'package:flutter/foundation.dart' show immutable;
import 'package:instanews_app/views/components/dialogbox/alert_model_dialog.dart';

@immutable
class MediaPermissionDialog extends AlertDialogModel<bool> {
  MediaPermissionDialog()
      : super(
          title: 'Permission required',
          message: 'You need to allow the permission from the APP settings',
          button: {
            'Cancel': false,
            'Open setting': true,
          },
        );
}
