import 'package:consultations/constant.dart';
import 'package:consultations/main.dart';
import 'package:consultations/screens/experts.dart';
import 'package:consultations/screens/loading.dart';
import 'package:consultations/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/expert.dart';

class ExpertProfileScreen extends StatefulWidget {
  const ExpertProfileScreen({super.key});

  @override
  State<ExpertProfileScreen> createState() => _ExpertProfileScreenState();
}

class _ExpertProfileScreenState extends State<ExpertProfileScreen> {
  late Map<String, dynamic> data;
  String consultations = '';
  bool rated = false;
  bool isFavorite = false;
  double rate = 0;

  @override
  Widget build(BuildContext context) {
    data = {
      'first_name': 'Muhammed',
      'last_name': 'Alajam',
      'country': 'Syria',
      'city': 'Damascus',
      'description': '10 years experience in competitve programming',
      'phone_number': '96336158478',
      'consultations': ['Medical', 'Business'],
      'rate': '4.5',
      'hourly_rate': '15',
      'available_times': 'later',
      'is_favorite': true,
    };

    List<String> consultationsList = data['consultations'] as List<String>;
    consultations = '';
    for (int i = 0; i < consultationsList.length; i++) {
      consultations = consultations + consultationsList.elementAt(i).toString();

      consultations =
          '$consultations ${((i + 1) == consultationsList.length) ? '.' : ', '}';
    }

    return Scaffold(
      backgroundColor: Colors.blue[600],
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.17),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: Colors.blue[900],
                    borderRadius: BorderRadius.circular(50)),
                child: Row(
                  children: [
                    SizedBox(
                      height: 115,
                      width: 115,
                      child: Stack(
                        clipBehavior: Clip.none,
                        fit: StackFit.expand,
                        children: [
                          const CircleAvatar(
                            backgroundImage: AssetImage("images/me.jpg"),
                          ),
                          Positioned(
                              bottom: 0,
                              right: -25,
                              height: 20,
                              child: RawMaterialButton(
                                onPressed: () {
                                  // TODO add to or remove from  favorite
                                  setState(() {
                                    isFavorite = !isFavorite;
                                  });
                                },
                                elevation: 2.0,
                                fillColor: Colors.white,
                                shape: const CircleBorder(),
                                child: Icon(
                                  (isFavorite ? Icons.person_add : Icons.check),
                                  color: Colors.blue[900],
                                  size: 15,
                                ),
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 180,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              '${data['first_name']}  ${data['last_name']}',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${data['country']}, ${data['city']}',
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w100),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Text(
                              '${data['rate']}',
                              style: const TextStyle(
                                  color: Colors.amber, fontSize: 16),
                            ),
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        // TODO
                      },
                      child: const Text(
                        'Book an appointment',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Text(
                      ' | ',
                      style: TextStyle(color: Colors.white),
                    ),
                    IconButton(
                      onPressed: () {
                        // TODO
                      },
                      icon: const Icon(
                        Icons.call,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // TODO
                      },
                      icon: const Icon(
                        Icons.message,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      Icon(Icons.info, color: Colors.blue[800]),
                      const SizedBox(height: 8),
                      doubleTextView(
                          'Phone number', '+${data['phone_number']}'),
                      const SizedBox(height: 8),
                      doubleTextView('Description', data['description']),
                      const SizedBox(height: 8),
                      doubleTextView(
                          'Hourly rate', '${data['hourly_rate']} USD'),
                      const SizedBox(height: 8),
                      doubleTextView('Consultations', consultations),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              rated
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'You gave this expert $rate stars !    ',
                          style: const TextStyle(color: Colors.amber),
                        ),
                        GestureDetector(
                          onTap: (() => setState(() {
                                // TODO  decrease rating_sum of this expert by $rate
                                rated = false;
                              })),
                          child: const Text(
                            'rate again ?',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    )
                  : RatingBar(
                      itemSize: 40,
                      ratingWidget: RatingWidget(
                        full: const Icon(Icons.star, color: Colors.amber),
                        half: const Icon(Icons.star_half, color: Colors.amber),
                        empty:
                            const Icon(Icons.star_border, color: Colors.amber),
                      ),
                      onRatingUpdate: (rating) {
                        // TODO
                        setState(() {
                          rated = true;
                          rate = rating;
                        });
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
