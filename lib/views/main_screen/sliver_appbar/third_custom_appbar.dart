import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/state/image_uploads/helper/image_picker_handler.dart';
import 'package:instanews_app/state/image_uploads/models/file_type.dart';
import 'package:instanews_app/state/post_settings/providers/post_setting_providers.dart';
import 'package:instanews_app/views/components/dialogbox/alert_model_dialog.dart';
import 'package:instanews_app/views/components/dialogbox/media_permission_dialog.dart';
import 'package:instanews_app/views/components/snackbar/error_snackbar.dart';
import 'package:instanews_app/views/create_new_post/create_new_post_view.dart';
import 'package:instanews_app/views/main_screen/sliver_appbar/sliver_header_delegate/sliver_header_delegate.dart';
import 'package:permission_handler/permission_handler.dart';

class ThirdCustomAppBar extends ConsumerStatefulWidget {
  const ThirdCustomAppBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ThirdCustomState();
}

class _ThirdCustomState extends ConsumerState<ThirdCustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: MyHeaderDelegate(
        minExtent: 50.0,
        maxExtent: 50.0,
        child: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 69, 150, 249),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () async {
                      await Permission.photos.request();
                      await Permission.storage.request();
                      var status2 = await Permission.storage.status;
                      var status1 = await Permission.photos.status;

                      if (status1.isGranted || status2.isGranted) {
                        final a =
                            await ImagePickerHandler.pickImageFromGallery();
                        if (a == null) {
                          return;
                        }

                        ref.refresh(postSettingProvider);

                        if (!mounted) {
                          return;
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CreateNewPostView(
                              filetoPost: a,
                              fileType: FileType.image,
                            ),
                          ),
                        );
                      } else if (status1.isPermanentlyDenied ||
                          status1.isDenied || status2.isPermanentlyDenied || status2.isDenied) {
                        final shouldOpenSetting =
                            await MediaPermissionDialog().present(context).then(
                                  (value) => value ?? false,
                                );
                        if (shouldOpenSetting) {
                          openAppSettings();
                        } else {
                          showErrorSnackBar(
                              context: context,
                              message:
                                  'App have no permission to access the gallery');
                        }
                      }
                    },
                    icon: const Icon(
                      Icons.camera,
                      size: 30,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () async {
                      await Permission.photos.request();
                      var status1 = await Permission.photos.status;
                      if (status1.isPermanentlyDenied || status1.isDenied) {
                        final shouldOpenSetting =
                            await MediaPermissionDialog().present(context).then(
                                  (value) => value ?? false,
                                );
                        if (shouldOpenSetting) {
                          openAppSettings();
                        } else {
                          showErrorSnackBar(
                              context: context,
                              message:
                                  'App have no permission to access the gallery');
                        }
                      } else if (status1.isGranted) {
                        final a =
                            await ImagePickerHandler.pickVideoFromGallery();
                        if (a == null) {
                          return;
                        }

                        ref.refresh(postSettingProvider);

                        if (!mounted) {
                          return;
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CreateNewPostView(
                              filetoPost: a,
                              fileType: FileType.video,
                            ),
                          ),
                        );
                      }
                    },
                    icon: const Icon(
                      Icons.video_camera_back_outlined,
                      size: 30,
                      color: Colors.white,
                    ))
              ],
            )),
      ),
    );
  }
}
