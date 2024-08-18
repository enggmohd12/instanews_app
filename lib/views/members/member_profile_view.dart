import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/state/posts/typedef/user_id.dart';
import 'package:instanews_app/views/components/members/member_profile_data.dart';
import 'package:instanews_app/views/components/members/members_post_gridview.dart';

class MemberProfileView extends ConsumerWidget {
  final UserId postUserId;
  const MemberProfileView({
    super.key,
    required this.postUserId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'InstaNews',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MemberProfileData(
                  memberUserId: postUserId,
                ),
                Padding(padding: EdgeInsets.only(top: 12),),
              ],
            ),
          ),
          
          MemberGridView(
            memberPostUserId: postUserId,
          )
        ],
      ),
    );
  }
}
