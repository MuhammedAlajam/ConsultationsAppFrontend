import 'package:consultations/constant.dart';
import 'package:consultations/screens/conversations.dart';
import 'package:consultations/screens/experts.dart';
import 'package:consultations/screens/profile.dart';
import 'package:consultations/screens/user_booked_times.dart';
import 'package:flutter/material.dart';
import 'consultations.dart';
import 'loading.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> pages = [
    const ConsultationsScreen(),
    const BookedTimesUserScreen(),
    const ConversationsScreen()
  ];
  int pageInd = 0;
  TextEditingController searchBox = TextEditingController();
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 100,
        backgroundColor: Colors.white,
        currentIndex: pageInd,
        onTap: (int index) {
          setState(() {
            pageInd = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.live_help), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.message_sharp), label: ''),
        ],
        selectedItemColor: Colors.blue[800],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi, ${(user?.firstName)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            date(),
                            style: TextStyle(
                              color: Colors.blue[200],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProfileScreen())),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: Colors.blue[600],
                              borderRadius: BorderRadius.circular(12)),
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  // begin container
                  if (pageInd == 0)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[600],
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: Colors.blue[100],
                              ),
                              child: TextField(
                                controller: searchBox,
                                cursorColor: Colors.white,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.only(
                                    top: 15,
                                  ),
                                  prefixIcon: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Icon(
                                      Icons.search,
                                      color: Colors.blue[800],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            icon: const Icon(Icons.display_settings_rounded,
                                color: Colors.white),
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ExpertsScreen(
                                        path: searchOnExpertsUrl,
                                        data: searchBox.text)),
                              );
                            },
                            icon: const Icon(Icons.check, color: Colors.white),
                          ),
                        ],
                      ),
                    ),

                  // end of container ****
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50),
                  ),
                ),
                child: Center(
                  child: pages[pageInd],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
