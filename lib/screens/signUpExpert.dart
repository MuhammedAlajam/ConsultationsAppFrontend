import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget buildTextWithTextField(String text, bool obs) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        text,
        style: TextStyle(
          color: Colors.teal.shade900,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 10),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                blurRadius: 6,
                offset: Offset(0, 2),
              )
            ]),
        height: 40,
        child: TextField(
          obscureText: obs,
          style: const TextStyle(color: Colors.black87),
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14),
          ),
        ),
      )
    ],
  );
}

Widget buildSignUpButton() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 25),
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.teal.shade100),
      onPressed: () {},
      child: Text(
        'Sign up',
        style:
            TextStyle(color: Colors.teal.shade900, fontWeight: FontWeight.bold),
      ),
    ),
  );
}

class SignUpExpertScreen extends StatefulWidget {
  const SignUpExpertScreen({super.key});

  @override
  State<SignUpExpertScreen> createState() => _SignUpExpertScreenState();
}

class _SignUpExpertScreenState extends State<SignUpExpertScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Colors.teal,
                    ],
                  ),
                ),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 100,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Signing Up !',
                        style: TextStyle(
                            color: Colors.teal.shade700,
                            fontSize: 50,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 60),
                      buildTextWithTextField('user name', false),
                      const SizedBox(height: 10),
                      buildTextWithTextField('first name', false),
                      const SizedBox(height: 10),
                      buildTextWithTextField('last name', false),
                      const SizedBox(height: 10),
                      buildTextWithTextField('country', false),
                      const SizedBox(height: 10),
                      buildTextWithTextField('city', false),
                      const SizedBox(height: 10),
                      buildTextWithTextField('phone number', false),
                      const SizedBox(height: 10),
                      buildTextWithTextField('password', true),
                      const SizedBox(height: 10),
                      buildTextWithTextField('Description', false),
                      const SizedBox(height: 10),
                      buildTextWithTextField('session duration', false),
                      const SizedBox(height: 10),
                      buildTextWithTextField('session price', false),
                      const SizedBox(height: 80),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.teal.shade900),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              'select your consultations : ',
                              style: TextStyle(
                                color: Colors.teal.shade900,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 40),
                            CheckboxListTile(
                              onChanged: (bool? value) {},
                              title: Text(
                                'Medical',
                                style: TextStyle(
                                  color: Colors.teal.shade900,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              activeColor: Colors.teal.shade900,
                              value: true,
                            ),
                            CheckboxListTile(
                              onChanged: (bool? value) {},
                              title: Text(
                                'Psychological',
                                style: TextStyle(
                                  color: Colors.teal.shade900,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              activeColor: Colors.teal.shade900,
                              value: true,
                            ),
                            CheckboxListTile(
                              onChanged: (bool? value) {},
                              title: Text(
                                'Familial',
                                style: TextStyle(
                                  color: Colors.teal.shade900,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              activeColor: Colors.teal.shade900,
                              value: true,
                            ),
                            CheckboxListTile(
                              onChanged: (bool? value) {},
                              title: Text(
                                'Buisness',
                                style: TextStyle(
                                  color: Colors.teal.shade900,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              activeColor: Colors.teal.shade900,
                              value: true,
                            ),
                            CheckboxListTile(
                              onChanged: (bool? value) {},
                              title: Text(
                                'Vocational',
                                style: TextStyle(
                                  color: Colors.teal.shade900,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              activeColor: Colors.teal.shade900,
                              value: true,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      buildSignUpButton(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
