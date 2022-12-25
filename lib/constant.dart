//--------- -----STRINGS-------------------
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const baseUrl = 'http://192.168.43.51:8000/api/';

// user
const userRegisterUrl = '${baseUrl}users/register';
const userLoginUrl = '${baseUrl}login';
const userInfoUrl = '${baseUrl}users/info/';

// expert
const expertRegisterUrl = '${baseUrl}experts/register';
const expertLoginUrl = '${baseUrl}experts/login';
const expertInfoUrl = '${baseUrl}experts/';
const expertsOfConsultation = '${baseUrl}experts/searchByConsultation/';

// --------------Errors-----------

const serverError = 'server error !!';
const someThingWentWront = 'sorry, something went wrong !';
const unauthorized = 'unauthorized !';

// ----------------widgets---------------------

Widget textBoxEdit(String text, TextEditingController textEditingController,
    bool obscureText, IconData ic) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white,
      ),
      child: TextField(
        controller: textEditingController,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          labelText: text,
          prefixIcon: Icon(ic, color: Colors.blue[800]),
        ),
      ),
    ),
  );
}

Widget textBoxEditWithoutPrefixIcon(String text,
    TextEditingController textEditingController, bool obscureText) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white,
      ),
      child: TextField(
        controller: textEditingController,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          labelText: text,
        ),
      ),
    ),
  );
}

Widget button(String text, void Function() event) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 70),
    child: ElevatedButton(
      onPressed: event,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: const BorderSide(color: Colors.blue)),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    ),
  );
}

Widget buttonInverse(String text, void Function() event) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 70),
    child: ElevatedButton(
      onPressed: event,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: const BorderSide(color: Colors.white)),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    ),
  );
}

Widget textButton(String text, void Function() event) {
  return TextButton(
    onPressed: event,
    child: Text(
      text,
      style: TextStyle(color: Colors.blue[600], fontSize: 12),
    ),
  );
}

String date() {
  var now = DateTime.now();
  var formatter = DateFormat('dd MMMM, yyyy');
  return formatter.format(now);
}

Widget doubleTextView(String text1, String text2) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
    margin: const EdgeInsets.symmetric(horizontal: 10),
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.blue[200],
      borderRadius: BorderRadius.circular(15),
    ),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Text(text1,
              style: const TextStyle(color: Colors.black, fontSize: 16)),
          const Text(' : ',
              style: TextStyle(color: Colors.black, fontSize: 16)),
          Text(text2,
              style: const TextStyle(color: Colors.black, fontSize: 16)),
        ],
      ),
    ),
  );
}
