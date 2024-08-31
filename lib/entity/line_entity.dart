import 'dart:math';

import 'package:flutter/material.dart';

class LineEntity {
  LineEntity({
    required this.p1,
    required this.p2,
    this.color,
  });

  Color? color;
  final Point p1;
  final Point p2;
  bool completed = false;

  @override
  operator ==(Object other) {
    if (other is LineEntity) {
      return p1 == other.p1 && p2 == other.p2;
    }
    return false;
  }
  
  @override
  int get hashCode => Object.hash(p1, p2);

  @override
  String toString() {
    return 'LineEntity{p1: $p1, p2: $p2}';
  }
}


// final l1 = LineEntity(p1: Point(0,0), p2: Point(1,0)) 
// final l2 = LineEntity(p1: Point(0,0), p2: Point(1,0))
//
//if(l1 == l2) {
// 
//} else {