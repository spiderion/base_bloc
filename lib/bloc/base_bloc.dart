import 'dart:async';

import 'package:base_bloc/bloc/primary_state.dart';
import 'package:flutter/cupertino.dart';

import 'data_state.dart';
import 'event.dart';

///The bloc holds the state of the widget
///listens [BaseWidget]SubClass's events
///emits states to the widget
abstract class BaseBloc {
  final _eventController = StreamController<BaseBlocEvent>();
  final _stateController = StreamController<BaseBlocPrimaryState>();

  BaseBloc() {
    _eventController.stream.listen((event) {
      onUiDataChange(event);
      postUiEvent(event);
    });
  }

  ///Called by the [BaseWidget] after the widget has been displayed
  Future<void> afterWidgetBinding() async {}

  void postUiEvent(BaseBlocEvent event) {}

  void didChangeDependencies() {}

  void didUpdateWidget() {}

  ///You can listen to [streams] from the [BaseWidget]subClass within a [StreamBuilder]
  List<Stream> _secondaryStreams = <Stream>[];

  ///Events emitted by the widget bloc.event.add(BaseBlocEvent(data)) will be captured here
  void onUiDataChange(BaseBlocEvent event);

  ///used by the [BaseWidget] to listen to the bloc [BaseBlocPrimaryState] states
  Stream<BaseBlocPrimaryState> get baseState => _stateController.stream;

  ///used by the [BaseWidget] add [BaseBlocEvent]s
  /// [BaseBlocEvent] must be extended
  Sink<BaseBlocEvent> get event => _eventController.sink;

  Sink<BaseBlocPrimaryState>? get sinkState {
    if (_stateController.isClosed) return null;
    return _stateController.sink;
  }

  ///Use this to listen events emitted by the [BaseBloc]
  Stream<T> getStreamOfType<T extends BaseBlocDataState>() =>
      _secondaryStreams.singleWhere((element) => element is Stream<T>,
              orElse: () =>
                  throw FlutterError("Streams of type ${T.toString()} should be registered in the bloc"))
          as Stream<T>;

  ///register streams that extend [BaseBlocDataState] to _secondaryStreams
  ///You can listen to them from the widget side within a [StreamBuilder]
  ///get the reference stream using bloc.getStreamOfType<BaseBlocDataStateSubClass>() method
  void registerStreams(List<Stream> streams) => _secondaryStreams.addAll(streams);

  @mustCallSuper
  dispose() {
    _eventController.close();
    _stateController.close();
  }
}
