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
        automaticallyImplyLeading: false, // This line removes the back button
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
            SizedBox(height: 20), // Adjust spacing as needed
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
                      border: Border.all(color: Color(0xFF5915BD)), // Border color
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
                      border: Border.all(color: Color(0xFF5915BD)), // Border color
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
            SizedBox(height: 20), // Adjust spacing as needed
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Color(0xFF5915BD)), // Border color
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF300374).withOpacity(0.5), // Shadow color
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Transform.translate(
                        offset: Offset(0, 12), // Adjust the vertical offset as needed
                        child: Icon(Icons.calendar_today, color: Color(0xFF5915BD)),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Your next appointment:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround, // Align the children to the center
                    children: [
                      Text(
                        'June 17, 2024',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      SizedBox(width: 8), // Adjust the space between "Date" and "Time"
                      Text(
                        '11:00 am',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20), // Adjust spacing as needed
            Container(
              padding: EdgeInsets.all(20),
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
                  SizedBox(height: 20),
                  SizedBox(
                    width: 200,
                    height: 50, // Set the desired width
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30), // Set button border radius
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20), // Adjust padding as needed
                        backgroundColor: Colors.white, // Set button background color to white
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Take a picture',
                            style: TextStyle(color: Color(0xFF5915BD)), // Set text color to purple
                          ),
                          Icon(
                            Icons.camera_alt,
                            color: Color(0xFF5915BD), // Set icon color to purple
                          ),
                        ],
                      ),
                    ),
                  ),
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
          // Check if already on the home page
          if (widget.patientId != null) {
            // Do nothing if already on the home page
            return;
          } else {
            // Navigate to the home page without replacing the route
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(patientId: widget.patientId),
              ),
            );
          }
          break;
        case 1:
          // Handle navigation to Stats page
          break;
        case 2:
          // Handle navigation to Education page
          break;
        case 3:
          // Check if patientId is available
          if (widget.patientId != null) {
            // Navigate to the profile page passing patientId, currentIndex, and onItemTapped
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
            // Patient ID is null
            print('Patient ID is null');
          }
          break;
      }
    }
  }

  // Callback function to handle item tap
  void _handleItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
