import 'package:logger/logger.dart';

import 'log.dart';

class LogPattern extends Logger {
  LogPattern({LogPrinter? printer}) : super(printer: printer);

  @override
  void d(message, [error, StackTrace? stackTrace]) {
    final log = Log.d(message: message);
    logs.add(log);
    super.d(message, error, stackTrace);
  }

  @override
  void e(message, [error, StackTrace? stackTrace]) {
    final log = Log.e(message: message);
    logs.add(log);
    super.e(message, error, stackTrace);
  }

  @override
  void i(message, [error, StackTrace? stackTrace]) {
    final log = Log.i(message: message);
    logs.add(log);
    super.i(message, error, stackTrace);
  }

  @override
  void v(message, [error, StackTrace? stackTrace]) {
    final log = Log.v(message: message);
    logs.add(log);
    super.v(message, error, stackTrace);
  }

  @override
  void w(message, [error, StackTrace? stackTrace]) {
    final log = Log.w(message: message);
    logs.add(log);
    super.w(message, error, stackTrace);
  }

  @override
  void wtf(message, [error, StackTrace? stackTrace]) {
    final log = Log.wtf(message: message);
    logs.add(log);
    super.wtf(message, error, stackTrace);
  }
}

List<Log> logs = [];
