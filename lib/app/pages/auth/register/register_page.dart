import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fwc_album_app/app/core/ui/styles/text_styles.dart';
import 'package:fwc_album_app/app/core/ui/widgets/button.dart';
import 'package:fwc_album_app/app/pages/auth/register/presenter/register_presenter.dart';
import 'package:fwc_album_app/app/pages/auth/register/view/register_view_impl.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  final RegisterPresenter presenter;

  const RegisterPage({
    required this.presenter,
    super.key,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends RegisterViewImpl {
  final _formKey = GlobalKey<FormState>();

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Container(
                height: 106.82,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bola.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Text(
                'Cadastrar Usuário',
                style: context.textStyles.titleBlack,
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _name,
                      decoration: const InputDecoration(
                        label: Text('Nome completo *'),
                      ),
                      validator: Validatorless.required('Obrigatório'),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _email,
                      decoration: const InputDecoration(
                        label: Text('E-mail *'),
                      ),
                      validator: Validatorless.multiple([
                        Validatorless.required('Obrigatório'),
                        Validatorless.email('E-mail inválido'),
                      ]),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _password,
                      obscureText: true,
                      decoration: const InputDecoration(
                        label: Text('Senha *'),
                      ),
                      validator: Validatorless.multiple([
                        Validatorless.required('Obrigatório'),
                        Validatorless.min(
                            6, 'Campo deve conter pelo menos 6 caractéres'),
                      ]),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _confirmPassword,
                      obscureText: true,
                      decoration: const InputDecoration(
                        label: Text('Confirma senha *'),
                      ),
                      validator: Validatorless.multiple([
                        Validatorless.required('Obrigatório'),
                        Validatorless.min(
                            6, 'Campo deve conter pelo menos 6 caractéres'),
                        Validatorless.compare(
                            _password, 'confirma senha diferente de senha'),
                      ]),
                    ),
                    const SizedBox(height: 20),
                    Button.primary(
                      label: 'Cadastrar',
                      width: MediaQuery.of(context).size.width * .9,
                      onPressed: () {
                        log('passou por aqui!!!');

                        final isFormValid =
                            _formKey.currentState?.validate() ?? false;

                        if (isFormValid) {
                          showLoader();

                          widget.presenter.register(
                            name: _name.text,
                            email: _email.text,
                            password: _password.text,
                            confirmPassword: _confirmPassword.text,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
