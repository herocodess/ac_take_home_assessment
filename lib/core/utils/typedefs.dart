import 'package:dartz/dartz.dart';

typedef RequestParams<T> = Map<T, dynamic>;

typedef ResponseFormat<T> = Future<Either<String, T>>;
