import 'dart:async';

import 'package:grpc_chat_server/generated/chat.pbgrpc.dart';

/// Chat Service implementation
class ChatService extends ChatServiceBase {
  /// Messages list.
  final List<Message> _messagesHistory = [];

  /// Messages StreamController to broadcast incomming messages on [_messages].
  final StreamController<Message> _streamController =
      StreamController.broadcast();

  /// Public Stream<Message> to listen from clients incommign messages.
  late Stream<Message> _messages;

  ChatService() {
    _messages = _streamController.stream;
  }

  ///RPC called by clients to subscribe to incomming messages
  @override
  Stream<Message> listen(call, HandShake request) {
    return _messages;
  }

  ///RPC called by clients when they send any message to server.
  /// returns [MessageResult] with ACK status of write operation.
  @override
  Future<MessageResult> write(call, Message request) {
    _messagesHistory.add(request);
    _streamController.add(request);
    return Future.value(MessageResult(wasOK: true));
  }
}
