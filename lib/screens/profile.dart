import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../buttons/dropdown.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white54,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Icon(Icons.person, size: 52, color: Colors.grey),
              SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)!.profile,
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Sequel',
                  color: Colors.black54,
                ),
              ),
              ListTile(
                leading: Icon(Icons.person, size: 30, color: Colors.grey),
                title: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: Text(AppLocalizations.of(context)!.userName),
                ),
              ),
              ListTile(
                leading:
                    Icon(Icons.email_outlined, size: 30, color: Colors.grey),
                title: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: Text(AppLocalizations.of(context)!.userEmail),
                ),
              ),
              ListTile(
                leading: Icon(Icons.language_sharp),
                title: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text(AppLocalizations.of(context)!.language),
                ),
                trailing: CustomDropDownMenu(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
