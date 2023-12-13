import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:token_based_authentication/config/providers/auth_provider.dart';
import 'package:token_based_authentication/config/providers/router_provider.dart';
import 'package:token_based_authentication/services/auth_service.dart';

class LoginScreen extends ConsumerWidget {
  final AuthService _authService = AuthService();
  final isLoadingProvider = StateProvider<bool>((ref) => false);

  LoginScreen({super.key});

  void _login(BuildContext context, WidgetRef ref) {
    ref.read(isLoadingProvider.notifier).state = true;
    String username = 'user';
    String password = 'pass';

    _authService
      .login(username, password)
      .then((token) {
        print("Login bem-sucedido: $token");

        ref.read(authProvider.notifier).setState(true);
        ref.read(routerProvider).go('/');
      })
      .onError((error, stackTrace) {
        print(error);
      }).whenComplete(() => ref.read(isLoadingProvider.notifier).state = false);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(isLoadingProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Por favor, faça login"),
            const Padding(padding: EdgeInsets.only(top: 10)),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.blue),
                padding: MaterialStatePropertyAll(EdgeInsets.all(10.0)),
                fixedSize: MaterialStatePropertyAll(Size(100, 50))
              ),
              onPressed: isLoading ? null : () => _login(context, ref),
              child: isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}
