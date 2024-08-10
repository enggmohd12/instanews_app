import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/state/post_settings/models/post_setting.dart';
import 'package:instanews_app/state/post_settings/notifier/post_setting_notifier.dart';

final postSettingProvider =
    StateNotifierProvider<PostSettingNotifier, Map<PostSetting, bool>>(
        (ref) => PostSettingNotifier());