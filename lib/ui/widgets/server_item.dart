import 'package:flutter/material.dart';
import 'package:mereach/business_logic/models/server.dart';

class ServerItem extends StatelessWidget {
  final Server server;

  ServerItem(this.server);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(server.name),
          subtitle: server.lastUpdate == null
              ? Text('Loading')
              : Text('Last Update: ' + server.lastUpdate),
          trailing: server.status == null
              ? CircularProgressIndicator()
              : Text(
                  server.status,
                  style: TextStyle(
                      color: server.status == 'Online'
                          ? Colors.green
                          : Colors.red),
                ),
        ),
        Divider(
          thickness: 2,
          height: 5,
        ),
      ],
    );
  }
}
