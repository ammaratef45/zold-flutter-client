import 'package:flutter/material.dart';
import 'package:zold_wallet/dialogs.dart';
import 'package:zold_wallet/settings_page/settings_page_viewmodel.dart';
import 'package:zold_wallet/stateless_views/title_text.dart';

/// View of the settings page
class SettingsPageView extends SettingsPageViewModel {
  @override
  Widget build(BuildContext context) => Scaffold(
      key: snackKey,
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Center(
            child: const TitleText('Settings'),
          ),
          const SizedBox(
            height: 12,
          ),
          Flexible(
              child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.file_download),
                  title: const Text(
                    'Download Wallet',
                    style: TextStyle(color: Color(0xff1970b6), fontSize: 16),
                  ),
                  onTap: download,
                ),
                const Divider(
                  height: 0,
                ),
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text(
                    'Restart Wallet',
                    style: TextStyle(color: Color(0xff1970b6), fontSize: 16),
                  ),
                  onTap: restart,
                ),
                const Divider(
                  height: 0,
                ),
                ListTile(
                    leading: const Icon(Icons.exit_to_app),
                    title: const Text(
                      'Logout',
                      style: TextStyle(color: Color(0xff1970b6), fontSize: 16),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      logout();
                    }),
                const Divider(
                  height: 0,
                )
              ])),
          const SizedBox(
            height: 12,
          ),
          InkWell(
            child: const Text(
              'Go back to home screen',
              style: TextStyle(color: Colors.blue),
            ),
            onTap: () => Navigator.pop(context),
          ),
        ],
      )));
}
