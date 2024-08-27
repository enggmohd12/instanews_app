import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/state/auth/providers/user_id_provider.dart';
import 'package:instanews_app/state/image_uploads/models/file_type.dart';
import 'package:instanews_app/state/image_uploads/models/thumbnail_request.dart';
import 'package:instanews_app/state/post_settings/models/post_setting.dart';
import 'package:instanews_app/state/post_settings/providers/post_setting_providers.dart';
import 'package:instanews_app/state/user_profile/provider/image_upload_provider.dart';
import 'package:instanews_app/views/components/file_thumbnail_view.dart';

class CreateNewPostView extends StatefulHookConsumerWidget {
  final File filetoPost;
  final FileType fileType;
  const CreateNewPostView({
    super.key,
    required this.filetoPost,
    required this.fileType,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateNewPostViewState();
}

class _CreateNewPostViewState extends ConsumerState<CreateNewPostView> {
  @override
  Widget build(BuildContext context) {
    final thumbnailRequest = ThumbnailRequest(
      file: widget.filetoPost,
      fileType: widget.fileType,
    );
    final postSettings = ref.watch(postSettingProvider);
    final postController = useTextEditingController();
    final isPostButtonEnabled = useState(false);
    useEffect(() {
      void listener() {
        isPostButtonEnabled.value = postController.text.isNotEmpty;
      }

      postController.addListener(listener);

      return () {
        postController.removeListener(listener);
      };
    }, [postController]);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New Post',
        ),
        actions: [
          IconButton(
              onPressed: isPostButtonEnabled.value
                  ? () async {
                      final userId = ref.read(userIdProvider);
                      if (userId == null) {
                        return;
                      }
                      final message = postController.text;
                      final isUploaded = await ref
                          .read(imageUploadProvider.notifier)
                          .upload(
                              file: widget.filetoPost,
                              fileType: widget.fileType,
                              message: message,
                              postSettings: postSettings,
                              userId: userId);
                      if (isUploaded && mounted) {
                        Navigator.of(context).pop();
                      }
                    }
                  : null,
              icon: const Icon(Icons.send))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // thumbnail view
            FileThumbnailView(thumbnailRequest: thumbnailRequest),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: postController,
                decoration:  InputDecoration(
                    hintText: 'Please write your message here',
                    focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                width: 1, color: Colors.grey.shade400)),
                        enabled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          borderSide:
                              BorderSide(width: 1, color: Colors.grey.shade200),
                        ),
                        hintStyle: const TextStyle(color: Colors.grey),
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 20.0,horizontal: 8.0)),
                autofocus: true,
                maxLength: null,
              ),
            ),
            ...PostSetting.values.map((postSetting) => ListTile(
                  title: Text(postSetting.title),
                  subtitle: Text(postSetting.description),
                  trailing: Switch(
                    value: postSettings[postSetting] ?? false,
                    onChanged: (isOn) {
                      ref
                          .read(postSettingProvider.notifier)
                          .setSetting(postSetting, isOn);
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }
}