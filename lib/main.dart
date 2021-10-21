import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Screens/login_screen.dart';
import 'bloc/cart_bloc.dart';
import 'bloc/cart_states.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartBloc>(
        create: (context) => CartBloc(InitialState()),
        child: MaterialApp(
          home: Login(),
        ));
  }
}
