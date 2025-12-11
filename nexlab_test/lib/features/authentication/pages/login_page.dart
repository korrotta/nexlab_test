import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../home/pages/home_page.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widgets/email_field.dart';
import '../widgets/login_button.dart';
import '../widgets/login_header.dart';
import '../widgets/password_field.dart';
import '../widgets/test_accounts_card.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        LoginRequested(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const HomePage()),
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header
                      const LoginHeader(),
                      const SizedBox(height: 48),

                      // Email Field
                      EmailField(
                        controller: _emailController,
                        enabled: !isLoading,
                      ),
                      const SizedBox(height: 16),

                      // Password Field
                      PasswordField(
                        controller: _passwordController,
                        enabled: !isLoading,
                      ),
                      const SizedBox(height: 24),

                      // Login Button
                      LoginButton(
                        onPressed: _handleLogin,
                        isLoading: isLoading,
                      ),
                      const SizedBox(height: 24),

                      // Test Accounts Card
                      const TestAccountsCard(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
