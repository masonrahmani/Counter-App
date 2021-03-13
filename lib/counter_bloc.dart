import 'dart:async';

import 'package:bloc1/counter_evnet.dart';

enum counterAction { Incerement, Decerement }
int _counter = 1;

class CounterBloc {
  final _counterStateControler = StreamController<int>();
  StreamSink<int> get _incounter => _counterStateControler.sink;
  Stream<int> get counter => _counterStateControler.stream;

  final _counterEventControler = StreamController<CounterEvent>();
  StreamSink<CounterEvent> get counterEventSink => _counterEventControler.sink;
  CounterBloc() {
    _counterEventControler.stream.listen(_mapEventToState);
  }

  void _mapEventToState(CounterEvent event) {
    if (event is Increment) {
      _counter++;
    } else {
      _counter--;
    }
    _incounter.add(_counter);
  }

  void dispose() {
    _counterEventControler.close();
    _counterStateControler.close();
  }
}
