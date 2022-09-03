import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _bioController = TextEditingController();
  final _usernameController = TextEditingController();
  // vai armazenar a imagem p/ perfil selecionada pelo usuário.
  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  /// método q seleciona uma imagem para ser usada como ft de perfil.
  void selectImage() async {
    Uint8List? image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Flexible(child: Container()),
                // PACOTE PRA USAR SVG
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/ic_instagram.svg',
                      color: primaryColor.withOpacity(0.8),
                      height: 64,
                    ),
                    // const SizedBox(width: 12),
                    const Text('fake'),
                  ],
                ),
                const SizedBox(height: 64),
                // CIRCULAR PRA PEGAR FT DE PERFIL
                Stack(
                  children: [
                    _image != null
                        //se houver mostra a propria img selecionada.
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(_image!),
                          )
                        // se n houver imagem selecionada ainda (o _image é null),
                        //  mostra a img da net;
                        : const CircleAvatar(
                            radius: 64,
                            backgroundImage: NetworkImage(
                              'https://t4.ftcdn.net/jpg/02/15/84/43/360_F_215844325_ttX9YiIIyeaR7Ne6EaLLjMAmy4GvPC69.jpg',
                            ),
                          ),
                    Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(Icons.add_a_photo),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // USERNAME
                TextFieldInput(
                  controller: _usernameController,
                  hintText: 'Digite um nome de usuário',
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 24),
                // EMAIL
                TextFieldInput(
                  controller: _emailController,
                  hintText: 'Digite o email',
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 24),
                // SENHA
                TextFieldInput(
                  controller: _passwordController,
                  hintText: 'Digite a senha',
                  textInputType: TextInputType.visiblePassword,
                  isPass: true,
                ),
                const SizedBox(height: 24),
                // BIO
                TextFieldInput(
                  controller: _bioController,
                  hintText: 'Digite uma biografia',
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 24),
                // BOTAO DE LOGIN
                InkWell(
                  onTap: () async {
                    // Método que faz a criação do usuário
                    String res = await AuthMethods().signUpUser(
                      email: _emailController.text,
                      password: _passwordController.text,
                      username: _usernameController.text,
                      bio: _bioController.text,
                      // PROX COISA, CRIAR UPLOAD DA FT DE PERFIL
                      // file: ,
                    );
                    debugPrint(res);
                  },
                  child: Container(
                    width: double.infinity,
                    // CENTRALIZAR O CHILD NO CONTAINER
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      color: blueColor,
                    ),
                    child: const Text('Fazer Login'),
                  ),
                ),
                const SizedBox(height: 12),
                // Flexible(child: Container()),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: const Text(
              'ñ tem conta? fodase  ',
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: const Text(
                'zoas, aperta aqui pra criar.',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
