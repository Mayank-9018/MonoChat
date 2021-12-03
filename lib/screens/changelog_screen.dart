import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangelogScreen extends StatelessWidget {
  const ChangelogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: loadChangelog(),
        builder: (con, snapshot) {
          Map<String, dynamic> changelog = {};
          if (snapshot.hasData) {
            changelog = jsonDecode(snapshot.data!);
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text('Changelog'),
              centerTitle: true,
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: ElevatedButton(
                  child: const Text('Dismiss'),
                  onPressed: snapshot.hasData
                      ? () async {
                          Navigator.of(context).pop();
                          SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          sharedPreferences.setBool(
                              "change_${changelog['version']}", true);
                        }
                      : null),
            ),
            body: snapshot.hasData
                ? Column(
                    children: [
                      Text(
                        '🎊 New in version: ' + changelog['version'] + ' 🎊',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                          child: ListView.builder(
                              itemCount: changelog['changes'].length,
                              itemBuilder: (con, index) {
                                return ListTile(
                                  title: Text(changelog['changes'][index]
                                          ['title'] ??
                                      ''),
                                  subtitle: Text(changelog['changes'][index]
                                          ['body'] ??
                                      ''),
                                );
                              }))
                    ],
                  )
                : null,
          );
        });
  }

  Future<String> loadChangelog() async {
    return rootBundle.loadString('assets/changelog.json');
  }
}
