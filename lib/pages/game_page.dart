// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:math';

import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  final int dots;
  const GamePage({
    Key? key,
    required this.dots,
  }) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Page'),
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            color: Colors.red,
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                print('max width: ${constraints.maxWidth} and max height: ${constraints.maxHeight}');
                final squareRib = min(constraints.maxHeight, constraints.maxWidth);
                final circleSquareRib = squareRib * ((10- widget.dots)/ 100); //2 => 0.08 5 => 0.05 7 => 0.03
                // const double circleSquareRib = 20;
                final homeRib = (squareRib - (circleSquareRib * widget.dots)) / 
                  widget.dots - 1;
            
                return AspectRatio(aspectRatio: 1,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(widget.dots, (iY) {
                      
                      final xDirectionWidgetsCount = widget.dots * 2 - 1;
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: List.generate(xDirectionWidgetsCount, (iX) {
                              return iX.isEven ? Container(
                                width: circleSquareRib,
                                height: circleSquareRib,
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                              ) : Expanded(
                                child: Container(
                                  width: double.infinity,
                                  height: circleSquareRib,
                                  color: Colors.blue,
                                ),
                              );
                            }),
                          ),
                          if(iY != widget.dots - 1) Row(children: List.generate(xDirectionWidgetsCount, (iX) {
                            return iX.isEven ? Container(
                              width: circleSquareRib,
                              height: homeRib,
                              color: Colors.blue,
                            ) : Expanded(
                              child: Container(
                                width: homeRib,
                                height: homeRib,
                                color: Colors.grey,
                              ),
                            );
                          })),
                       
                       ],
                      );
                    })
                    
                  ),
                ),
                );
            
              }),),
          Container(
            height: 100,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}