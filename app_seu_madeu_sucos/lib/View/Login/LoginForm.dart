import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Controller/Monitor/User/UserMonitorBloc.dart';
import '../../Controller/Monitor/User/UserMonitorEvent.dart';
import '../../Data/UserData.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
        child: Column(
          children: [
            formEmailField(),
            formPasswordField(),
            forgotMyPasswordButton(),
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  formButton("Entrar", loginAction),
                  formButton("Cadastre-se", signUpAction),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget formEmailField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              style: const TextStyle(height: BorderSide.strokeAlignCenter),
              decoration: const InputDecoration(
                labelText: 'Email',
                floatingLabelBehavior: FloatingLabelBehavior.never,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide.none
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide.none
                ),     
              ),
              showCursor: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira um email';
                }
                return null;
              },
              onSaved: (value) {
                UserData.instance.user.email = value!;
              },
            ),
          )),
    );
  }

  Widget formPasswordField() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextFormField(
          style: const TextStyle(height: BorderSide.strokeAlignCenter),
          decoration: const InputDecoration(
            labelText: 'Senha',
            floatingLabelBehavior: FloatingLabelBehavior.never,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide.none
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide.none
            ),     
          ),
          showCursor: false,
          obscureText: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor, insira uma senha';
            }
            return null;
          },
          onSaved: (value) {
            UserData.instance.user.password = value!;
          },
        ),
      ),
    );
  }

  Widget formButton(String text, void Function() onPressed) {
    return ElevatedButton(
        onPressed: onPressed,
        child: Padding(padding: const EdgeInsets.all(10), child: Text(text)));
  }


  Widget forgotMyPasswordButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextButton(
          onPressed: () {
            // TODO: Realizar ação de esqueci minha senha
          },
          child: const Text("Esqueci minha senha"),
        ),
      ]
    );
  }

  void loginAction() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      UserMonitorBloc accessBloc = BlocProvider.of<UserMonitorBloc>(context);
      accessBloc.add(LogInButtonClick());
    }
  }

  void signUpAction(){
    UserMonitorBloc accessBloc = BlocProvider.of<UserMonitorBloc>(context);
    accessBloc.add(IWantToSignUpButtonClick());
  }
}
