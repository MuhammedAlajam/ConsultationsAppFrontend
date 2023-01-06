import 'package:consultations/constant.dart';
import 'package:consultations/models/api_response.dart';
import 'package:consultations/screens/new_appointment.dart';
import 'package:consultations/services/expert_service.dart';
import 'package:consultations/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ExpertProfileScreen extends StatefulWidget {
  final String idExpert;
  const ExpertProfileScreen({super.key, required this.idExpert});

  @override
  State<ExpertProfileScreen> createState() =>
      // ignore: no_logic_in_create_state
      _ExpertProfileScreenState(idExpert);
}

class _ExpertProfileScreenState extends State<ExpertProfileScreen> {
  String idExpert;
  _ExpertProfileScreenState(this.idExpert);

  late Map<String, dynamic> data;
  String consultations = '';
  bool rated = false, isFavorite = false, loading = false;

  void _getExpertData() async {
    ApiResponse response = await getExpertProfile(idExpert);

    if (response.error == null) {
      setState(() {
        loading = false;
      });
      loading = false;
      data = response.data as Map<String, dynamic>;
      debugPrint(response.data.toString());
      if (data['is_favorite']) isFavorite = true;

      List consultationsList = data['consultations'] as List<dynamic>;
      consultations = '';
      for (int i = 0; i < consultationsList.length; i++) {
        consultations =
            consultations + consultationsList.elementAt(i).toString();

        consultations =
            '$consultations ${((i + 1) == consultationsList.length) ? '.' : ', '}';
      }
    }
  }

  void _rateExpert(double rating) async {
    await rateExpert(data['id'].toString(), rating.toString());
  }

  void flipfav() async {
    await flipFavorite(data['id'].toString());
  }

  @override
  void initState() {
    loading = true;
    _getExpertData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[600],
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: loading
              ? Container(
                  margin: const EdgeInsets.only(top: 200),
                  child: const CircularProgressIndicator(color: Colors.white))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
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
                              offset: const Offset(
                                  0, 3), // changes position of shadow
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
                                        setState(() {
                                          flipfav();
                                          isFavorite = !isFavorite;
                                        });
                                      },
                                      elevation: 2.0,
                                      fillColor: Colors.white,
                                      shape: const CircleBorder(),
                                      child: Icon(
                                        (isFavorite
                                            ? Icons.check
                                            : Icons.person_add),
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
                                    color: Colors.white,
                                    fontWeight: FontWeight.w100),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NewAppointmentScreen(
                                            expertId: data['id'].toString(),
                                          )));
                            },
                            child: const Text(
                              'Book an appointment',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Text(
                            ' | ',
                            style: TextStyle(color: Colors.white),
                          ),
                          IconButton(
                            onPressed: () {
                              // TODO calling
                            },
                            icon: const Icon(
                              Icons.call,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              // TODO message
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
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
                    RatingBar(
                      itemSize: 40,
                      ratingWidget: RatingWidget(
                        full: const Icon(Icons.star, color: Colors.amber),
                        half: const Icon(Icons.star_half, color: Colors.amber),
                        empty:
                            const Icon(Icons.star_border, color: Colors.amber),
                      ),
                      onRatingUpdate: (rating) {
                        _rateExpert(rating);
                      },
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
