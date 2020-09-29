import 'package:bloc_and_provider/entity/SwipesBloc.dart';
import 'package:bloc_and_provider/widgets/central_box.dart';
import 'package:bloc_and_provider/widgets/rounded_button.dart';
import 'package:bloc_and_provider/widgets/square_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'CounterPage.dart';

class SwipePage extends StatefulWidget {
  static String id = 'swipe_page';

  @override
  _SwipePageState createState() => _SwipePageState();
}

class _SwipePageState extends State<SwipePage> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
      lowerBound: 0.5,
      upperBound: 1,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.decelerate,
    );
    _animationController.forward();
    _animationController.addListener(
      () {
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SwipesBloc>(
        builder: (context, _swipesBloc, child) {
          return StreamBuilder<int>(
            stream: _swipesBloc.pressedCount,
            builder: (context, snapshot) {
              String counterValue = snapshot.data.toString();

              return Stack(
                children: [
                  Container(
                    color: Color(0xFF3D9098),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Swipe Counter',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SquaredButton(
                                title: '-',
                                onPressed: () {
                                  _swipesBloc.incrementCounter.add(-1);
                                },
                              ),
                              SquaredButton(
                                buttonKey: 'incrementPlusButton',
                                title: '+',
                                onPressed: () {
                                  _swipesBloc.incrementCounter.add(1);
                                },
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RoundedButton(
                              color: Color(0xFFEC706E),
                              title: 'Reset',
                              onPressed: () {
                                _swipesBloc.resetCount;
                              },
                            ),
                            RoundedButton(
                              color: Color(0xFF999999),
                              title: 'To data screen',
                              onPressed: () {
                                Navigator.of(context).pushNamed(CounterData.id);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.width / 2,
                      child: Dismissible(
                          key: UniqueKey(),
                          onDismissed: (DismissDirection direction) {
                            if (direction == DismissDirection.endToStart) {
                              _swipesBloc.incrementCounter.add(-1);
                              setState(() {
                                _animationController.value = 0.5;
                                _animationController.forward();
                              });
                            } else {
                              _swipesBloc.incrementCounter.add(1);
                              setState(() {
                                _animationController.value = 0.5;
                                _animationController.forward();
                              });
                            }
                          },
                          child: CentralBox(
                            title: counterValue,
                            size: MediaQuery.of(context).size.width / 2 * _animation.value,
                          )),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
