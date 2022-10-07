import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../styles.dart';
import '../collections/history.dart';



class EndlessListViewController<T> {
  late int limit;
  int currentPage = 1;
  int count = 0;

  bool hasMore = true;
  bool isLoading = false;
  bool hasData = false;

  Function(int)? dropById;
  Function? clearAll;
  Function? getAll;
  Function? fetchData;
  // Future? futureData;

  EndlessListViewController({required this.limit});

  void dispose() {
    currentPage = 1;
    limit = 0;
    count = 0;

    hasMore = true;
    isLoading = false;
    hasData = false;

    dropById = null;
    clearAll = null;
    getAll = null;
    fetchData = null;
    // futureData = null;
  }

  int incrPage() => ++currentPage;
}


class EndlessListView<T extends History> extends StatefulWidget {
  final EndlessListViewController controller;
  final Function(int, int) fetchData;
  final Function(BuildContext, T) builder;
  final ScrollController scrollController;
  final Function(int)? dropById;
  final Function? clearAll;
  // final Future futureData;

  EndlessListView({
    required this.controller,
    required this.fetchData,
    required this.builder,
    required this.scrollController,
    // required this.futureData,
    this.dropById,
    this.clearAll,
    Key? key
  }) : super(key: key);

  @override
  State<EndlessListView> createState() => _EndlessListViewState<T>();
}

class _EndlessListViewState<T extends History> extends State<EndlessListView> {
  late EndlessListViewController controller;
  late Future futureData;
  List<T> datalist = [];

  @override
  void initState() {
    super.initState();

    controller = widget.controller as EndlessListViewController<T>;
    controller.dropById = _dropById;
    controller.clearAll = _clearAll;
    controller.getAll = _getAll;
    controller.fetchData = _fetchData;

    futureData = _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _refresh(),
      child: FutureBuilder(
        future: futureData,
        builder: (context, snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.done:
              return controller.hasData
                ? ListView.builder(
                    controller: widget.scrollController,
                    itemCount: controller.count + 1,
                    itemBuilder: (ctx, idx) {
                      if(idx < controller.count) {
                        T item = datalist[idx];
                        return widget.builder(ctx, item);
                      }
                      else {
                        return controller.hasMore
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
                : const EndlessEmptyWidget();

            default:
              return const Center(
                child: CircularProgressIndicator()
              );
          }
        }
      )
    );
  }

  _fetchData() async {
    if(controller.isLoading) return;
    if(!controller.hasMore) return;

    int offset = (controller.currentPage - 1) * controller.limit;
    int limit = controller.limit + 1;
    List<T> rows = [];
    controller.isLoading = true;
    print('offset $offset');

    // Get data from db
    rows = await widget.fetchData(offset, limit);
    if(rows.length < limit) {
      controller.hasMore = false;
    }
    else {
      rows.removeLast();
      controller.incrPage();
    }

    if(rows.isNotEmpty) {
      setState(() {
        datalist.addAll(rows);
      });
      controller.hasData = true;
      print('has data: ${controller.hasData}');
    }

    controller.count = datalist.length;
    controller.isLoading = false;
    print('count ${controller.count}');
  }

  _refresh() async {
    try {
      controller.currentPage = 1;
      controller.hasMore = true;
      controller.isLoading = false;
      controller.hasData = false;

      setState(() {
        // _clearAll();
        futureData = _fetchData();
      });
    }
    catch(e) {
      // TODO: Missing catch
    }
  }

  _dropById(int id) {
    try {
      // DB
      if(widget.dropById != null) widget.dropById!(id);

      setState(() {
        datalist.removeWhere((T element) => element.id == id);
      });

      if(datalist.isEmpty) controller.hasData = false;
      controller.count = datalist.length;
    }
    catch(e) {
      // TODO: Missing catch
    }
  }

  _resetState() {
    setState(() {
      datalist.clear();
    });

    controller.currentPage = 1;
    controller.hasData = false;

    controller.hasMore = true;
    controller.isLoading = false;
    controller.count = 0;
  }

  _clearAll() {
    print('cleared');
    try {
      // DB
      if(widget.clearAll != null) widget.clearAll!();
      _resetState();
    }
    catch(e) {
      // TODO: Missing catch
    }

  }

  List<T> _getAll() => [...datalist];
}



class EndlessEmptyWidget extends StatelessWidget {
  const EndlessEmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(FontAwesomeIcons.faceLaughSquint, size: 100, color: Colors.grey[300]),
            Text('Nothing to see here',
                style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 30
                )
            )
          ],
        )
    );
  }
}
