import 'package:bloc_and_provider/pages/CounterPage.dart';
import 'package:bloc_and_provider/pages/SwipesPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'entity/SwipesBloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<SwipesBloc>(
          create: (_)=>SwipesBloc(),
          dispose: (_,SwipesBloc swipesBloc)=>swipesBloc.dispose(),
        )
      ],
      child: MaterialApp(
        title: 'SwipesBloc + provider',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SwipePage(),
        routes: <String,WidgetBuilder>{
          SwipePage.id: (BuildContext context) => SwipePage(),
          CounterData.id: (BuildContext context) => CounterData(),
        },
      ),
    );
  }
}
