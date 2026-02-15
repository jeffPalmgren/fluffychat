import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:matrix/matrix.dart';
import 'package:fluffychat/config/app_config.dart';
import 'package:fluffychat/pages/login/login.dart';

import 'package:fluffychat/widgets/matrix.dart';

class LoginLoaderPage extends StatelessWidget {
  const LoginLoaderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Client>(
      future: Matrix.of(context).getLoginClient(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return Scaffold(
            body: Center(
              child: Text('Failed to initialize client: ${snapshot.error}'),
            ),
          );
        }
        final client = snapshot.data!;
        final rawUrl = AppConfig.defaultHomeserver.trim().toLowerCase();
        final homeserver = rawUrl.startsWith('http')
          ? Uri.parse(rawUrl)
          : Uri.https(rawUrl, '');
        client.homeserver = homeserver;

        return Login(client: client);
      },
    );
  }
}
