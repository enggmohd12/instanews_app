import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/views/constant/strings.dart';
import 'package:instanews_app/views/extensions/dismiss_keyboard.dart';
import 'package:instanews_app/views/search_view/search_user_list_view.dart';

class SearchUserView extends HookConsumerWidget {
  const SearchUserView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final searchTerm = useState('');

    useEffect(() {
      controller.addListener(() {
        searchTerm.value = controller.text;
      });
      return () {};
    }, [controller]);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: controller,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
                labelText: Strings.enterYourSearchTermHere,
                suffixIcon: IconButton(
                    onPressed: () {
                      controller.clear();
                      dismissKeyboard();
                    },
                    icon: const Icon(Icons.clear))),
          ),
        ),
        SearchUserListView(searchTerm: searchTerm.value,),
      ],
    );
  }
}
