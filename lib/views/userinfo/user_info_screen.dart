import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/state/auth/providers/user_id_provider.dart';
import 'package:instanews_app/state/image_uploads/helper/image_picker_handler.dart';
import 'package:instanews_app/state/image_uploads/providers/profile_image_provider.dart';
import 'package:instanews_app/state/user_profile/provider/user_profile_upload_provider.dart';
import 'package:instanews_app/views/components/dialogbox/alert_model_dialog.dart';
import 'package:instanews_app/views/components/dialogbox/media_permission_dialog.dart';
import 'package:instanews_app/views/components/snackbar/error_snackbar.dart';
import 'package:permission_handler/permission_handler.dart';

class UserInfoScreen extends ConsumerStatefulWidget {
  final String bio;
  final String name;
  final String storageId;
  const UserInfoScreen(
      {super.key,
      required this.bio,
      required this.name,
      required this.storageId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserInfoViewState();
}

class _UserInfoViewState extends ConsumerState<UserInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final namecontroller = TextEditingController();
    final bioController = TextEditingController();
    final file = ref.watch(profileImageProvider);
    const isSaveButtonEnabled = true;
    bioController.text = widget.bio;
    namecontroller.text = widget.name;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Edit Profile',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: RefreshIndicator(
            onRefresh: () {
              //ref.refresh(getUserProfileProvider);
              return Future.delayed(const Duration(seconds: 1));
            },
            child: SafeArea(
              child: Flex(
                direction: Axis.vertical,
                children: [
                  Expanded(
                      flex: 4,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                'Profile picture',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return SimpleDialog(
                                        title:
                                            const Text('Select Media Option'),
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Column(
                                                children: [
                                                  SimpleDialogOption(
                                                    onPressed: () async {
                                                      Navigator.of(context)
                                                          .pop();
                                                      await Permission.camera
                                                          .request();
                                                      var status =
                                                          await Permission
                                                              .camera.status;
                                                      if (status
                                                              .isPermanentlyDenied ||
                                                          status.isDenied) {
                                                        final shouldGetPermissionToOpenSettings =
                                                            await MediaPermissionDialog()
                                                                .present(
                                                                    context)
                                                                .then((value) =>
                                                                    value ??
                                                                    false);
                                                        if (shouldGetPermissionToOpenSettings) {
                                                          openAppSettings();
                                                        } else {
                                                          showErrorSnackBar(
                                                              context: context,
                                                              message:
                                                                  'App have no permission to access the camera');
                                                        }
                                                      } else if (status
                                                          .isGranted) {
                                                            final a =
                                                            await ImagePickerHandler
                                                                .pickImageFromCamera();
                                                        if (a != null) {
                                                          ref
                                                              .read(
                                                                  profileImageProvider
                                                                      .notifier)
                                                              .state = a;
                                                        }
                                                          }
                                                    },
                                                    child: const Icon(
                                                      Icons.camera,
                                                      size: 40,
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                  const Text('Camera')
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  SimpleDialogOption(
                                                    onPressed: () async {
                                                      Navigator.of(context)
                                                          .pop();
                                                      await Permission.photos
                                                          .request();
                                                      var status1 =
                                                          await Permission
                                                              .photos.status;
                                                      if (status1
                                                              .isPermanentlyDenied ||
                                                          status1.isDenied) {
                                                        final shouldOpenSetting =
                                                            await MediaPermissionDialog()
                                                                .present(
                                                                    context)
                                                                .then(
                                                                  (value) =>
                                                                      value ??
                                                                      false,
                                                                );
                                                        if (shouldOpenSetting) {
                                                          openAppSettings();
                                                        } else {
                                                          showErrorSnackBar(
                                                              context: context,
                                                              message:
                                                                  'App have no permission to access the gallery');
                                                        }
                                                      } else if (status1
                                                          .isGranted) {
                                                        final a =
                                                            await ImagePickerHandler
                                                                .pickImageFromGallery();
                                                        if (a != null) {
                                                          ref
                                                              .read(
                                                                  profileImageProvider
                                                                      .notifier)
                                                              .state = a;
                                                        }
                                                      }
                                                    },
                                                    child: const Icon(
                                                      Icons.photo,
                                                      size: 40,
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                  const Text('Gallery')
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: CircleAvatar(
                                  radius: 45,
                                  child: file != null
                                      ? ClipOval(
                                          child: Image.file(
                                            file,
                                            height: 88,
                                            width: 88,
                                            fit: BoxFit.fill,
                                          ),
                                        )
                                     : const Icon(
                                              Icons.person,
                                              size: 55,
                                            ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Visibility(
                                    visible: file != null
                                        ? true
                                            : false,
                                    child: AnimatedContainer(
                                      duration: const Duration(seconds: 1),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: GestureDetector(
                                          onTap: () {
                                            ref
                                                .read(profileImageProvider
                                                    .notifier)
                                                .state = null;
                                          },
                                          child: const Text('Remove'),
                                        ),
                                      ),
                                    )),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Divider(
                                thickness: 1.2,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Name',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextField(
                                controller: namecontroller,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.grey.shade400)),
                                  enabled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey.shade200),
                                  ),
                                  hintText: 'User name',
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  fillColor: Colors.grey.shade200,
                                  filled: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 12),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Divider(
                                thickness: 1.2,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Bio',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextField(
                                maxLength: 115,
                                keyboardType: TextInputType.name,
                                controller: bioController,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.grey.shade400)),
                                  enabled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey.shade200),
                                  ),
                                  hintText: 'Bio (Optional)',
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  fillColor: Colors.grey.shade200,
                                  filled: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            width: width * 0.95,
                            child: ElevatedButton(
                              onPressed: isSaveButtonEnabled
                                  ? () {
                                      final userid = ref.read(userIdProvider);
                                      ref
                                          .read(userprofileProvider.notifier)
                                          .uploadProfileData(
                                            bio: bioController.text.toString(),
                                            file: file,
                                            userid: userid!,
                                            name:
                                                namecontroller.text.toString(),
                                            profileStorageIdOld:
                                                widget.storageId,
                                          );
                                      //ref.refresh(getUserProfileProvider);
                                      Future.delayed(
                                          const Duration(seconds: 3));
                                      Navigator.of(context).pop();
                                    }
                                  : null,
                              child: const Text(
                                'Save',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                          )),
                    ),
                  )
                ],
              ),
            )));
  }
}
