import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PrivacyScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PrivacyState();
  }
}

class _PrivacyState extends State<PrivacyScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.grey[800], //change your color here
          ),
          title: Text(
            "Privacy/Terms",
            style: TextStyle(color: Colors.grey),
          ),
          backgroundColor: Colors.grey[100],
          brightness: Brightness.light,
          elevation: 0,
          bottom: TabBar(
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            indicatorColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.grey[800],
            tabs: [
              Tab(
                text: "PRIVACY",
              ),
              Tab(
                text: "TERMS OF USE",
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              _selectedIndex == 0 ? getPrivacyText() : getTermsText(),
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }

  String getTermsText() {
    return "Tincidunt dui ut ornare lectus sit amet. Nam aliquam sem et tortor consequat id porta nibh. Leo a diam sollicitudin tempor id eu nisl nunc. Ultricies leo integer malesuada nunc vel risus commodo. Fermentum leo vel orci porta non. Faucibus nisl tincidunt eget nullam non nisi est sit amet. Curabitur vitae nunc sed velit dignissim sodales. Est pellentesque elit ullamcorper dignissim cras. Tristique sollicitudin nibh sit amet. In metus vulputate eu scelerisque felis. Egestas integer eget aliquet nibh praesent tristique magna sit amet. Rhoncus mattis rhoncus urna neque viverra justo nec. Hendrerit dolor magna eget est lorem ipsum dolor sit. Facilisis sed odio morbi quis. Ligula ullamcorper malesuada proin libero nunc consequat interdum varius sit. Aliquam ut porttitor leo a diam sollicitudin tempor id. Cursus vitae congue mauris rhoncus aenean vel. Arcu odio ut sem nulla pharetra diam. Adipiscing elit ut aliquam purus sit amet luctus venenatis lectus. Phasellus faucibus scelerisque eleifend donec. Risus commodo viverra maecenas accumsan lacus vel. Malesuada bibendum arcu vitae elementum curabitur vitae nunc sed velit. Ut venenatis tellus in metus vulputate. Amet facilisis magna etiam tempor. Sagittis nisl rhoncus mattis rhoncus urna neque";
  }

  String getPrivacyText() {
    return "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ac odio tempor orci dapibus ultrices in iaculis nunc sed. Vel pretium lectus quam id. Purus in mollis nunc sed id semper risus in. Nibh tortor id aliquet lectus. Tincidunt dui ut ornare lectus sit amet. Nam aliquam sem et tortor consequat id porta nibh. Leo a diam sollicitudin tempor id eu nisl nunc. Ultricies leo integer malesuada nunc vel risus commodo. Fermentum leo vel orci porta non.Faucibus nisl tincidunt eget nullam non nisi est sit amet. Curabitur vitae nunc sed velit dignissim sodales. Est pellentesque elit ullamcorper dignissim cras. Tristique sollicitudin nibh sit amet. In metus vulputate eu scelerisque felis. Egestas integer eget aliquet nibh praesent tristique magna sit amet. Rhoncus mattis rhoncus urna neque viverra justo nec. Hendrerit dolor magna eget est lorem ipsum dolor sit. Facilisis sed odio morbi quis. Ligula ullamcorper malesuada proin libero nunc consequat interdum varius sit. Aliquam ut porttitor leo a diam sollicitudin tempor id.";
  }
}
