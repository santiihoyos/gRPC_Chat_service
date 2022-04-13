import 'package:grpc/grpc.dart';
import 'package:grpc_chat_server/grpc_chat_server.dart';

void main(List<String> arguments) async {
  final ChatService chatService = ChatService();
  final server = Server(
    [chatService],
    const <Interceptor>[],
    CodecRegistry(codecs: const [
      GzipCodec(),
      IdentityCodec(),
    ]),
  );

  await server.serve(port: 24957);
  print('Server listening on port ${server.port}...');
}
