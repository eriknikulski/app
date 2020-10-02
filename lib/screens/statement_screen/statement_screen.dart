import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;

import 'package:nhie/blocs/app/app.dart';
import 'package:nhie/env.dart';
import 'package:nhie/screens/statement_screen/widgets/statement_container_view.dart';

class StatementScreen extends StatelessWidget {
  StatementScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          actions: [
            DropdownButtonHideUnderline(
              child: DropdownButton(
                icon: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Icon(
                    Icons.translate,
                    color: Theme.of(context).textTheme.display1.color,
                  ),
                ),
                onChanged: (String lang) {
                  context.locale = Locale(lang);
                  BlocProvider.of<AppBloc>(context).add(ChangeLanguage(lang));
                },
                items: env.languageCodes
                    .map((String languageCode) => DropdownMenuItem(
                          value: languageCode,
                          child: Text(languageCode).tr(),
                        ))
                    .toList(),
              ),
            ),
          ]),
      body: Column(
        children: [
          Expanded(
            child: StatementContainerView(),
          ),
          Container(
            height: 56,
          )
        ],
      ),
    );
  }
}
