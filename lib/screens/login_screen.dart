import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/socket_service.dart';

import 'package:chat_app/helpers/show_alert.dart';

import 'package:chat_app/widgets/custom_input.dart';
import 'package:chat_app/widgets/login/labels.dart';
import 'package:chat_app/widgets/login/login_button.dart';
import 'package:chat_app/widgets/login/logo.dart';

import 'package:chat_app/global/chat_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: ChatColors.primaryLight,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Logo(title: 'Core Chat'),
                _Form(),
                const Labels(
                  route: 'register',
                  question: '¿No tienes cuenta?',
                  actionText: '¡Registrate ahora!',
                ),
                const Text(
                  'Terminos y condiciones de uso',
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return Container(
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            keyboardType: TextInputType.text,
            textController: passCtrl,
            isPassword: true,
          ),
          LoginButton(
            text: 'Ingrese',
            onPressed: authService.authenticating
                ? null
                : () async {
                    // Ocultar teclado al dar click
                    FocusScope.of(context).unfocus();

                    // Inicia autenticación
                    final loginOk = await authService.login(
                        emailCtrl.text.trim(), passCtrl.text.trim());

                    if (loginOk) {
                      socketService.connect();
                      Navigator.pushReplacementNamed(context, 'home');
                    } else {
                      showAlert(context, 'Login incorrecto',
                          'Revise sus credenciales');
                    }
                  },
          ),
        ],
      ),
    );
  }
}
