import 'package:clean_architecture_example/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_architecture_example/features/auth/presentation/bloc/auth_event.dart';
import 'package:clean_architecture_example/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  void _onLoginButtonPressed() {
    if (_formKey.currentState!.validate()) {
      // Trigger login event
      context.read<AuthBloc>().add(
        LoginEvent(email: _emailController.text.trim(), password: _passwordController.text.trim()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return Padding(
            padding: const EdgeInsetsGeometry.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(Icons.lock_outline, size: 80.0, color: Colors.blue),
                  SizedBox(height: 40.0),
                  // Email field
                  TextFormField(
                    controller: _emailController,
                    enabled: !isLoading,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      label: Text('Email'),
                      border: OutlineInputBorder(),
                      prefix: Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0),
                  // Password Field
                  TextFormField(
                    controller: _passwordController,
                    enabled: !isLoading,
                    obscureText: true,
                    decoration: InputDecoration(
                      label: Text('Password'),
                      border: OutlineInputBorder(),
                      prefix: Icon(Icons.lock),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Minimum length is 6';
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: isLoading ? null : _onLoginButtonPressed,
                    style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 16.0)),
                    child: isLoading
                        ? SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2.0))
                        : Text('Login'),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showMaterialBanner(
              MaterialBanner(
                content: Text(state.message),
                backgroundColor: Colors.redAccent,
                actions: [
                  TextButton(
                    onPressed: () => ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
                    child: Text('DISMISS', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
