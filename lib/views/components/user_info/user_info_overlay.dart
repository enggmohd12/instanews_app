import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserInfoOverlay extends ConsumerWidget {
  final VoidCallback remove;
  const UserInfoOverlay({super.key,required this.remove});

  @override
  Widget build(BuildContext context,WidgetRefref) {

    
    return SingleChildScrollView(
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: remove,
              child: Text('Remove'),
            ),
          )
        ],
      ),
    );
  }
}