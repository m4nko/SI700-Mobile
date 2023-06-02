import 'package:app_seu_madeu_sucos/Controller/Requester/UserRequester/UserRequesterBloc.dart';
import 'package:app_seu_madeu_sucos/View/Signup/SignupFormFieldName.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../Controller/Monitor/User/UserMonitorBloc.dart';
import '../../Controller/Monitor/User/UserMonitorEvent.dart';
import '../../Controller/Requester/UserRequester/UserRequesterEvent.dart';
import '../../Model/Client.dart';
import '../../Model/User.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  User user = User();
  Client client = Client();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.green.shade600,
        child: Form(
          key: _formKey,
          child: Container(
            margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
            child: Column(
              children: [
                formTextField(
                  text: SignupFormFieldName.NAME,
                  onSaved: (value) {
                    client.name = value;
                  },
                  inputType: TextInputType.name,
                ),
                formTextField(
                  text: SignupFormFieldName.PHONE,
                  mask:"(##) # ####-####",
                  inputType: TextInputType.phone,
                  onSaved: (value) {
                    client.phone = value;
                  },
                ),
                formTextField(
                  text: SignupFormFieldName.STREET,
                  onSaved: (value) {
                    client.address = value;
                  },
                ),
                formTextField(
                  text: SignupFormFieldName.STREET_NUMBER,
                  mask: "#####",
                  inputType: TextInputType.number,
                  onSaved: (value) {
                    client.address = "${client.address}, $value";
                  },
                ),
                formTextField(
                  text: SignupFormFieldName.NEIGHBOUR,
                  onSaved: (value) {
                    client.address = "${client.address}, $value";
                  },
                ),
                formTextField(
                  text: SignupFormFieldName.CITY,
                  onSaved: (value) {
                    client.address = "${client.address}, $value";
                  },
                ),
                // TODO: Change to dropdown
                formTextField(
                  text: SignupFormFieldName.DISTRICT,
                  onSaved: (value) {
                    client.address = "${client.address}-$value";
                  },
                ),
                formTextField(
                  text: SignupFormFieldName.ZIPCODE,
                  mask: "#####-###",
                  inputType: TextInputType.number,
                  onSaved: (value) {
                    client.address = "${client.address}, $value";
                  },
                ),
                formTextField(
                  text: SignupFormFieldName.EMAIL,
                  inputType: TextInputType.emailAddress,
                  onSaved: (value) {
                    user.email = value;
                  },
                ),
                formPasswordField(),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      formButton("Cadastrar", SignUpAction),
                      formButton("Cancelar", cancelAction),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget formTextField({
      String? text,
      String? mask,
      TextInputType? inputType,
      void Function(String?)? onSaved}) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
          inputFormatters: mask != null
              ? [MaskTextInputFormatter(mask: mask)]
              : [],
          keyboardType: inputType ?? TextInputType.text,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: text,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent)),
            focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red)),
            errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red)),
          ),
          cursorColor: Colors.orange.shade600,
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
          decoration: const InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: 'Senha',
            floatingLabelBehavior: FloatingLabelBehavior.never,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent)),
            focusedErrorBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            errorBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          ),
          cursorColor: Colors.green,
          obscureText: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor, insira uma senha';
            }
            return null;
          },
          onSaved: (value) {
            user.password = value;
          },
        ));
  }

  Widget formButton(String text, void Function() onPressed) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              text == "Cadastrar" ? Colors.orange.shade600 : Colors.grey,
        ),
        onPressed: onPressed,
        child: Padding(
          padding: text == "Cadastrar"
              ? const EdgeInsets.symmetric(vertical: 12, horizontal: 20)
              : const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Text(text),
        ),
      ),
    );
  }

  void SignUpAction() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      user.client = client;
      UserRequesterBloc userRequesterBloc =
          BlocProvider.of<UserRequesterBloc>(context);
      userRequesterBloc.add(CreateUserRequest(user));
    }
  }

  void cancelAction() {
    UserMonitorBloc accessBloc = BlocProvider.of<UserMonitorBloc>(context);
    accessBloc.add(CancelSignUpButtonClick());
  }
}
