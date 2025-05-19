import 'dart:async';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf_io.dart' as io;

class Server {
  static final Server _instance = Server._();

  Server._();
  static Server get instance => _instance;

  HttpServer? _server;

  Future<void> start() async {
    final router = Router();
    router.all('/', _handleOptions);
    router.get('/', _listData);
    router.post('/', _createData);
    router.put('/:id', _updateData);
    router.get('/:id', _readData);
    router.delete('/:id', _deleteData);

    final handler = Pipeline()
        .addMiddleware(logRequests())
        .addHandler(router.call);
    _server = await io.serve(handler, 'localhost', 54321);
  }

  Future<void> stop() async {
    await _server?.close();
  }
}

FutureOr<Response> _handleOptions(Request request) {
  return Response.ok(
    '',
    headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
      'Access-Control-Allow-Headers': 'Origin, Content-Type',
    },
  );
}

FutureOr<Response> _listData(Request request) async {
  return Response.ok('Hello, list data!');
}

FutureOr<Response> _createData(Request request) async {
  return Response.ok('Hello, create data!');
}

FutureOr<Response> _readData(Request request) async {
  final id = request.params['id'];
  return Response.ok('Hello, read data! $id');
}

FutureOr<Response> _updateData(Request request) async {
  final id = request.params['id'];
  return Response.ok('Hello, update data! $id');
}

FutureOr<Response> _deleteData(Request request) async {
  final id = request.params['id'];
  return Response.ok('Hello, delete data! $id');
}
