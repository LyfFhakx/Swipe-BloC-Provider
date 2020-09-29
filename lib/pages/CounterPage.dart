import 'package:bloc_and_provider/entity/SwipesBloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterData extends StatefulWidget {
  static String id = 'counter_data';

  @override
  _CounterDataState createState() => _CounterDataState();
}

class _CounterDataState extends State<CounterData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter data screen'),
        backgroundColor: Color(0xFF3D9098),
      ),
      body: Center(
        child: Consumer<SwipesBloc>(
          builder: (context, _swipesBloc, child) {
            return StreamBuilder<int>(
              stream: _swipesBloc.pressedCount,
              builder: (context, snapshot) {
                String counterValue = snapshot.data.toString();
                return Text(counterValue);
              },
            );
          },
        ),
      ),
    );
  }
}
