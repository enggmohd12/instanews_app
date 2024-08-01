import 'package:flutter/foundation.dart' show immutable, VoidCallback;
import 'package:instanews_app/views/components/richtext/base_text.dart';

@immutable
class LinkText extends BaseText {
  final VoidCallback onTapped;
  const LinkText({
    required super.text,
    required this.onTapped,
    super.style,
  });
}
