// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:math';

import 'package:dot_and_boxes/entity/line_entity.dart';
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

  bool turnRed = true;
  List<LineEntity> lines = [];

  @override
  void initState() {
    super.initState();

    for (var y = 0; y < widget.dots; y++) {
      for (var x = 0; x < widget.dots - 1; x++) {
        lines.add(LineEntity(
          p1: Point(x, y),
          p2: Point(x + 1, y),
        ));
      }

      if(y != widget.dots - 1) {
        for (var x = 0; x < widget.dots; x++) {
          lines.add(LineEntity(
            p1: Point(x, y),
            p2: Point(x, y + 1),
          ));
        }
      }
    }
    print("lines.length = ${lines.length}"); 
    print(lines);
  }

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

                              if(iX.isEven){
                                return Container(
                                  width: circleSquareRib,
                                  height: circleSquareRib,
                                  decoration: const BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                  ),
                                );
                              }

                              final int p1X = (iX - 1) ~/ 2;
                              final LineEntity line = lines.firstWhere(
                                (element) => element == LineEntity(p1: Point(p1X, iY), p2: Point(p1X + 1, iY)));
                              return Expanded(
                                child: InkWell(
                                  onTap: () {
                                    draw(line);
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: circleSquareRib,
                                    color: line.completed ? Colors.grey.shade800 : null,
                                  ),
                                ),
                              );
                            }),
                          ),
                          if(iY != widget.dots - 1) Row(children: List.generate(xDirectionWidgetsCount, (iX) {
                            
                            final int p1X = iX ~/ 2;
                            final LineEntity line = lines.firstWhere(
                              (element) => element == LineEntity(p1: Point(p1X, iY), p2: Point(p1X, iY + 1)));

                            if(iX.isEven) {
                              return InkWell(
                              onTap: () {
                                draw(line);
                              },
                              child: Container(
                                width: circleSquareRib,
                                height: homeRib,
                                color: line.completed ? Colors.grey.shade800 : null,
                              ),
                            );
                            }
                            
                            
                            return Expanded(
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
  
  void draw(LineEntity line) {
    if(line.completed) {
      return;
    } 

    Color color = turnRed ? Colors.red: Colors.blue;
    setState(() {
      line.color = color;
      line.completed = true;
    });

    /// todo: add check Completed Home method
  }
}