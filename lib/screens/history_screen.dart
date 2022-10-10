import 'package:SimpleCalc/app/collections/settings.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../app/providers/calculator_provider.dart';
import '../app/providers/history_provider.dart';
import '../app/collections/history.dart';
import '../app/styles.dart';
import '../app/components/EndlessListView.dart';
import '../app/styles.dart';


class HistoryScreen extends StatefulWidget {
  static const route = '/history';

  HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final ScrollController _scrollController = ScrollController();
  EndlessListViewController<History> controller = EndlessListViewController<History>(limit: 10);
  // Future? futureData;

  @override
  void initState() {
    super.initState();

    // futureData = controller.fetchData!();

    _scrollController.addListener(() {
      if(_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
        controller.fetchData!();
      }
    });

  }

  @override
  void dispose() {
    _scrollController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History')
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopMessageWidget(clearAll: () => controller.clearAll!()),

          Expanded(
            child: EndlessListView<History>(
              controller: controller,
              fetchData: _fetchData,
              dropById: _dropById,
              clearAll: _clearHistory,
              // futureData: futureData,
              scrollController: _scrollController,
              builder: (_, dynamic item) {
                return HistoryTile(item.id, item.solution, item.problem, controller.dropById!);
              }
            ),
          ),

        ],
      ),
    );
  }

  Future<List<History>> _fetchData(int offset, int limit) async {
    // Simulate delays
    await Future.delayed(const Duration(seconds: 1));

    Isar isar = Isar.getInstance()!;
    List<History> rows = await isar.historys.where().sortByCreatedAtDesc()
        .offset(offset).limit(limit).findAll();
    return rows;
  }

  _clearHistory() async {
    Isar isar = Isar.getInstance()!;
    await isar.writeTxn(() async {
      await isar.historys.where().idGreaterThan(0).deleteAll();
    });
  }

  _dropById(int id) async {
    Isar isar = Isar.getInstance()!;
    await isar.writeTxn(() async => await isar.historys.delete(id));
  }

}


class HistoryTile extends StatelessWidget {
  final int id;
  final String title;
  final String subtitle;
  final Function(int) dropById;

  const HistoryTile(this.id, this.title, this.subtitle, this.dropById, {Key?key}) : super(key: key);

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

    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      onDismissed: (dir) => dropById(id),
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


class TopMessageWidget extends StatefulWidget {
  final VoidCallback? clearAll;

  const TopMessageWidget({this.clearAll, Key? key}) : super(key: key);

  @override
  State<TopMessageWidget> createState() => _TopMessageWidgetState();
}

class _TopMessageWidgetState extends State<TopMessageWidget> {
  bool display = false;

  @override
  void initState() {
    super.initState();

    _getHistoryCount().then((count) {
      setState(() => display = count > 0);
    });
  }

  Future<int> _getHistoryCount() async {
    var isar = Isar.getInstance()!;
    return await isar.historys.count();
  }

  @override
  Widget build(BuildContext context) {
    return display
        ? Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black38,
                      blurRadius: 5,
                      offset: Offset(0, 2)
                  )
                ]
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SizedBox(
              height: 50,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Tap number to copy'),

                    // if(widget.clearAll != null)
                    TextButton.icon(
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.pink.withOpacity(0.6)
                        ),
                        onPressed: widget.clearAll,
                        icon: Icon(Icons.delete_forever,
                          color: Colors.pink.withOpacity(0.6),
                        ),
                        label: const Text('Clear History')
                    )
                  ]
              ),
            ),
          )
        : const SizedBox(height: 0);
  }
}


