import 'package:flutter/material.dart';
import 'package:instanews_app/state/posts/typedef/user_id.dart';

class UserListTile extends StatelessWidget {
  final UserId userId;
  final String fileUrl;
  final String displayName;
  const UserListTile({
    super.key,
    required this.displayName,
    required this.fileUrl,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: screenWidth * 0.95,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                    color: Colors.blue.withOpacity(0.4),
                    spreadRadius: 1),
              ]),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 5, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // CircleAvatar(
                    //   radius: 40,
                    // )
                    CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.blue.shade400,
                        child: ClipOval(
                          child: fileUrl == 'NA'
                              ? const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 25,
                                )
                              : Image.network(
                                  width: 40,
                                  height: 40,
                                  fileUrl,
                                  fit: BoxFit.cover,
                                ),
                        ))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left:15.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FittedBox(
                          fit: BoxFit.fitHeight,
                          child: SizedBox(
                            width: screenWidth * 0.55,
                            child: Text(
                              displayName,
                              style: const TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.visible,
                                  softWrap: true,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
