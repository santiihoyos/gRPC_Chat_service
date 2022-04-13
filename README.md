Simple Dart gRPC + ProtocolBuffers microservice to serve Chat server.

Generate dart code from proto files with:
```shell
cd protos
protoc -I=. --dart_out=grpc:../lib/generated *.proto 
```

Run microservice
```shell
dart run ./bin/main.dart
```

Server will listen on localhost:24957