import 'package:SimpleCalc/providers/calculator_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';


class HistoryScreen extends StatelessWidget {
  static const route = '/history';
  // final List<Map<String, String>> data = _getData();
  // late final List<Map<String, String>> data;

  HistoryScreen({Key? key}) : super(key: key);

  List<Map<String, String>> get data {
    return [
      {
        'problem': '1+1',
        'solution': '2'
      },
      {
        'problem': '4-2',
        'solution': '2'
      },
      {
        'problem': '7-12',
        'solution': '-5'
      },
      {
        'problem': '1+1',
        'solution': '2'
      },
      {
        'problem': '4-2',
        'solution': '2'
      },
      {
        'problem': '7-12',
        'solution': '-5'
      },
      {
        'problem': '1+1',
        'solution': '2'
      },
      {
        'problem': '4-2',
        'solution': '2'
      },
      {
        'problem': '7-12',
        'solution': '-5'
      },
      {
        'problem': '1+1',
        'solution': '2'
      },
      {
        'problem': '4-2',
        'solution': '2'
      },
      {
        'problem': '7-12',
        'solution': '-5'
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History')
      ),
      body: Container(
        // margin: EdgeInsets.only(top: 20),
        child: data.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  color: Colors.grey[300],
                  padding: const EdgeInsets.only(
                    top: 20,
                    right: 20,
                    bottom: 10,
                    left: 20
                  ),
                  child: const Text('Tap to append to your equation'),
                ),
                // const SizedBox(height: 2),
                // const Divider(color: Colors.grey),
                Expanded(child: HistoryList(data))
              ],
            )
          : const EmptyHistoryWidget(),
      ),
    );
  }
}

class HistoryList extends StatelessWidget {
  final List data;

  const HistoryList(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      ListView.separated(
          itemCount: data.length,
          itemBuilder: (_, idx) {
            Map<String, String> item = data[idx];
            return HistoryTile(item['solution']!, item['problem']!);
          },
          separatorBuilder: (_, idx) => const Divider(
            color: Colors.grey,
            height: 1,
          ),
      );
  }
}



class HistoryTile extends StatelessWidget {
  final String title;
  final String subtitle;

  const HistoryTile(this.title, this.subtitle, {Key? key}) : super(key: key);

  Widget _buildAutoSizeText(String text, {int lines=3, TextStyle? style}) {
    return AutoSizeText(
        text,
        maxLines: lines,
        minFontSize: 16,
        style: style,
    );
  }

  @override
  Widget build(BuildContext context) {
    var calc = Provider.of<CalculatorProvider>(context, listen: false);

    return ListTile(
      leading: const Icon(Icons.calculate_outlined, size: 40, color: Colors.black38),
      title: _buildAutoSizeText(title, style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
          color: Colors.black54
      )),
      subtitle: _buildAutoSizeText(subtitle),
      onTap: () {
        calc.append(title);
        Navigator.of(context).pop();
      },
    );
  }
}


class EmptyHistoryWidget extends StatelessWidget {
  const EmptyHistoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.hourglass_empty, size: 100, color: Colors.grey),
          Text('Nothing to see here',
            style: TextStyle(
              color: Colors.grey,
              fontSize: Theme.of(context).textTheme.headline1!.fontSize
            )
          )
        ],
      )
    );
  }
}
