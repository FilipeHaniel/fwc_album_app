import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fwc_album_app/app/core/ui/styles/button_styles.dart';
import 'package:fwc_album_app/app/core/ui/styles/colors_app.dart';
import 'package:fwc_album_app/app/core/ui/styles/text_styles.dart';
import 'package:fwc_album_app/app/core/ui/widgets/button.dart';
import 'package:fwc_album_app/app/pages/auth/login/presenter/login_presenter.dart';
import 'package:fwc_album_app/app/pages/auth/login/view/login_view_impl.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  final LoginPresenter presenter;

  const LoginPage({
    required this.presenter,
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends LoginViewImpl {
  final _formKey = GlobalKey<FormState>();

  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.primary,
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background_login.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate.fixed(
                  [
                    SizedBox(
                      height: MediaQuery.of(context).size.height *
                          (MediaQuery.of(context).size.width > 350 ? .3 : .25),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Center(
                        child: Text(
                          'login',
                          style: context.textStyles.titleWhite,
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _emailEC,
                      decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        label: Text('E-mail'),
                      ),
                      validator: Validatorless.multiple([
                        Validatorless.required('Obrigatório'),
                        Validatorless.email('inválido'),
                      ]),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordEC,
                      decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        label: Text('Senha'),
                      ),
                      obscureText: true,
                      validator: Validatorless.multiple([
                        Validatorless.required('Obrigatório'),
                        Validatorless.min(
                            6, 'deve conter no mínimo 6 caracteres'),
                      ]),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Text(
                        'Esqueceu a senha?',
                        style:
                            context.textStyles.textSecondaryFontMedium.copyWith(
                          color: context.colors.yellow,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Button(
                      label: 'Entrar',
                      style: context.buttonStyles.yellowButton,
                      labelStyle: context
                          .textStyles.textSecondaryFontExtraBoldPrimaryColor,
                      width: MediaQuery.of(context).size.width * .9,
                      onPressed: () {
                        final valid =
                            _formKey.currentState?.validate() ?? false;

                        if (valid) {
                          showLoader();

                          widget.presenter
                              .login(_emailEC.text, _passwordEC.text);
                        }
                      },
                    ),
                  ],
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    const Spacer(),
                    Text.rich(
                      TextSpan(
                        text: 'Não possui uma conta?',
                        children: [
                          TextSpan(
                            text: ' Cadastre-se',
                            style: context.textStyles.textSecondaryFontMedium
                                .copyWith(color: context.colors.yellow),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.of(context)
                                  .pushNamed('/auth/register'),
                          ),
                        ],
                      ),
                      style: context.textStyles.textSecondaryFontMedium
                          .copyWith(color: Colors.white),
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
