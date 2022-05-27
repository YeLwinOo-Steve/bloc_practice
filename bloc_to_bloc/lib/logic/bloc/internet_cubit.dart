import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_counter/logic/bloc/internet_state.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../constants/enums.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  late StreamSubscription connectivityStreamSubscription;
  InternetCubit({required this.connectivity}) : super(InternetLoading()){
      monitorInternetConnection();
  }

  void monitorInternetConnection() {
    connectivityStreamSubscription = connectivity.onConnectivityChanged.listen((connectivityResult) {
      if(connectivityResult == ConnectivityResult.wifi){
        emitInternetConnected(ConnectionType.wifi);
      }else if(connectivityResult == ConnectivityResult.mobile){
        emitInternetConnected(ConnectionType.mobile);
      }else if(connectivityResult == ConnectivityResult.none){
        emitInternetDisconnected();
      }
    });
  }

  void emitInternetConnected(ConnectionType _connectionType) =>
      emit(InternetConnected(connectionType: _connectionType));
  void emitInternetDisconnected() => emit(InternetDisconnected());

  @override
  Future<void> close()async {
    connectivityStreamSubscription.cancel();
    return super.close();
  }
}
