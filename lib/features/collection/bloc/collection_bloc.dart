import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'collection_event.dart';
part 'collection_state.dart';

class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {
  CollectionBloc() : super(CollectionInitial()) {
    on<CollectionEvent>((event, emit) {});
  }
}
