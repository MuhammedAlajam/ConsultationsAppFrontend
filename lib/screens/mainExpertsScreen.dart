import 'package:cons_frontend/models/api_response.dart';
import 'package:cons_frontend/models/expert.dart';
import 'package:cons_frontend/services/expert_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class mainExpertsScreen extends StatefulWidget {
  const mainExpertsScreen({super.key});

  @override
  State<mainExpertsScreen> createState() => _mainExpertsScreenState();
}

class _mainExpertsScreenState extends State<mainExpertsScreen> {
  var consultatinos = ['Medical', 'Familial', 'Business', 'd', 'e'];
  int index = 0;
  List<dynamic> _expertsList = [];
  bool loading = true;

  Future<void> retrieveExperts() async {
    ApiResponse response = await getExpertsOfConsultation(index + 1);

    if (response.error == null) {
      setState(() {
        loading = !loading;
        _expertsList = response.data as List<dynamic>;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.teal.shade900,
          content: Text(
            '${response.error}',
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    retrieveExperts();
    super.initState();
  }

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
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.white, Colors.teal.shade500],
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.teal.shade900,
                              ),
                              tooltip: 'previous consultation experts',
                              onPressed: () => {
                                setState(() {
                                  index--;
                                  if (index == -1) index = 4;
                                  loading = true;
                                  retrieveExperts();
                                }),
                              },
                              iconSize: 40,
                            ),
                            Text(
                              consultatinos[index],
                              style: TextStyle(
                                color: Colors.teal.shade900,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.teal.shade900,
                              ),
                              tooltip: 'next consultation experts',
                              onPressed: () => {
                                setState(() {
                                  index = (index + 1) % 5;
                                  loading = true;
                                  retrieveExperts();
                                }),
                              },
                              iconSize: 40,
                            ),
                          ],
                        ),
                      ),
                      loading
                          ? Center(
                              child: CircularProgressIndicator(
                                color: Colors.teal.shade300,
                              ),
                            )
                          : ListView.builder(
                              itemCount: _expertsList.length,
                              itemBuilder: (BuildContext context, int ind) {
                                Expert ex = _expertsList[ind];
                                return Text('${ex.username}');
                              },
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
