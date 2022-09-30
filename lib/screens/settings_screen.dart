import 'package:flutter/material.dart';

import '../core/styles.dart';
import '../main.dart';


class SettingsScreen extends StatefulWidget {
  static const route = '/settings';
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var useComma = true;
  var noRotate = true;
  var copyCommas = false;
  var autoCopy = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            ...buildHeadlineText(context, 'Settings', 20),
            const Divider(),
            SwitchListTile(
              title: const Text('Comma delimited'),
              subtitle: const Text('Comma delimit the final solution'),
              value: useComma,
              onChanged: (val) => setState(() => useComma = val),
            ),
            SwitchListTile(
              title: const Text('Prevent rotate'),
              subtitle: const Text('Do not rotate the calculator'),
              value: noRotate,
              onChanged: (val) => setState(() => noRotate = val),
            ),
            const Divider(),
            const Divider(),
            SwitchListTile(
              title: const Text('Copy solution'),
              subtitle: const Text('Include commas when copying the '
                  'soution'),
              value: copyCommas,
              onChanged: (val) => setState(() => copyCommas = val),
            ),
            const Divider(),
            SwitchListTile(
              title: const Text('Auto copy solution'),
              subtitle: const Text('Automatically copy the solution'),
              value: autoCopy,
              onChanged: (val) => setState(() => autoCopy = val),
            ),
            const Divider(),
          ],
        ),
      )
    );
  }
}
