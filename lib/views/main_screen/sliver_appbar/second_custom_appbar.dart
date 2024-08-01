import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/state/image_uploads/providers/profile_image_provider.dart';
import 'package:instanews_app/state/user_profile/provider/user_profile_data.dart';
import 'package:instanews_app/utility/converturl_to_file.dart';
import 'package:instanews_app/views/userinfo/user_info_screen.dart';

class SecondCustomAppBar extends ConsumerStatefulWidget {
  const SecondCustomAppBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SecondCustomAppBarViewState();
}

class _SecondCustomAppBarViewState extends ConsumerState<SecondCustomAppBar> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final userprofile = ref.watch(getUserProfileProvider);
    return SliverAppBar(
      // shape: const ContinuousRectangleBorder(
      //     borderRadius: BorderRadius.only(
      //         bottomLeft: Radius.circular(70),
      //         bottomRight: Radius.circular(70))),
      backgroundColor: const Color.fromARGB(255, 69, 150, 249),
      expandedHeight: screenHeight * 0.21,
      floating: false,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            userprofile.when(
              error: (error, stackTrace) {
                return const Center(
                  child: Text('No data found'),
                );
              },
              loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              data: (snapshot) {
                if (snapshot.isEmpty) {
                  ref.watch(getUserProfileProvider);
                  return const Center(
                    child: Text('No data'),
                  );
                }

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CircleAvatar(
                        radius: 43,
                        child: snapshot.first.fileUrl != 'NA'
                            ? ClipOval(
                                child: Image.network(
                                snapshot.first.fileUrl,
                                height: 88,
                                width: 88,
                                fit: BoxFit.fill,
                              ))
                            : const Icon(
                                Icons.person,
                                size: 40,
                              ),
                        // backgroundImage: NetworkImage(profilePicUrl),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'Hi, ${snapshot.first.displayName}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          textAlign: TextAlign.center,
                          //softWrap: true,
                          // maxLines: null,
                          //overflow: TextOverflow.visible,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          snapshot.first.bio == '' ? 'NA' : snapshot.first.bio,
                          style: const TextStyle(
                              color: Colors.white,
                              //fontWeight: FontWeight.bold,
                              fontSize: 15),
                          textAlign: TextAlign.center,
                          //softWrap: true,
                          // maxLines: null,
                          //overflow: TextOverflow.visible,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            Positioned(
                right: 8,
                top: 20,
                child: userprofile.when(
                  error: (error, stackTrace) {
                    return const Text('');
                  },
                  loading: () {
                    return Center(child: CircularProgressIndicator());
                  },
                  data: (data) {
                    if (data.isEmpty) {
                      return IconButton(
                          onPressed: () {}, icon: const Icon(Icons.edit));
                    }
                    return IconButton(
                      onPressed: () async{
                        ref.read(profileImageProvider.notifier).state = null;
                        File? file;
                        if (data.first.fileUrl != 'NA'){
                          file = await convertURLtoFile(data.first.fileUrl);
                          ref.read(profileImageProvider.notifier).state = file;
                        } else{
                          ref.read(profileImageProvider.notifier).state = null;
                        }
                        
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserInfoScreen(
                              bio: data.first.bio,
                              name: data.first.displayName,
                              storageId: data.first.profileImageStorageId,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    );
                  },
                ))
            // final renderBox = context.findRenderObject() as RenderBox;
            //final size = renderBox.size;
          ],
        ),
      ),
    );
  }
}
