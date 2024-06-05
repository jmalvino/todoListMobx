import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store{

  // _LoginStore(){
  //   autorun((_){
  //     print("E-mail ${email}");
  //     print("Pass ${password}");
  //   });
  // }

  @observable
  String email = "";
  @action
  void setEmail(String value) => email = value;

  @observable
  String password = "";
  @action
  void setPassword(String value) => password = value;

  @observable
  bool passwordVisible = false;
  @action
  void togglePasswordVisibility() => passwordVisible = !passwordVisible;

  @observable
  bool loading = false;

  @observable
  bool loggedIn = false;

  @action
  Future<void> login() async{
    loading = true;
    await Future.delayed(const Duration(seconds: 2));
    loading = false;
    loggedIn = true;
    email = "";
    password = "";
  }

  @action
  void logout(){
    loggedIn = false;
  }

  @computed
  bool get isEmailValid => RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email);

  @computed
  bool get isPassValid => password.length > 4;

  @computed
  Function? get loginPressed => ( isEmailValid && isPassValid && !loading)? login : null;

}