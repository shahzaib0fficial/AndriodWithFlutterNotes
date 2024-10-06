import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ListData> listData = [
    ListData(title: "Basic Mathematics", time: 45, status: "Done", color: const Color(0xFFCBC3E3), icon: const Icon(Icons.calculate_outlined)),
    ListData(title: "English Grammar", time: 60, status: "To do", color: const Color(0xFFADD8E6), icon: const Icon(Icons.book)),
    ListData(title: "Science", time: 40, status: "To do", color: const Color(0xFF90EE90), icon: const Icon(Icons.science)),
    ListData(title: "World History", time: 20, status: "To do", color: const Color(0xFFFFB6C1), icon: const Icon(Icons.map)),
    ListData(title: "Computer Science", time: 90, status: "To do", color: const Color(0xFFFFFFC5), icon: const Icon(Icons.computer)),
    ListData(title: "Basic Mathematics", time: 45, status: "Done", color: const Color(0xFFCBC3E3), icon: const Icon(Icons.calculate_outlined)),
    ListData(title: "Science", time: 40, status: "To do", color: const Color(0xFF90EE90), icon: const Icon(Icons.science)),
    ListData(title: "English Grammar", time: 60, status: "To do", color: const Color(0xFFADD8E6), icon: const Icon(Icons.book)),
    ListData(title: "Computer Science", time: 90, status: "To do", color: const Color(0xFFFFFFC5), icon: const Icon(Icons.computer)),
    ListData(title: "World History", time: 20, status: "To do", color: const Color(0xFFFFB6C1), icon: const Icon(Icons.map)),
  ];

  double subjectColorOpacity = 0.5;
  double homeWorkColorOpacity = 1.0;
  double libraryColorOpacity = 0.5;

  int bottomNavSelectedItem = 0;
  void onBottomNavClick(int index){
    setState(() {
      bottomNavSelectedItem = index;
    });
  }

  void changeColorOpacity(int textIndex) {
    setState(() {
      switch (textIndex) {
        case 1:
          subjectColorOpacity = 1.0;
          homeWorkColorOpacity = 0.5;
          libraryColorOpacity = 0.5;
          break;
        case 2:
          subjectColorOpacity = 0.5;
          homeWorkColorOpacity = 1.0;
          libraryColorOpacity = 0.5;
          break;
        case 3:
          subjectColorOpacity = 0.5;
          homeWorkColorOpacity = 0.5;
          libraryColorOpacity = 1.0;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: (){
                changeColorOpacity(1);
              },
              child: Text(
                "Subjects",
                style: TextStyle(
                  color: Colors.black.withOpacity(subjectColorOpacity),
                  fontSize: 20
                )
              ),
            ),
            GestureDetector(
              onTap: (){
                changeColorOpacity(2);
              },
              child: Text(
                "HomeWork",
                style: TextStyle(
                  color: Colors.black.withOpacity(homeWorkColorOpacity),
                  fontSize: 20
                )
              ),
            ),
            GestureDetector(
              onTap: (){
                changeColorOpacity(3);
              },
              child: Text(
                "Library",
                style: TextStyle(
                  color: Colors.black.withOpacity(libraryColorOpacity),
                  fontSize: 20
                )
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                fillColor: const Color(0xFFd3d3d3).withOpacity(0.5),
                // border: InputBorder.none,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(50)
                ),
                filled: true,
                hintText: "Write Something...",
                hintStyle: TextStyle(
                    color: const Color(0xFF000000).withOpacity(0.5)
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xFF000000),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Row(
                  children: [
                    Text(
                      "Subject: ",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18
                      )
                    ),
                    Text(
                      "All",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18
                      )
                    ),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
                SizedBox(width: 20),
                Row(
                  children: [
                    Text(
                        "Sort by: ",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18
                        )
                    ),
                    Text(
                        "Do first",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18
                        )
                    ),
                    Icon(Icons.arrow_drop_down),
                  ],
                )
              ],
            ),
            const SizedBox(height: 15),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Tuesday 6",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                        )
                    ),
                    SizedBox(width: 5),
                    Text(
                        "4 Task",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                        )
                    ),
                  ],
                ),
                Icon(
                  Icons.calendar_month
                )
              ],
            ) ,
            const SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: listData.length,
                itemBuilder: (context,index){
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: listData[index].color,
                            borderRadius: BorderRadius.circular(25)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(17)
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(12),
                                        child: Row(
                                          children: [
                                            listData[index].icon
                                          ],
                                        ),
                                      )
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          listData[index].title,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                          )
                                      ),
                                      Text(
                                          "${listData[index].time} min",
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                          )
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(17)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Text(
                                    listData[index].status,
                                    style: const TextStyle(
                                        color: Colors.black
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20)
                    ],
                  );
                }
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
            backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: "Calendar",
            backgroundColor: Colors.green
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: "Book",
            backgroundColor: Colors.red
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: "Messages",
            backgroundColor: Colors.black
          )
        ],
        currentIndex: bottomNavSelectedItem,
        selectedItemColor: Colors.amber,
        onTap: onBottomNavClick,
      ),
    );
  }
}

class ListData {
  Color color;
  Icon icon;
  String title;
  int time;
  String status;

  // Constructor
  ListData({required this.title, required this.time, required this.status, required this.color, required this.icon});
}
