//--------- -----STRINGS-------------------
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const baseUrl = 'http://192.168.43.51:8000/api/';

// user
const userRegisterUrl = '${baseUrl}users/register';
const userLoginUrl = '${baseUrl}login';
const userBookedTimes = '${baseUrl}users/bookedTimes';
const flipFavUrl = '${baseUrl}users/flip_favorite';
const rateExpertUrl = '${baseUrl}experts/rate/';

// expert
const expertRegisterUrl = '${baseUrl}experts/register';
const favoriteExpertsUrl = '${baseUrl}favorites';
const searchOnExpertsUrl = '${baseUrl}experts/search/';
const expertProfile = '${baseUrl}experts/show/';
const consultaionExpertsUrl = '${baseUrl}experts/searchByConsultation/';
const expertAvailableTimes = '${baseUrl}experts/available_times/';
const expertBookTime = '${baseUrl}experts/book/';
const filteredSearch =
    '${baseUrl}experts/search/filterByConsultation/'; // {consultation_id}/search_text

// consultation
const consultationsUrl = '${baseUrl}consultations/all';

// --------------Errors-----------

const serverError = 'server error !!';
const someThingWentWront = 'sorry, something went wrong !';
const unauthorized = 'unauthorized !';
const notFound = 'sorry, data not found!';

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

Widget consultationCard(String name, int id, void Function() event) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 50),
    child: GestureDetector(
      onTap: event,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.yellow.shade600,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: Text(
              name,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget userTimeCard(
    String date, String hour, String expertName, void Function() event) {
  return GestureDetector(
    onTap: event,
    child: Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.yellow[800],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            expertName,
            style: const TextStyle(color: Colors.white),
          ),
          const Text(
            '|',
            style: TextStyle(color: Colors.white),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.yellow[100],
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Text(
                  date,
                  style: const TextStyle(color: Colors.black),
                ),
                Text(
                  hour,
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
