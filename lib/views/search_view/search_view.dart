import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instanews_app/views/components/search_grid_view.dart';
import 'package:instanews_app/views/constant/strings.dart';
import 'package:instanews_app/views/extensions/dismiss_keyboard.dart';

class SearchView extends HookConsumerWidget {
  const SearchView({super.key});

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
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: controller,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: Strings.enterYourSearchTermHere,
                suffixIcon: IconButton(
                    onPressed: () {
                      controller.clear();
                      dismissKeyboard();
                    },
                    icon: const Icon(Icons.clear)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    borderSide:
                        BorderSide(width: 1, color: Colors.grey.shade400)),
                enabled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(width: 1, color: Colors.grey.shade200),
                ),
                hintStyle: const TextStyle(color: Colors.grey),
                fillColor: Colors.grey.shade200,
                filled: true,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
              ),
            ),
          ),
        ),
        SearchGridView(
          searchTerm: searchTerm.value,
        ),
      ],
    );
  }
}
