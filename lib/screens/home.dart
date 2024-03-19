import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_application_1/screens/login.dart';
import 'package:flutter_application_1/screens/user.dart';


class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(  
    context: context,  
    builder: (BuildContext context){ return AlertDialog(
                  title: Text("Do you want to logout?"),
                  actions: [
                    ElevatedButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text("No"),),
                    ElevatedButton(onPressed: ()
                    {
                      signout(context);
                    }, child: Text("Yes"),),
                  ],);});
               // signout(context);
              },
              icon: Icon(Icons.exit_to_app)),
          
        ],
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (BuildContext context, int index) {
            final bool isCircleAvatar = index % 2 == 0;
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: ListTile(
                
                leading: isCircleAvatar
                    ? Container(
                padding: EdgeInsets.all(2), // Adjust the padding as needed for the border width
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black, // Set the color of the border
                    width: 2.0, // Set the width of the border
                  ),
                ),
                child: CircleAvatar(
                 radius: 40,
                  backgroundImage: AssetImage(users[index].image),
                ),
              )
                    : Container(
                        width:90,
                        height: 100,
                         decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black, // Set the color of the border
                    width: 2.0, // Set the width of the border
                  ),
                ),
                        child: Image.asset(users[index].image),
                      ),
                title: Text(
                  users[index].name,
                  style: TextStyle(color: const Color.fromARGB(255, 54, 30, 233)),
                ),
                subtitle: Text(users[index].profession,
                style: TextStyle(color: const Color.fromARGB(255, 97, 9, 3)),),
                trailing: isCircleAvatar
                    ? Text(
                        'Online',
                        style: TextStyle(color: Colors.green),
                      )
                    : Text(
                        'Offline',
                        style: TextStyle(color: Colors.red),
                      ),
              ),
            );
          }),
    );
  }

  signout(BuildContext ctx) async {
    final _sharedPrefs = await SharedPreferences.getInstance();
    await _sharedPrefs.clear();
    Navigator.of(ctx).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx1) => ScreenLogin()), (route) => false);
  }
}
