import 'dart:developer';
import 'package:socket_io_client/socket_io_client.dart';

class SignallingService {
  // instance of Socket
  Socket? socket;

  SignallingService._();
  static final instance = SignallingService._();

  init({required String websocketUrl, required String selfCallerID}) {
    // init Socket
    socket = io(websocketUrl, {
      "transports": ['websocket', 'polling'],
      "query": {"callerId": selfCallerID},
      "timeout": 60000,
      // "transports": ['websocket'],
      // "query": {"callerId": selfCallerID}
    });
    socket!.emit('register', {'callerId': selfCallerID});
    // // listen onConnect event
    // socket!.onConnect((data) {
    //   log("Socket connected !!");
    // });

    // // listen onConnectError event
    // socket!.onConnectError((data) {
    //   log("Connect Error $data");
    // });

    socket!.onConnect((_) => log("Socket connected !!"));
    socket!.onDisconnect((_) => log("Socket disconnected !!"));
    socket!.onConnectError((data) => log("Connect Error: $data"));
    socket!.onError((error) => log("Error: $error"));

    // connect socket
    socket!.connect();
  }
}
