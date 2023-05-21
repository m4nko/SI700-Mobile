import 'package:flutter/material.dart';

import 'Signup/SignupFormFieldName.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Card(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: Column(
                children: [
                  formTextField(SignupFormFieldName.NAME, textFieldOnSaved),
                  formTextField(SignupFormFieldName.PHONE, textFieldOnSaved),
                  formTextField(SignupFormFieldName.STREET, textFieldOnSaved),
                  formTextField(
                    SignupFormFieldName.STREET_NUMBER, textFieldOnSaved,
                  ),
                  formTextField(SignupFormFieldName.NEIGHBOUR, textFieldOnSaved),
                  formTextField(SignupFormFieldName.CITY, textFieldOnSaved),
                  formTextField(SignupFormFieldName.DISTRICT, textFieldOnSaved),
                  formTextField(SignupFormFieldName.ZIPCODE, textFieldOnSaved),
                  formTextField(SignupFormFieldName.EMAIL, textFieldOnSaved),
                  formPasswordField(),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        formButton("Salvar", (){}), 
                        formButton("Voltar", (){
                          Navigator.pop(context);
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formTextField(String text, void Function(String?) onSaved) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
          decoration: InputDecoration(labelText: text),
          cursorColor: Colors.green,
          // validator: (value) {
          //   if (value == null || value.isEmpty) {
          //     return 'Por favor, insira seu ${text.toLowerCase()}';
          //   }
          //   return null;
          // },
          onSaved: onSaved,
        ));
  }

  Widget formPasswordField() {
    return Container(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
          decoration: const InputDecoration(labelText: 'Senha'),
          cursorColor: Colors.green,
          obscureText: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor, insira uma senha';
            }
            return null;
          },
          onSaved: (value) {
            //LoginInfo.instance.setPassword(value!);
          },
        ));
  }

  Widget formButton(String text, void Function() onPressed) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: text == "Salvar" ? Colors.green : Colors.red,
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Text(text),
        ),
      ),
    );
  }

  void textFieldOnSaved(String? value) {}
}
