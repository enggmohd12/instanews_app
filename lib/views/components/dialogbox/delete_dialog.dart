import 'package:flutter/foundation.dart' show immutable;
import 'package:instanews_app/views/components/constant/strings.dart';
import 'package:instanews_app/views/components/dialogbox/alert_model_dialog.dart';

@immutable
class DeleteDialog extends AlertDialogModel {
  const DeleteDialog({required String titleOfObjectToDelete})
      : super(
          title: '${Strings.delete} $titleOfObjectToDelete?',
          message:
              '${Strings.areYouSureYouWantToDeleteThis} $titleOfObjectToDelete?',
          button: const {Strings.cancel: false, Strings.delete: true},
        );
}