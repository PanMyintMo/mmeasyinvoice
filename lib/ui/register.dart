import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mmeasyInvoice/app_router.dart';
import 'package:mmeasyInvoice/dependency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/util/home_route.dart';
import 'package:mmeasyInvoice/auth/home_module.dart';
import 'package:mmeasyInvoice/util/common/share_util.dart';
import 'package:mmeasyInvoice/state/post/cubit/auth_cubit.dart';
import 'package:mmeasyInvoice/util/common/header_widget.dart';
import 'package:mmeasyInvoice/data/data_request_model/login_request_model.dart';
import 'package:mmeasyInvoice/data/data_request_model/register_request_model.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isRegisterMode = false;
  bool isLoginMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AuthCubit(getIt.call()),
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            final loading = state is AuthLoading;

            if (state is AuthSuccess) {}

            if (state is LoginSuccess) {
              // logger.e('Login Success ${state.utype}');
              SharePreferenceService.saveUserRole(state.utype);

              SharePreferenceService().saveUserName(state.response.name);
              SharePreferenceService().saveUserEmail(state.response.email);

              SharePreferenceService().saveToken(state.response.token);

              AppRouter.changeRoute<HomeModule>(
                HomeRoute.root,
                isReplaceAll: true,
              );
            }

            return RegisterForm(
              isLoading: loading,
              message: state is AuthFailed ? state.toString() : '',
              isRegisterMode: isRegisterMode,
              isLoginMode: isLoginMode,
              onRegister: () {
                setState(() {
                  isRegisterMode = true;
                  isLoginMode = false;
                });
              },
              onLogin: () {
                setState(() {
                  isRegisterMode = false;
                  isLoginMode = true;
                });
              },
            );
          },
        ),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  final bool isLoading;
  final String message;
  final bool isRegisterMode;
  final bool isLoginMode;
  final VoidCallback onRegister;
  final VoidCallback onLogin;

  const RegisterForm({
    super.key,
    required this.isLoading,
    required this.message,
    required this.isRegisterMode,
    required this.isLoginMode,
    required this.onRegister,
    required this.onLogin,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final formKey = GlobalKey<FormState>();
  var name = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var passwordConfirmation = TextEditingController();
  final bool _obscureText = true;
  bool checkboxValue = false;

  String? _validatePasswordConfirmation() {
    final String passwordValue = password.text;
    final String confirmPasswordValue = passwordConfirmation.text;

    if (passwordValue != confirmPasswordValue) {
      return 'Password and confirm password do not match.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 150,
              child: HeaderWidget(150, false, Icons.account_circle_rounded),
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              'Myanmar Easy Invoice',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 50),
            if (widget.isRegisterMode)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: TextFormField(
                  controller: name,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username!';
                    }
                    return null;
                  },
                ),
              ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: TextFormField(
                controller: email,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: TextFormField(
                controller: password,
                obscureText: !_obscureText,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
            ),
            const SizedBox(height: 10),
            if (widget.isRegisterMode)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: TextFormField(
                  controller: passwordConfirmation,
                  obscureText: !_obscureText,
                  decoration:
                      const InputDecoration(labelText: 'Confirm Password'),
                ),
              ),
            const SizedBox(height: 10),
            if (widget.isRegisterMode)
              FormField<bool>(
                builder: (state) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: checkboxValue,
                            onChanged: (value) {
                              setState(() {
                                checkboxValue = value!;
                                state.didChange(value);
                              });
                            },
                          ),
                          const Text(
                            "I accept all terms and conditions.",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          state.errorText ?? '',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontSize: 12,
                          ),
                        ),
                      )
                    ],
                  );
                },
                validator: (value) {
                  if (!checkboxValue) {
                    return 'You need to accept terms and conditions';
                  } else {
                    return null;
                  }
                },
              ),
            const SizedBox(height: 10),
            if (widget.isRegisterMode && !widget.isLoginMode)
              TextButton(
                  onPressed: () {
                    final registerRequestModel = RegisterRequestModel(
                        name: name.text.toString(),
                        email: email.text.toString(),
                        password: password.text.toString(),
                        password_confirmation:
                            passwordConfirmation.text.toString());

                    context.read<AuthCubit>().register(registerRequestModel);
                  },
                  child: const Text('Register')),
            Column(
              children: [
                if (widget.isLoginMode && !widget.isRegisterMode)
                  ElevatedButton(
                    onPressed: () {
                      final loginRequestModel = LoginRequestModel(
                        email: email.text.toString(),
                        password: password.text.toString(),
                      );

                      context.read<AuthCubit>().login(loginRequestModel);
                    },
                    child: const Text('Login'),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.isLoginMode
                        ? Center(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  const TextSpan(
                                    text: "Don't have an account?",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  TextSpan(
                                    text: ' Sign up!',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = widget.onRegister,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Center(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  const TextSpan(
                                    text: "Already have an account",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  TextSpan(
                                    text: ' Sign In!',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = widget.onLogin,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ],
                ),
              ],
            ),
            if (widget.isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
            if (widget.message.isNotEmpty)
              Text(
                widget.message,
                style: TextStyle(
                  fontSize: 18,
                  color: widget.message.startsWith('Success')
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            const SizedBox(height: 10),
            if (widget.isRegisterMode)
              const Text(
                "Or create an account using social media",
                style: TextStyle(color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }
}
