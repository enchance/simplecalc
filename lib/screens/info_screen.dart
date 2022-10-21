import 'package:flutter/material.dart';


class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text('Information', style: Theme.of(context).textTheme.headline1),
            const SizedBox(height: 20),
            Text('Calculator', style: Theme.of(context).textTheme.headline5),
            const ListTile(
              leading: Icon(Icons.copy),
              title: Text('Copy solution'),
              subtitle: Text('Tap solution to copy'),
            ),
            const ListTile(
              leading: Icon(Icons.paste),
              title: Text('Paste from clipboard'),
              subtitle: Text('Long press the number screen to paste'),
            )
          ]
        )
      )
    );
  }
}
