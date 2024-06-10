import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About Us',
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFA67CE4),
                Color(0xFF5915BD),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/Logo2.png',
                  height: 200.0, // Set the height of your logo
                  width: 200.0,  // Set the width of your logo
                ),
              ),
              const SizedBox(height: 20.0), // Add some space between the logo and the text
              Text(
                'DoolabCare is a revolutionary platform designed to empower patients and doctors in managing diabetes care effectively. Our integrated mobile and web applications offer seamless connectivity and advanced features aimed at improving healthcare outcomes.',
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0), // Add some space below the introductory text

              // Section for Patients
              Text(
                'For Patients:',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10.0), // Add space between section title and content
              Text(
                '- Glycemia Tracking: Monitor your blood glucose levels effortlessly using our intuitive mobile app interface.',
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                '- Medical Records: Easily manage and access your medical history, ensuring comprehensive healthcare management.',
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                '- Personal Profile: Maintain your health profile with updated information for personalized care.',
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                '- Educational Resources: Access a wealth of educational materials and resources to enhance your understanding of diabetes management.',
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                '- DFU Detection: Utilize our AI-powered model to detect Diabetic Foot Ulcers (DFU) by simply taking a picture of your feet.',
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 20.0), // Add space between sections

              // Section for Doctors
              Text(
                'For Doctors:',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10.0), // Add space between section title and content
              Text(
                '- Patient Insights: Access detailed medical records and DFU predictions captured by patients, facilitating informed decision-making.',
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                '- Dashboard: Monitor notifications and stay updated with real-time patient interactions and alerts.',
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 20.0), // Add space between sections

              // Vision and Future Directions
              Text(
                'Our Vision:',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10.0), // Add space between section title and content
              Text(
                'At DoolabCare, we are committed to leveraging technology to streamline diabetes management, enhance patient-doctor collaboration, and ultimately improve quality of life for individuals living with diabetes.',
                style: TextStyle(fontSize: 16.0),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0), // Add space between sections

              // Get Involved
              Text(
                'Get Involved:',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10.0), // Add space between section title and content
              Text(
                'Join us on our journey to revolutionize diabetes care. Whether you\'re a patient seeking better management tools or a doctor aiming to provide enhanced care, DoolabCare is here to support you every step of the way.',
                style: TextStyle(fontSize: 16.0),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0), // Add space between sections

              // Future Directions
              Text(
                'Future Directions:',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10.0), // Add space between section title and content
              Text(
                'As we continue to evolve, we aim to expand our platform\'s capabilities, integrate more advanced AI models for predictive analytics, and collaborate with healthcare professionals to innovate diabetes care globally.',
                style: TextStyle(fontSize: 16.0),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0), // Add space between sections

              // Contact Us
              Text(
                'Contact Us:',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10.0), // Add space between section title and content
              Text(
                'Have questions or feedback? We\'d love to hear from you. Reach out to us at doolabcare@email.com or follow us on social media handles.',
                style: TextStyle(fontSize: 16.0),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
