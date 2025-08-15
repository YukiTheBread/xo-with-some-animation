import 'package:flutter/material.dart';

/// บอกว่าจะวาด x หรือ o ที่ตำแหน่งไหน
class Mark {
  final Offset position;
  final String type; // 'O' or 'X'
  final int row;
  final int col;
  double progress; // 0.0 to 1.0

  Mark({
    required this.position,
    required this.type,
    required this.row,
    required this.col,
    this.progress = 0.0,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Mark &&
          runtimeType == other.runtimeType &&
          position == other.position &&
          type == other.type &&
          row == other.row &&
          col == other.col;

  @override
  int get hashCode =>
      position.hashCode ^ type.hashCode ^ row.hashCode ^ col.hashCode;
}
