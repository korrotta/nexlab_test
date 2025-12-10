import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/authentication/bloc/auth_bloc.dart';
import 'features/authentication/pages/login_page.dart';
import 'features/contacts/bloc/contact_bloc.dart';
import 'services/auth_service.dart';
import 'services/contact_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(authService: AuthService()),
        ),
        BlocProvider(
          create: (_) => ContactBloc(contactService: ContactService()),
        ),
      ],
      child: MaterialApp(
        title: 'Nexlab Test',
        debugShowCheckedModeBanner: false,
        home: const LoginPage(),
      ),
    );
  }
}
