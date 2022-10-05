import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../app/providers/calculator_provider.dart';
import '../app/providers/history_provider.dart';
import '../app/collections/history.dart';
import '../app/styles.dart';


class HistoryScreen extends StatefulWidget {
  static const route = '/history';

  HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final ScrollController _scrollController = ScrollController();
  late Future futureData;
  var page = 1;
  bool more = true;
  bool isLoading = false;
  List<History> data = [];

  @override
  void initState() {
    super.initState();

    futureData = _fetchData();

    _scrollController.addListener(() {
      if(_scrollController.position.pixels >= _scrollController.position
          .maxScrollExtent) {
        _fetchData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
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

          if(data.isNotEmpty)
            Container(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Tap to copy'),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red
                    ),
                    onPressed: () => _clearHistory(context),
                    icon: const Icon(Icons.delete_forever,
                      color: Colors.red,
                    ),
                    label: const Text('Clear History')
                  )
                ]
              ),
            ),

          Expanded(
            child: RefreshIndicator(
              onRefresh: () async => setState(() {
                // Reset everything
                more = true;
                isLoading = false;
                page = 1;
                data.clear();
                futureData = _fetchData();
              }),
              child: FutureBuilder(
                  future: futureData,
                  builder: (context, snapshot) {
                    switch(snapshot.connectionState) {
                      case ConnectionState.done:
                        return data.isNotEmpty
                          ? ListView.builder(
                              controller: _scrollController,
                              itemCount: data.length + 1,
                              itemBuilder: (_, idx) {
                                if(idx < data.length) {
                                  History item = data[idx];
                                  return HistoryTile(item.id!, item.solution, item.problem,
                                      removeFromState);
                                }
                                else {
                                  return more
                                    ? const Padding(
                                        padding: EdgeInsets.symmetric(vertical: 10),
                                        child: Center(
                                          child: CircularProgressIndicator()
                                        )
                                      )
                                    : const SizedBox(width: 0);
                                }
                              }
                            )
                          : const EmptyHistoryWidget();

                      default:
                        return const Center(
                          child: CircularProgressIndicator()
                        );
                    }
                  }
              ),
            )
          ),
        ],
      ),
    );
  }

  Future _fetchData() async {
    if(!more || isLoading) return;
    isLoading = true;

    // Simulate delays
    await Future.delayed(const Duration(seconds: 1));

    Isar isar = Isar.getInstance()!;
    List<History> rows = await isar.historys.where().sortByCreatedAtDesc()
      .offset((page - 1) * 10).limit(10 + 1).findAll();

    setState(() {
      isLoading = false;
      if(rows.length < 10 + 1) {
        more = false;
      }
      else {
        rows.removeLast();
      }
      data.addAll(rows);
      page++;
    });
  }

  _clearHistory(BuildContext context) async {
    await Provider.of<HistoryProvider>(context, listen: false).clearHistory();
    data = [];
    setState(() {});
  }

  removeFromState(int id) {
    List<History> filteredData = [...data];
    filteredData.removeWhere((item) => item.id == id);
    setState(() {
      data = filteredData;
    });
  }
}


class HistoryTile extends StatelessWidget {
  final int id;
  final String title;
  final String subtitle;
  final Function removeFromState;

  const HistoryTile(this.id, this.title, this.subtitle, this.removeFromState,
      {Key?key}) : super(key: key);

  Widget _buildAutoSizeText(String text, {int lines=3, TextStyle? style}) {
    return AutoSizeText(
        text,
        maxLines: lines,
        minFontSize: 16,
        style: style,
    );
  }

  void _handleDelete(BuildContext context, int id) async {
    Provider.of<HistoryProvider>(context, listen: false).removeHistory(id);
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
          Icon(Icons.history_outlined,
              size: 100,
              color: tintColor(Colors.grey, 0.5),
          ),
          Text('Nothing to see here',
            style: TextStyle(
              color: tintColor(Colors.grey, 0.3),
              fontSize: Theme.of(context).textTheme.headline1!.fontSize
            )
          )
        ],
      )
    );
  }
}
