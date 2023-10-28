import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'discover_event.dart';
part 'discover_state.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  DiscoverBloc() : super(DiscoverInitial()) {
    on<DiscoverEvent>((event, emit) {});
  }
}
