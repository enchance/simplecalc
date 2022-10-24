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
            ),
            TextButton.icon(
              // onPressed: () => _showDialog(context),
              onPressed: () => _showAbout(context),
              icon: Icon(Icons.info),
              label: const Text('Release version')
            )
          ]
        )
      )
    );
  }

  _showAbout(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'BigButton Calculator',
      applicationVersion: '1.2.1+9',
      applicationLegalese: '2022 Jimbong Labs',
      applicationIcon: const Image(
        image: AssetImage('assets/about-icon.png')
      ),
      children: [
        const SizedBox(height: 10),
        Text('Made by Jim who hated his stock calculator.')
      ]
    );
  }

  // _showDialog(BuildContext context) => showDialog(context: context, builder: (context) {
  //   var text = RichText(text: TextSpan(
  //     style: Theme.of(context).textTheme.bodyText2,
  //     children: const [
  //       TextSpan(text: 'BigButton Calculator 1.2.1+9.\n', style: TextStyle(fontWeight: FontWeight
  //           .bold)),
  //       TextSpan(text: 'Made by Jim who hated his stock calculator.')
  //     ]
  //   ));
  //
  //   return AlertDialog(
  //     title: const Text('Release Version'),
  //     content: text,
  //     actions: [
  //       TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))
  //     ],
  //   );
  // });
}
