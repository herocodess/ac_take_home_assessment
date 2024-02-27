import 'package:acumen_technical_assessment/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:acumen_technical_assessment/features/products/presentation/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<BlocProvider> providers = [
  BlocProvider<AuthBloc>(
    create: (BuildContext context) => AuthBloc(),
  ),
  BlocProvider<ProductBloc>(
    create: (BuildContext context) => ProductBloc(),
  ),
];
