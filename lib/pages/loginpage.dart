import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'homepage.dart';
import 'package:email_validator/email_validator.dart';
import 'package:wc_form_validators/wc_form_validators.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final User? user = _auth.currentUser;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

enum RegistrationStatus {
  pending,
  completed,
  failed,
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late RegistrationStatus regStatus = RegistrationStatus.pending;
  late String _userEmail;

  @override
  Widget build(BuildContext context) {
    
    return  MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              const Padding(
                padding: EdgeInsets.all(10),
                child: Image(image: AssetImage('images/zoomeLogo.jpg'),
                  
                )
              )
          , //Image.asset
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  controller: _emailController,
                  validator: (value) => EmailValidator.validate(value!)
                      ? null
                      : "Please enter a valid email",
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.white),
                    border:OutlineInputBorder(
                      
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white)
                    ) ,
                   focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Color.fromARGB(255, 248, 150, 183))
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Color.fromARGB(255, 248, 150, 183))
                    ),
                    labelText: 'Enter email id',
                    labelStyle: GoogleFonts.lato(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  controller: _passwordController,
                  decoration: InputDecoration(
                    
                    border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white)
                    ) ,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Color.fromARGB(255, 248, 150, 183))
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Color.fromARGB(255, 248, 150, 183))
                    ) ,
                    labelText: 'Enter password',
                    labelStyle: GoogleFonts.lato(
                      fontSize: 25,
                      color: Colors.white,
                      
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  validator: Validators.compose([
                    Validators.required('Password is required'),
                    Validators.patternString(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                        'Invalid Password')
                  ]),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 10),
                  child: Row(
                    children: [
  


                      ElevatedButton(
                        onPressed: () async {
                          {
                            _register();
                          }
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0))),
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(99, 224, 23, 201)),
                              
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "Register",
                                style: GoogleFonts.lato(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(
                              Icons.login,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          { 
                  _signInWithEmailAndPassword();
                          }
                        },
                        style: ButtonStyle(
                          
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0))),
                          backgroundColor: MaterialStateProperty.all(
                       Color.fromARGB(99, 224, 23, 201)),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "LogIn",
                                
                                style: GoogleFonts.lato(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(
                              Icons.login,
                            ),

                          ],
                        ),
                      ),

                      
                      

                        
                      
                    ],
                  )),
             
            ]),
          ),
        )));
  }
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _register() async {
    final User? user = (await _auth.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ))
        .user;
    if (user != null) {
      setState(() {
        regStatus = RegistrationStatus.completed;
        _userEmail = user.email!;
      });
    } else {
      setState(() {
        regStatus = RegistrationStatus.failed;
      });
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      
      
      // ignore: unnecessary_null_comparison
      content: Text(regStatus == RegistrationStatus.pending
          ? ' '
          : (regStatus == RegistrationStatus.completed
              ? 'Successfully registered' + _userEmail
              : 'Registration failed')),
    ));
  

    
  }

  void _signInWithEmailAndPassword() async {
     Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  final User? user = (await _auth.signInWithEmailAndPassword(
    email: _emailController.text,
    password: _passwordController.text,
  )).user;
  
  if (user != null) {
    setState(() {
      regStatus = RegistrationStatus.completed;
      _userEmail = user.email!;
    });
  } else {
    setState(() {
      regStatus = RegistrationStatus.failed;
    });
  }
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.white,
      // ignore: unnecessary_null_comparison
      content: Text(regStatus == RegistrationStatus.pending
          ? ' '
          : (regStatus == RegistrationStatus.completed
              ? 'Successfully LogIn' + _userEmail 
              : 'LogIn failed')),
    ));
     


     
}

}