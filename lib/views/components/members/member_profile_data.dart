import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/state/posts/typedef/user_id.dart';
import 'package:instanews_app/state/user_profile/provider/user_post_profile.dart';
import 'package:instanews_app/views/components/animations/small_error_animation_view.dart';

class MemberProfileData extends ConsumerWidget {
  final UserId memberUserId;
  const MemberProfileData({
    super.key,
    required this.memberUserId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.sizeOf(context).width;
    
    final data = ref.watch(userprofilePostProvider(memberUserId));
    return data.when(
      data: (data) {
        if (data.isEmpty) {
          return const Text('No data found');
        }
        return Container(
          width: width,
          //height: height * 0.2,
          decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          child: Padding(
            padding: const EdgeInsets.only(top: 12.0,bottom: 12.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 45,
                          child: data.first.fileUrl != 'NA'
                              ? ClipOval(
                                  child: Image.network(
                                  data.first.fileUrl,
                                  height: 84,
                                  width: 84,
                                  fit: BoxFit.fill,
                                ))
                              : const Icon(
                                  Icons.person,
                                  size: 50,
                                ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data.first.displayName,
                        overflow: TextOverflow.visible,
                        softWrap: true,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: RichText(
                            overflow: TextOverflow.visible,
                            softWrap: true,
                            text: TextSpan(
                                // text: 'Bio:',
            
                                children: [
                                  const TextSpan(
                                    text: 'Bio: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  TextSpan(
                                      text: data.first.bio,
                                      style: const TextStyle(fontSize: 16))
                                ]),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) => const SmallErrorAnimationView(),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
