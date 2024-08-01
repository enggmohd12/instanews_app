import 'package:flutter/foundation.dart' show immutable;
import 'package:instanews_app/views/components/dialogbox/alert_model_dialog.dart';

@immutable
class LogoutDialog extends AlertDialogModel<bool> {
  LogoutDialog()
      : super(
            title: 'Logout',
            message: 'Are you sure you want to logout?',
            button: {
              'Cancel': false,
              'Yes': true,
            });
}
