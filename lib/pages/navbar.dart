import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'homepage.dart';
import 'loginpage.dart';



class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.black,
        child: ListView(padding: EdgeInsets.zero, children: [
          UserAccountsDrawerHeader(
              accountName: const Text("Riya Bisht"),
              accountEmail: const Text("manasi.riya2003@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                  child: CircleAvatar(child: Image.asset('images/user.jpg'))),
              decoration: const BoxDecoration(
                  color: Colors.pink,
                  image: DecorationImage(
                      image: AssetImage('images/rightLogo.jpg'),
                      fit: BoxFit.cover))),
          const Divider(
            height: 20,
            thickness: 0.5,
            color: Colors.pink,
          ),
          ListTile(
            leading: const Icon(
              Icons.manage_accounts,
              color: Color.fromARGB(255, 219, 19, 169),
            ),
            title: const Text("Account",
                style: const TextStyle(
                  color: Color.fromARGB(255, 236, 98, 222),
                  fontSize: 20,
                 
                )),
            onTap: () => print("Account Details"),
          ),
          const Divider(
            height: 20,
            thickness: 0.5,
            color: Colors.pink,
          ),
          ListTile(
            leading: const Icon(
              Icons.contacts,
              color: Color.fromARGB(255, 219, 19, 169),
            ),
            title: const Text("Add Contacts",
                style: TextStyle(
                    color: Color.fromARGB(255, 236, 98, 222), fontSize: 20)),
            onTap: () => print("Added Contacts"),
          ),
          const Divider(
            height: 20,
            thickness: 0.5,
            color: Colors.pink,
          ),
          ListTile(
            leading: const Icon(
              Icons.location_city,
              color: Color.fromARGB(255, 219, 19, 169),
            ),
            title: const Text("Locations",
                style: TextStyle(
                    color: Color.fromARGB(255, 236, 98, 222), fontSize: 20)),
            onTap: () => print("Your Location"),
          ),
          const Divider(
            height: 20,
            thickness: 0.5,
            color: Colors.pink,
          ),
          ListTile(
            leading: const Icon(
              Icons.notifications,
              color: Color.fromARGB(255, 219, 19, 169),
            ),
            title: const Text("Notifications",
                style: TextStyle(
                    color: Color.fromARGB(255, 236, 98, 222), fontSize: 20)),
            onTap: () => print(""),
          ),
          const Divider(
            height: 20,
            thickness: 0.5,
            color: Colors.pink,
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
              color: Color.fromARGB(255, 219, 19, 169),
            ),
            title: const Text("Settings",
                style: TextStyle(
                    color: Color.fromARGB(255, 236, 98, 222), fontSize: 20)),
            onTap: () => print("Settings"),
          ),
          const SizedBox(
            height: 190,
          ),
          const Divider(
            height: 20,
            thickness: 0.5,
            color: Colors.pink,
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Color.fromARGB(255, 219, 19, 169),
            ),
            title: const Text("LogOut",
                style: TextStyle(
                    color: Color.fromARGB(255, 236, 98, 222), fontSize: 20)),
      //       onTap: () =>
                        
      //        Navigator.of(context).pushReplacement(
      // MaterialPageRoute(
      //   builder: (context) => LoginPage(),
      // ),
    )

          
          ]),
        );
  }


}
