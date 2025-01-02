import 'package:flutter/material.dart';


class SettingTab extends StatefulWidget {
  static const String routeName = 'SettingTab';

  @override
  State<SettingTab> createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {
  bool isDarkModeEnabled = false;
  String selectedLanguage = 'English';

  // Function to show the language selection bottom sheet.

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Dark Mode'),
                Switch(
                  value: isDarkModeEnabled,
                  onChanged: (value) {
                    setState(() {
                      isDarkModeEnabled = value;
                    });
                    // Add logic to change the app's theme mode here.
                  },
                ),
              ],
            ),
            ListTile(
              title: Text('Language'),
              subtitle: Text(selectedLanguage),
              onTap: () {
                _showLanguageBottomSheet(context);
              },
            ),

          ],
        ),
      ),
    );
  }
  void _showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Arabic'),
                onTap: () {
                  setState(() {
                    selectedLanguage = 'Arabic';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('English'),
                onTap: () {
                  setState(() {
                    selectedLanguage = 'English';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
