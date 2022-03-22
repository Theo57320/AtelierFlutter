
// ignore_for_file: deprecated_member_use
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class  AuthScreen extends StatefulWidget {
  const AuthScreen({ Key? key }) : super(key: key);

  @override
 _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isSecret = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 30.0
            ),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
                  // ignore: unnecessary_const
                  RichText(
                    text: TextSpan(
                      text :'Bienvenue sur\n'.toUpperCase(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30.0,
                        ),
                      children: [
                        TextSpan(
                          text:'Reunionou\n'.toUpperCase(),
                          style: TextStyle(color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          ),
                          ),
                      ],
                    ),
                  ),
              Form(child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Identifiant',
                  style: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
                  ),
                  SizedBox(height: 10.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Ex: theo.antolini@mail.com',
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
                     SizedBox(height: 10.0),
                     TextFormField(
                       obscureText: _isSecret,
                    decoration: InputDecoration(
                      suffixIcon: InkWell(
                        onTap : () => 
                           setState(() => _isSecret = !_isSecret),
                        child: Icon(
                        !_isSecret 
                        ? Icons.visibility
                        : Icons.visibility_off),
                      ),
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
                     SizedBox(height: 10.0,),
                     RaisedButton(
                       color: Theme.of(context).primaryColor,
                       elevation: 0,
                       padding: EdgeInsets.symmetric(vertical: 15.0),
                       onPressed: () => print('send'),
                       child:Text(
                          'continue'.toUpperCase(),
                          style: TextStyle(
                            color:Colors.white,
                          ),
                        ),
                       ),
                        SizedBox(
                          height: 10.0,
                        ),
                       RaisedButton(
                       color: Theme.of(context).primaryColor,
                       elevation: 0,
                       padding: EdgeInsets.symmetric(vertical: 15.0),
                       onPressed: () =>launch('http://google.com'),
                       child:Text(
                          'Créer un comte'.toUpperCase(),
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
        );
  }
} 