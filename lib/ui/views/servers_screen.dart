import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mereach/business_logic/view_models/server_provider.dart';
import 'package:mereach/exceptions/http_exception.dart';
import 'package:mereach/services/service_locator.dart';
import 'package:mereach/ui/widgets/server_form.dart';
import 'package:mereach/ui/widgets/server_item.dart';
import 'package:provider/provider.dart';

class ServersScreen extends StatefulWidget {
  @override
  _ServersScreenScreenState createState() => _ServersScreenScreenState();
}

class _ServersScreenScreenState extends State<ServersScreen> {
  ServerProvider model = serviceLocator<ServerProvider>();
  bool _loading = true;
  Timer timer;

  @override
  void initState() {
    super.initState();
    model.loadData().then((_) => setState(() {
          _loading = false;
        }));
    timer = Timer.periodic(Duration(minutes: 1), (Timer t) => model.loadData());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  _openTransactionFormModal(BuildContext context, ServerProvider model) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        backgroundColor: Colors.black,
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return ServerForm(model);
        });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ServerProvider>(
      create: (context) => model,
      child: Consumer<ServerProvider>(
          builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text('meReach'),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      _openTransactionFormModal(context, model);
                    },
                  ),
                ],
              ),
              body: RefreshIndicator(
                onRefresh: () => model.loadData(),
                child: _loading
                    ? Center(child: CircularProgressIndicator())
                    : listServers(model),
              ))),
    );
  }

  Padding listServers(ServerProvider model) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: model.servers.length,
        itemBuilder: (ctx, index) => Dismissible(
            key: UniqueKey(),
            confirmDismiss: (DismissDirection direction) async {
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Delete Confirmation"),
                    content: Text(
                        "Are you sure you want to delete the ${model.servers[index].name} server?"),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text("Cancel"),
                      ),
                      FlatButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text("Delete")),
                    ],
                  );
                },
              );
            },
            background: Container(
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    Text(
                      'Delete',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              try {
                setState(() {
                  model.deleteServer(model.servers[index]);
                });
              } on HttpException catch (error) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text(error.toString()),
                  ),
                );
              }
            },
            child: ServerItem(model.servers[index])),
      ),
    );
  }
}
