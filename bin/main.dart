import 'dart:io';

import 'package:grpc/grpc.dart';
import 'package:grpc_chat_server/grpc_chat_service.dart';

const int defaultPort = 8888;
const String defaultHost = "127.0.0.1";

void main(List<String> arguments) async {
  var actualPort = defaultPort;
  var actualHost = defaultHost;

  if (arguments.isNotEmpty) {
    try {
      actualHost = arguments[0];
    } catch (ex) {
      print("[ERROR] expected String value at argument with index 0");
      exit(-1);
    }
  }

  if (arguments.length > 1) {
    try {
      actualPort = int.parse(arguments[1]);
    } catch (ex) {
      print("[ERROR] expected int value at argument with index 1");
      exit(-1);
    }
  }

  initChatService(host: actualHost, port: actualPort);
}

void initChatService({
  required String host,
  required int port,
}) async {
  final ChatService chatService = ChatService();
  final server = Server(
    [chatService],
    const <Interceptor>[],
    CodecRegistry(codecs: const [
      GzipCodec(),
      IdentityCodec(),
    ]),
  );

  await server.serve(
    address: host,
    port: port,
  );

  print('[RUNNING] Chat service on $host:${server.port}');
}
