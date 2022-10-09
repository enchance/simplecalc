import 'package:flutter/material.dart';


class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Information')
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Calculator Actions', style: Theme.of(context).textTheme.headline1),
            const ListTile(
              leading: Icon(Icons.copy),
              title: Text('Copying calculator solution'),
              subtitle: Text('Tap the screen to copy'),
            ),
            const ListTile(
              leading: Icon(Icons.paste),
              title: Text('Pasting clipboard to calculator'),
              subtitle: Text('Long press the calculator screen to paste'),
            )
          ]
        )
      )
    );
  }
}
