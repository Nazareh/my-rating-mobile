import 'package:flutter/material.dart';
import '../util/string_utils.dart';

class PlayerAvatar extends StatelessWidget {
  const PlayerAvatar({super.key, this.name, this.backgroundColor});
  final String? name;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: name == null ? Colors.grey.shade300 : backgroundColor,
      child: Text(nameInitials(name) ?? ''),
    );
  }
}
