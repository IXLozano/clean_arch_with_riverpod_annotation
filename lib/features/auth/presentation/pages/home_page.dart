import 'package:clean_architecture_example/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_architecture_example/features/auth/presentation/bloc/auth_event.dart';
import 'package:clean_architecture_example/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [IconButton(onPressed: () => context.read<AuthBloc>().add(LogoutEvent()), icon: Icon(Icons.logout))],
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthAuthenticated) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_outline, size: 100, color: Colors.blue),
                  SizedBox(height: 24.0),
                  Text('Welcome', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16.0),
                  Text('Email: ${state.user.email}'),
                  SizedBox(height: 16.0),
                  Text('Name: ${state.user.name}'),
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
