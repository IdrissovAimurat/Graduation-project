import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Поддержка"),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Text(
                  'Нашли проблему или есть предложения?',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Обратная связь:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 10),
              _buildContactTile(
                context,
                icon: Icons.phone,
                title: '+7-(778)-322-38-83',
                onTap: () => _makePhoneCall('+77783223883'),
              ),
              _buildContactTile(
                context,
                icon: Icons.message,
                title: '+7-(778)-322-38-83',
                onTap: () => _sendWhatsApp('+77783223883'),
              ),
              _buildContactTile(
                context,
                icon: Icons.phone,
                title: '+7-(776)-952-50-50',
                onTap: () => _makePhoneCall('+77769525050'),
              ),
              _buildContactTile(
                context,
                icon: Icons.message,
                title: '+7-(776)-952-50-50',
                onTap: () => _sendWhatsApp('+77769525050'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactTile(BuildContext context, {required IconData icon, required String title, required VoidCallback onTap}) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, color: Colors.teal, size: 30),
        title: Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        trailing: Icon(Icons.arrow_forward, color: Colors.teal),
        onTap: onTap,
      ),
    );
  }

  void _makePhoneCall(String phoneNumber) async {
    Uri uri = Uri.parse('tel:$phoneNumber');
    if (!await launchUrl(uri)) {
      debugPrint("Could not launch $uri");
    }
  }

  void _sendWhatsApp(String phoneNumber) async {
    String cleanNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');
    String url = "https://wa.me/$cleanNumber";
    if (!await launchUrl(Uri.parse(url))) {
      debugPrint("Could not launch $url");
    }
  }
}
