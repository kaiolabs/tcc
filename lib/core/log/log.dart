import 'package:flutter/material.dart';

class Log {
  final String message;
  final IconData icon;
  final Color color;
  final String title;

  Log.d({required this.message})
      : icon = Icons.code,
        title = 'Debug',
        color = Colors.blue;

  Log.e({required this.message})
      : icon = Icons.block,
        title = 'Error',
        color = Colors.red;

  Log.i({required this.message})
      : icon = Icons.info,
        title = 'Info',
        color = Colors.green;

  Log.v({required this.message})
      : icon = Icons.abc,
        title = 'Verbose',
        color = Colors.purple;

  Log.w({required this.message})
      : icon = Icons.warning,
        title = 'Warning',
        color = Colors.amber;

  Log.wtf({required this.message})
      : icon = Icons.dangerous,
        title = 'WTF',
        color = Colors.orange;
}
