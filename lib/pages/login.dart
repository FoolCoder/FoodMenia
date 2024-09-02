import 'package:flutter/material.dart';
import 'package:flutter_practice_app/services/auth_service.dart';
import 'package:status_alert/status_alert.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _nameEditingController =
      TextEditingController(text: 'emilys');
  final TextEditingController _pswdEditingController =
      TextEditingController(text: 'emilyspass');

  String? username, password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SafeArea(child: _buildUI()),
    );
  }

  Widget _buildUI() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [_title(), _loginForm()],
      ),
    );
  }

  Widget _title() {
    return const Text(
      'Receip Book',
      style: TextStyle(
          fontSize: 35, fontWeight: FontWeight.w300, color: Colors.red),
    );
  }

  Widget _loginForm() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.9,
      height: MediaQuery.sizeOf(context).height * 0.3,
      child: Form(
          key: _loginFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _nameEditingController,
                onSaved: (value) {
                  setState(() {
                    username = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter a username';
                  }
                  return null;
                },
                decoration: const InputDecoration(hintText: 'Username'),
              ),
              TextFormField(
                controller: _pswdEditingController,
                onSaved: (value) {
                  setState(() {
                    password = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.length < 5) {
                    return 'Enter a password';
                  }
                  return null;
                },
                obscureText: true,
                decoration: const InputDecoration(hintText: 'Password'),
              ),
              _loginButton(),
            ],
          )),
    );
  }

  Widget _loginButton() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.6,
      child: ElevatedButton(
          onPressed: () async {
            if (_loginFormKey.currentState?.validate() ?? false) {
              username = _nameEditingController.text;
              password = _pswdEditingController.text;
              bool result = await AuthService().login(username!, password!);
              if (result) {
                Navigator.pushReplacementNamed(context, 'home');
              } else {
                StatusAlert.show(
                  // ignore: use_build_context_synchronously
                  context,
                  duration: const Duration(seconds: 2),
                  title: 'Login Failed',
                  subtitle: 'Please try again',
                  configuration: const IconConfiguration(icon: Icons.error),
                  maxWidth: 260,
                );
              }
            }
          },
          child: const Text('Login')),
    );
  }
}
