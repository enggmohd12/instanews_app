import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/state/user_profile/provider/user_by_name_provider.dart';
import 'package:instanews_app/views/components/animations/data_not_found_animation_view.dart';
import 'package:instanews_app/views/components/animations/globe_animation_text_view.dart';
import 'package:instanews_app/views/components/animations/small_error_animation_view.dart';
import 'package:instanews_app/views/constant/strings.dart';
import 'package:instanews_app/views/members/member_profile_view.dart';
import 'package:instanews_app/views/search_view/user_list_tile.dart';

class SearchUserListView extends ConsumerWidget {
  final String searchTerm;
  const SearchUserListView({
    super.key,
    required this.searchTerm,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (searchTerm.isEmpty) {
      return const GlobeAnimationTextView(
        text: Strings.enterYourSearchTermUser,
      );
    }
    final users = ref.watch(userNameBySearchTerm(searchTerm));
    return users.when(
      data: (users) {
        if (users.isEmpty) {
          return const DataNotFoundAnimationView();
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MemberProfileView(
                            postUserId: user.userId,
                          ),
                        ));
                    },
                    child: UserListTile(
                      displayName: user.displayName,
                      fileUrl: user.fileUrl,
                      userId: user.userId,
                    ),
                  );
                },
              ),
            ),
          );
        }
      },
      error: (error, stackTrace) => const SmallErrorAnimationView(),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
