import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/screens/home.dart';

class ScreenLogin extends StatefulWidget {
  ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final _unsernameController = TextEditingController();

  final _passwordController = TextEditingController();
 // bool _isDataMatched = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Green lily.jpg'), 
            fit: BoxFit.fitHeight,
              ),
            ),
          ),
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
               
                TextFormField(
                  controller: _unsernameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Username',
                  ),
                  validator: (value) {
                    //if (_isDataMatched) {
                    //  return null;
                    //} else {
                    //  return 'Error';
                    //}
                    if (value == null || value.isEmpty) {
                      return 'Enter your Username';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                  
                ),
               
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Password',
                  ),
                  validator: (value) {
                    //if (_isDataMatched) {
                    //   return null;
                    //} else {
                    // return 'Error';
                    // }
                    if (value == null || value.isEmpty) {
                      return 'Enter your Password';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Visibility(
                //       visible: !_isDataMatched,
                //       child: Text(
                //         'Username and password does not match',
                //         style: TextStyle(color: Colors.red),
                //       ),
                //     ),
                    ElevatedButton.icon(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          checkLogin(context);
                        } else {
                          print('Data empty');
                        }
                        ;

                        //checkLogin(context);
                      },
                      icon: const Icon(Icons.check),
                      label: const Text('Login'),
                    ),
                //  ],
                //),
              ],
            ),
          ),
        ),
      ),
        ],
      ),
    );
    
  }

  void checkLogin(BuildContext ctx) async {
    final _userName = _unsernameController.text;
    final _password = _passwordController.text;
    if (_userName == _password) {
      print('Username and password match');
      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(content: Text('Username and password match')));
      //go to home
      final _sharedPrefs = await SharedPreferences.getInstance();
      await _sharedPrefs.setBool(SAVE_KEY_NAME, true);
      Navigator.of(ctx)
          .pushReplacement(MaterialPageRoute(builder: (ctx1) => ScreenHome()));
    } else {
      final _errorMessage = 'Username password does not match.';
      print('Username and password does not match');
      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(content: Text(_errorMessage)));
    }
  }
}
