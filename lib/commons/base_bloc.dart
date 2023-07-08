import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:async/async.dart';

abstract class BaseBloc {
  bool _isInit = false;
  bool get isInitialzed => _isInit;
  bool get disposed => !_isInit;

  late PublishSubject<bool> _loadingSubject;

  @nonVirtual
  Stream<bool> get loadingStream => _loadingSubject.stream;

  @mustCallSuper
  void init() {
    if (!_isInit) {
      print("$runtimeType initialize");
      _loadingSubject = PublishSubject<bool>();
      _isInit = true;
    }
  }

  @mustCallSuper
  void dispose() {
    try {
      _isInit = false;
      _loadingSubject.close();
      print("$runtimeType disposed");
    } catch (e, st) {
      print(e);
      print(st);
    }
  }

  Future<T?> callRequest<T>(
      {required Function future,
      List<dynamic>? positionalArguments,
      Map<Symbol, dynamic>? namedArguments,
      bool updateLoadingSubject = true}) async {
    if (!_isInit) {
      print('$runtimeType not initialized');
      return null;
    }
    if (updateLoadingSubject) _loadingSubject.add(true);
    CancelableOperation<T?> completer = CancelableOperation.fromFuture(
        Function.apply(future, positionalArguments, namedArguments),
        onCancel: () => null);
    try {
      final response = await completer
          .valueOrCancellation(null)
          .whenComplete(() {
        if (_isInit) {
          if (updateLoadingSubject) _loadingSubject.add(false);
        }
      });
      return response;
    } catch (e) {
      print(e);
    } finally {
      if (!completer.isCompleted) {
        completer.cancel();
      }
    }
    return null;

  }


 }