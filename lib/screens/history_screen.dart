import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../app/providers/calculator_provider.dart';
import '../app/collections/history.dart';


class HistoryScreen extends StatefulWidget {
  static const route = '/history';

  HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History')
      ),
      body: Container(
        // margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey)
                )
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Tap to copy to equation'),
                  TextButton.icon(
                      onPressed: _clearHistory,
                      icon: const Icon(Icons.delete_forever),
                      label: const Text('Clear History')
                  )
                ]
              ),
            ),
            // Container(
            //   width: double.infinity,
            //   color: Colors.grey[300],
            //   padding: const EdgeInsets.only(
            //     top: 20,
            //     right: 20,
            //     bottom: 10,
            //     left: 20
            //   ),
            //   child:
            // ),
            // // const SizedBox(height: 2),
            // // const Divider(color: Colors.grey),
            // Container(
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //     border: Border(
            //         bottom: BorderSide(color: Colors.grey)
            //     )
            //   ),
            //   child: TextButton
            // ),
            Expanded(child: HistoryList()),
          ],
        )
      ),
    );
  }

  _clearHistory() async {
    Isar isar = Isar.getInstance()!;
    await isar.historys.where().idGreaterThan(0).deleteAll();
  }
}

class HistoryList extends StatefulWidget {

  HistoryList({Key? key}) : super(key: key);

  @override
  State<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  List<History> data = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  _fetchData() async {
    Isar isar = Isar.getInstance()!;
    var rows = await isar.historys.where().sortByCreatedAtDesc().findAll();
    setState(() {
      data = rows;
    });
  }

  _removeFromState(int id) {
    for(int i = 0; i < data.length; i++) {
      History h = data[i];
      if(h.id == id) {
        var datalist = [...data];
        datalist.removeAt(i);
        setState(() {
          data = datalist;
        });
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // return const Text('aaa');
    return data.isNotEmpty
      ? ListView.builder(
          itemCount: data!.length,
          itemBuilder: (_, idx) {
            History item = data![idx];
            return HistoryTile(item.id!, item.solution, item.problem, _removeFromState);
          },
          // separatorBuilder: (_, idx) => const Divider(
          //   color: Colors.grey,
          //   height: 1,
          // ),
        )
      : const EmptyHistoryWidget();
  }
}


class HistoryTile extends StatelessWidget {
  final int id;
  final String title;
  final String subtitle;
  final Function removeFromState;

  HistoryTile(this.id, this.title, this.subtitle, this.removeFromState, {Key?key}) : super(key: key);

  Widget _buildAutoSizeText(String text, {int lines=3, TextStyle? style}) {
    return AutoSizeText(
        text,
        maxLines: lines,
        minFontSize: 16,
        style: style,
    );
  }

  void _handleDelete(BuildContext context, int id) async {
    Isar isar = Isar.getInstance()!;

    await isar.writeTxn(() async {
      final history = await isar.historys.get(id);
      if(history != null) {
        await isar.historys.delete(id);
      }
    });

    removeFromState(id);
  }

  @override
  Widget build(BuildContext context) {
    var calc = Provider.of<CalculatorProvider>(context, listen: false);

    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      onDismissed: (dir) => _handleDelete(context, id),
      background: Container(
        alignment: Alignment.centerRight,
        color: Colors.red,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Icon(Icons.delete, color: Colors.white)
      ),
      child: ListTile(
        // key: ValueKey(id),
        leading: const Icon(Icons.calculate_outlined, size: 40, color: Colors.black38),
        title: _buildAutoSizeText(title, style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.black54
        )),
        subtitle: _buildAutoSizeText(subtitle),
        shape: const Border(
          bottom: BorderSide(color: Color(0xFFBDBDBD)),
        ),
        onTap: () {
          calc.append(title);
          Navigator.of(context).pop();
        },
      ),
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
