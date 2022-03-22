
// ignore_for_file: deprecated_member_use
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class  PasswordScreen extends StatefulWidget {
  PasswordScreen ({ Key? key }) : super(key: key);

  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {},
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 30.0,
          ),
          child: Column(
            children: [
              SizedBox(height: 4.0,
              ),
              RichText(
                    text: TextSpan(
                      text :'Insérer votre\n'.toUpperCase(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30.0,
                        ),
                      children: [
                        TextSpan(
                          text:'mot de passe\n'.toUpperCase(),
                          style: TextStyle(color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          ),
                          ),
                      ],
                    ),
                  ),
                SizedBox(height: 5.0,
                ),
                Form(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Mot de passe',
                  style: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
                  ),
                  SizedBox(height: 10.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      borderSide: BorderSide(
                        color: Colors.grey
                          ),
                        ),
                      ),
                     ),
                     SizedBox(height: 10.0
                     ),
                     RaisedButton(
                       color: Theme.of(context).primaryColor,
                       elevation: 0,
                       padding: EdgeInsets.symmetric(vertical: 15.0),
                       onPressed: () => print('send'),
                       child:Text(
                          'Continue'.toUpperCase(),
                          style: TextStyle(
                            color:Colors.white,
                          ),
                        ),
                       ),
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
}