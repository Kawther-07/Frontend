import 'package:flutter/material.dart';
import 'patient_profile_page.dart';

class HomePage extends StatefulWidget {
  final int? patientId;

  HomePage({Key? key, this.patientId}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, 
        title: SizedBox.shrink(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              width: 300,
              height: 65,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFA67CE4),
                    Color(0xFF5915BD),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.logout, color: Colors.white),
                      onPressed: () {},
                    ),
                    Row(
                      children: [
                        Icon(Icons.person, color: Colors.white),
                        SizedBox(width: 10),
                        Text(
                          'User Name',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.settings, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20), 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Color(0xFF5915BD)),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF300374).withOpacity(0.5), 
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 2), 
                        ),
                      ],
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Your blood sugar:\n',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
                          ),
                          TextSpan(
                            text: '7.22 mmol/L',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Color(0xFF5915BD)), 
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF300374).withOpacity(0.5), 
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 2), 
                        ),
                      ],
                    ),
                    child: Text(
                      'Have you taken your medications for today?',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20), 
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Color(0xFF5915BD)), 
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF300374).withOpacity(0.5), 
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Transform.translate(
                        offset: Offset(0, 12), 
                        child: Icon(Icons.calendar_today, color: Color(0xFF5915BD)),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Your next appointment:',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: 0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround, 
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Text(
                          'June 17, 2024',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                      ),
                      SizedBox(width: 8), 
                      Padding(
                        padding: const EdgeInsets.only(right: 90),
                        child: Text(
                          '11:00 am',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFA67CE4),
                    Color(0xFF5915BD),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Text(
                    'Do you want to check your foot condition?',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: 200,
                    height: 50, 
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30), 
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        backgroundColor: Colors.white, 
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Take a picture',
                            style: TextStyle(color: Color(0xFF5915BD)), 
                          ),
                          Icon(
                            Icons.camera_alt,
                            color: Color(0xFF5915BD), 
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5), 
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Learn about your condition',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF262626)),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(width: 10),
                  FootConditionCard(imagePath: 'assets/ulcer1.jpg'),
                  SizedBox(width: 10),
                  FootConditionCard(imagePath: 'assets/ulcer1.jpg'),
                  SizedBox(width: 10),
                  FootConditionCard(imagePath: 'assets/ulcer1.jpg'),
                  SizedBox(width: 10),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: _selectedIndex == 0 ? Color(0xFF5915BD) : Color(0xFF505050)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart, color: _selectedIndex == 1 ? Color(0xFF5915BD) : Color(0xFF505050)),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school, color: _selectedIndex == 2 ? Color(0xFF5915BD) : Color(0xFF505050)),
            label: 'Education',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: _selectedIndex == 3 ? Color(0xFF5915BD) : Color(0xFF505050)),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF5915BD),
        unselectedItemColor: Color(0xFF505050),
        selectedLabelStyle: TextStyle(color: Color(0xFF5915BD)),
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });

      switch (index) {
        case 0:
          if (widget.patientId != null) {
            return;
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(patientId: widget.patientId),
              ),
            );
          }
          break;
        case 1:
          break;
        case 2:
          break;
        case 3:
          if (widget.patientId != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PatientProfilePage(
                  patientId: widget.patientId!,
                  currentIndex: _selectedIndex,
                  onItemTapped: _handleItemTap,
                ),
              ),
            );
          } else {
            print('Patient ID is null');
          }
          break;
      }
    }
  }

  void _handleItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class FootConditionCard extends StatelessWidget {
  final String imagePath;

  const FootConditionCard({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey), 
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
