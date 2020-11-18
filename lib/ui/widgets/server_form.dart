import 'package:flutter/material.dart';
import 'package:mereach/business_logic/models/server.dart';
import 'package:mereach/business_logic/view_models/server_provider.dart';
import 'package:mereach/exceptions/http_exception.dart';

class ServerForm extends StatefulWidget {
  final ServerProvider model;

  const ServerForm(this.model);

  @override
  _ServerFormState createState() => _ServerFormState();
}

class _ServerFormState extends State<ServerForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _urlController = TextEditingController();

  void _submit() {
    if (_formKey.currentState.validate()) {
      final server =
          Server(name: _nameController.text, url: _urlController.text);
      try {
        widget.model.addServer(server);
        Navigator.pop(context);
      }  on HttpException catch (error) {
        print(error.toString());
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Add new server',
                style: TextStyle(fontSize: 20, color: Colors.blueGrey),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: 'Name',
                        labelText: 'Website Name',
                      ),
                      validator: (String value) {
                        return value.isEmpty ? 'Please insert the Name' : null;
                      },
                    ),
                    TextFormField(
                      controller: _urlController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.url,
                      decoration: const InputDecoration(
                        hintText: 'https://www.example.com',
                        labelText: 'Website URL',
                      ),
                      validator: (String value) {
                        var urlPattern =
                            r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)';
                        bool match = RegExp(urlPattern).hasMatch(value);
                        if (value.isEmpty) {
                          return 'Please enter an URL';
                        } else if (!match) {
                          return 'Please enter a valid URL';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(onPressed: _submit, child: Text('Add', style: TextStyle(fontSize: 17, color: Colors.green),))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
