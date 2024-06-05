import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_mobx/screens/list_screen.dart';
import 'package:todo_mobx/stores/login_store.dart';
import 'package:todo_mobx/widgets/custom_icon_button.dart';
import 'package:todo_mobx/widgets/custom_text_field.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {
  late LoginStore loginStore;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late ReactionDisposer disposer;

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    loginStore = Provider.of<LoginStore>(context);
    disposer = autorun((_){
      if(loginStore.loggedIn){
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const ListScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple,
        body: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(32),
          color: Colors.deepPurple,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 16,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Observer(builder: (_){
                    return CustomTextField(
                      controller: emailController,
                      hint: "E-mail",
                      prefix: Icon(Icons.account_circle),
                      onChanged: loginStore.setEmail,
                      enabled: !loginStore.loading,
                    );
                  }),
                  SizedBox(height: 15),
                  Observer(builder: (_) {
                    return CustomTextField(
                      controller: passwordController,
                      hint: "Senha",
                      obscure: !loginStore.passwordVisible,
                      prefix: Icon(Icons.account_circle),
                      onChanged: loginStore.setPassword,
                      enabled: !loginStore.loading,
                      suffix: CustomIconButton(
                        radius: 32,
                        iconData: loginStore.passwordVisible ? Icons.visibility : Icons.visibility_off ,
                        onTap: loginStore.togglePasswordVisibility,
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 16,
                  ),
                  Observer(
                    builder: (_) => SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        onPressed: () async{
                          await loginStore.loginPressed?.call();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(32))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: loginStore.loading ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          ) : const Text("Login"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    disposer();
    super.dispose();
  }
}
