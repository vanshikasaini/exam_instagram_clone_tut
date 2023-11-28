import 'package:exam_instagram_clone_tut/views/components/constants/strings.dart';
import 'package:exam_instagram_clone_tut/views/components/dialogs/alert_dialog_model.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class LogoutDialog extends AlertDialogModel<bool> {
  LogoutDialog()
      : super(
            title: Strings.logOut,
            message: Strings.areYouSureThatYouWantToLogOutOfTheApp,
            buttons: {
              Strings.cancel: false,
              Strings.logOut: true,
            });
}
