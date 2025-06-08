import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_animate/flutter_animate.dart';

void main() => runApp(KisanConnectApp());

class KisanConnectApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kisan Connect',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF141414),
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Poppins',
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map<String, String>> carouselItems = [
    {"image": "assets/image1.jpg", "title": "Explore Our Crops"},
    {"image": "assets/image2.jpg", "title": "Top Quality Equipment"},
    {"image": "assets/image3.jpg", "title": "Fresh Produce Delivered"},
  ];

  final List<Map<String, dynamic>> categories = [
    {
      "icon": Icons.grass,
      "title": "Crops",
      "desc": "Discover a variety of crops.",
      "screen": CropsViewScreen(),
    },
    {
      "icon": Icons.agriculture,
      "title": "Equipment",
      "desc": "Find the best agricultural tools.",
      "screen": EquipmentViewScreen(),
    },
    {
      "icon": Icons.local_grocery_store,
      "title": "Fresh Produce",
      "desc": "Order fresh fruits and vegetables.",
      "screen": ProduceFAQScreen(),
    },
  ];

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Colors.black : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor = isDark ? Colors.white70 : Colors.black54;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: bgColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Colors.grey[800],
          title: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset('assets/logo.png.jpg', width: 50),
              ).animate().fadeIn(duration: 600.ms).scale(),
              SizedBox(width: 10),
              Text(
                'Kisan Connect',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ).animate().fadeIn(duration: 600.ms).moveX(begin: 30),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.more_vert, size: 28),
              onPressed: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
              tooltip: 'Menu',
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.grey[800]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.account_circle, size: 60, color: Colors.white),
                  SizedBox(height: 10),
                  Text('Welcome!',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  Text('Explore Agriculture',
                      style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.login),
              title: Text('Login'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FarmerDashboard()),
                );

                // TODO: Handle login tap
              },
            ),
            ListTile(
              leading: Icon(Icons.person_add),
              title: Text('Sign In'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BuyerDashboardPage()),
                );
                // TODO: Handle sign in tap
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context); // Close drawer
              },
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          // 🔍 Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 45,
              child: TextField(
                style: TextStyle(color: Colors.black), // input text color
                decoration: InputDecoration(
                  hintText: 'Search crops, equipment, produce...',
                  hintStyle:
                      TextStyle(color: Colors.black54), // hint text color
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
          ),

          // 📸 Carousel
          CarouselSlider(
            items: carouselItems.map((item) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(item['image']!, fit: BoxFit.cover),
                  Container(color: Colors.black45),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item['title']!,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ).animate().fadeIn().moveY(begin: -30),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white),
                          child: Text('Explore Now',
                              style: TextStyle(color: Colors.black)),
                        ).animate().fadeIn(duration: 1000.ms),
                      ],
                    ),
                  )
                ],
              );
            }).toList(),
            options: CarouselOptions(
              height: 300,
              autoPlay: true,
              viewportFraction: 1.0,
            ),
          ),

          // 📘 Info Section
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text("What is Contract Farming?",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: textColor)),
                SizedBox(height: 10),
                Text(
                  "Contract farming is an agreement between farmers and buyers to produce specific crops at predetermined prices...",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: subTextColor),
                ),
              ],
            ),
          ),

          // 🧩 Categories
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Text("Explore Categories",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: textColor)),
                SizedBox(height: 20),

                // Row 1: Crops
                Row(
                  children: [
                    Expanded(
                      child: _buildCategoryBox(
                          categories[0], textColor, subTextColor, context),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                // Row 2: Equipment and Fresh Produce
                Row(
                  children: [
                    Expanded(
                      child: _buildCategoryBox(
                          categories[1], textColor, subTextColor, context),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: _buildCategoryBox(
                          categories[2], textColor, subTextColor, context),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 💬 Testimonials
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text("What Our Users Say",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: textColor)),
                SizedBox(height: 10),
                _testimonial(
                    "Kisan Connect has revolutionized my farming experience!",
                    "Ramanaiah, Farmer",
                    textColor,
                    subTextColor),
                _testimonial(
                    "I can easily order fresh produce online. Highly recommend!",
                    "Sanjay, Customer",
                    textColor,
                    subTextColor),
                _testimonial("The support from Kisan Connect is exceptional!",
                    "Suresh Patel, Farmer", textColor, subTextColor),
              ],
            ),
          ),

          // 🔻 Footer
          Container(
            color: Color(0xFF02100f),
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Text("© 2025 Kisan Connect. All rights reserved.",
                    style: TextStyle(color: subTextColor)),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.facebook, size: 30, color: Colors.white),
                    SizedBox(width: 10),
                    Icon(Icons.alternate_email, size: 30, color: Colors.white),
                    SizedBox(width: 10),
                    Icon(Icons.camera_alt, size: 30, color: Colors.white),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFFF4757),
        onPressed: () {},
        child: Icon(Icons.mic),
      ),
    );
  }

  Widget _buildCategoryBox(Map<String, dynamic> cat, Color textColor,
      Color subTextColor, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => cat['screen']));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        height: 147,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF8e44ad), Color(0xFF3498db)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(cat['icon'], size: 40, color: Colors.white),
              SizedBox(height: 10),
              Text(
                cat['title'],
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 5),
              Text(
                cat['desc'],
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _testimonial(
      String text, String author, Color textColor, Color subTextColor) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text('"$text"',
              style: TextStyle(
                  fontStyle: FontStyle.italic, fontSize: 16, color: textColor)),
          SizedBox(height: 10),
          Text(author,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: subTextColor)),
        ],
      ),
    );
  }
}

class ContactUsPage extends StatefulWidget {
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final _formKey = GlobalKey<FormState>();
  bool _showSuccessMessage = false;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _showSuccessMessage = true;
      });
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0D091E),
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png', // Ensure this image exists and is declared in pubspec.yaml
              width: 35,
            ),
            SizedBox(width: 8),
            Text('Kisan Connect'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {}, // Navigate to About Us if needed
            child: Text('About Us', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 28,
                color: Color(0xFF38be14),
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  buildInputField("Name", _nameController, TextInputType.name),
                  SizedBox(height: 15),
                  buildInputField(
                      "Email", _emailController, TextInputType.emailAddress),
                  SizedBox(height: 15),
                  buildMessageField(),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF38be14),
                      ),
                      child: Text("Send Message"),
                    ),
                  ),
                ],
              ),
            ),
            if (_showSuccessMessage)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.green.shade700,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.white),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Your message has been sent successfully! We will respond soon.",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF0D091E),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            '© 2025 Kisan Connect. All rights reserved.',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget buildInputField(
      String label, TextEditingController controller, TextInputType inputType) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        hintText: 'Your $label',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please enter your $label';
        return null;
      },
    );
  }

  Widget buildMessageField() {
    return TextFormField(
      controller: _messageController,
      maxLines: 4,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: "Message",
        labelStyle: TextStyle(color: Colors.white),
        hintText: 'Your Message',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please enter a message';
        return null;
      },
    );
  }
}

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0D091E),
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png', // Ensure this image exists in assets folder and is declared in pubspec.yaml
              width: 35,
            ),
            SizedBox(width: 8),
            Text('Kisan Connect'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('Contact Us', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // Hero Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 70),
              color: Color(0xCC2E8982),
              child: Column(
                children: [
                  Text(
                    'About Us',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Learn more about Kisan Connect',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),

            // Main Content
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 15,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionHeader('About Kisan Konnect'),
                  Text(
                      'We are dedicated to connecting farmers and buyers in a seamless marketplace. Our platform provides a variety of agricultural products and services to meet the needs of our users.'),
                  SizedBox(height: 20),
                  SectionHeader('Our Mission'),
                  Text(
                      'To empower farmers and provide buyers with access to quality agricultural products.'),
                  SizedBox(height: 20),
                  SectionHeader('Our Vision'),
                  Text(
                      'To be the leading online marketplace for agricultural products, fostering sustainable practices and supporting local farmers.'),
                  SizedBox(height: 20),
                  SectionHeader('Our Values'),
                  BulletList([
                    'Integrity: We uphold the highest standards of integrity in all our actions.',
                    'Customer Focus: We value our customers and strive to meet their needs.',
                    'Innovation: We embrace change and seek new ways to improve our services.',
                    'Sustainability: We are committed to promoting sustainable agricultural practices.',
                  ]),
                ],
              ),
            ),

            // Footer
            Column(
              children: [
                Divider(color: Colors.white24),
                Text('© 2025 Kisan Connect. All rights reserved.'),
                Text(
                    'Customer Support: 9999999999 | Email: customercare@kisankonnect.in'),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Future: Add speech recognition trigger
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text("Voice command feature not yet implemented")),
          );
        },
        backgroundColor: Color(0xFFFF4757),
        child: Icon(Icons.mic),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String text;
  SectionHeader(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 24, color: Color(0xFF38BE14), fontWeight: FontWeight.bold),
    );
  }
}

class BulletList extends StatelessWidget {
  final List<String> items;
  BulletList(this.items);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items
          .map(
            (e) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("• ", style: TextStyle(fontSize: 18)),
                  Expanded(child: Text(e)),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class FarmerDashboard extends StatelessWidget {
  final List<Map<String, String>> dashboardItems = [
    {
      'title': 'Equipment Rentals',
      'image': 'https://images.unsplash.com/photo-1592982537447-7440770cbfc9',
      'icon': '🛠️'
    },
    {
      'title': 'Market Trends',
      'image': 'https://images.unsplash.com/photo-1605000797499-95a51c5269ae',
      'icon': '📈'
    },
    {
      'title': 'Weather Updates',
      'image': 'https://images.unsplash.com/photo-1601134467661-3d775b999c8b',
      'icon': '🌤️'
    },
  ];

  final List<Map<String, String>> testimonials = [
    {
      'text':
          '"Kisan Connect has transformed my farming experience. The quality of produce is exceptional!"',
      'author': '— Rajesh Kumar, Farmer'
    },
    {
      'text':
          '"I love the convenience of ordering fresh fruits and vegetables online. Highly recommend!"',
      'author': '— Anita Sharma, Customer'
    },
    {
      'text':
          '"The support from Kisan Connect has been invaluable. They truly care about farmers!"',
      'author': '— Suresh Patel, Farmer'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final isTablet = width > 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0d091e),
        title: Row(
          children: [
            Image.asset('assets/logo.png.jpg', width: isTablet ? 50 : 35),
            SizedBox(width: isTablet ? 20 : 10),
            Text('Kisan Connect',
                style: TextStyle(fontSize: isTablet ? 30 : 30)),
          ],
        ),
      ),
      body: ListView(
        children: [
          // Header Section
          Container(
            padding: EdgeInsets.symmetric(vertical: isTablet ? 120 : 80),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0x700aed61),
                Color(0x1c06b26a),
              ]),
            ),
            child: Column(
              children: [
                Text("Welcome to Kisan Connect",
                    style: TextStyle(
                        fontSize: isTablet ? 40 : 32,
                        fontWeight: FontWeight.bold)),
                Text("Empowering Farmers with Technology",
                    style: TextStyle(fontSize: isTablet ? 24 : 18)),
              ],
            ),
          ),

          // Search Bar
          Padding(
            padding: EdgeInsets.all(isTablet ? 32 : 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFF2EAEA),
                      hintText: 'Search for anything...',
                      hintStyle: TextStyle(
                          color: Colors.black54, fontSize: isTablet ? 20 : 14),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: isTablet ? 32 : 20,
                          vertical: isTablet ? 20 : 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(isTablet ? 30 : 20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: isTablet ? 20 : 10),
                CircleAvatar(
                  backgroundColor: Color(0xFFbf995c),
                  radius: isTablet ? 28 : 20,
                  child: Icon(Icons.search,
                      color: Colors.white, size: isTablet ? 32 : 24),
                )
              ],
            ),
          ),

          // Dashboard Grid
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: isTablet ? 32 : 16, vertical: isTablet ? 16 : 8),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: dashboardItems.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isTablet ? 3 : 2,
                crossAxisSpacing: isTablet ? 24 : 16,
                mainAxisSpacing: isTablet ? 24 : 16,
                childAspectRatio: isTablet ? 1.1 : 1.2,
              ),
              itemBuilder: (context, index) {
                final item = dashboardItems[index];
                return GestureDetector(
                  onTap: () {
                    // Replace with your actual target page
                    if (item['title'] == 'Equipment Rentals') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EquipmentRentalPage()),
                      );
                    } else if (item['title'] == 'Market Trends') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AgricultureTrendsPage()),
                      );
                    } else if (item['title'] == 'Weather Updates') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WeatherMarketPage()),
                      );
                    }
                  },
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(item['image']!),
                            fit: BoxFit.cover,
                          ),
                          borderRadius:
                              BorderRadius.circular(isTablet ? 30 : 20),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(isTablet ? 30 : 20),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xE509A745),
                              Color(0xE5ACB5B4),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(item['icon']!,
                                style: TextStyle(fontSize: isTablet ? 48 : 32)),
                            Text(item['title']!,
                                style: TextStyle(
                                    fontSize: isTablet ? 26 : 20,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),

          // Testimonials
          Container(
            color: Color(0xFF2c2c2c),
            padding: EdgeInsets.all(isTablet ? 40 : 24),
            child: Column(
              children: [
                Text("Testimonials",
                    style: TextStyle(
                        fontSize: isTablet ? 32 : 24,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: isTablet ? 30 : 20),
                ...testimonials.map((t) => Card(
                      color: Color(0xFF1a1a1a),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(isTablet ? 30 : 20)),
                      child: Padding(
                        padding: EdgeInsets.all(isTablet ? 24 : 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(t['text']!,
                                style: TextStyle(fontSize: isTablet ? 22 : 16)),
                            SizedBox(height: isTablet ? 18 : 10),
                            Text(t['author']!,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: isTablet ? 18 : 14)),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ),

          // Footer
          Container(
            color: Color(0xFF0d091e),
            padding: EdgeInsets.all(isTablet ? 32 : 20),
            child: Column(
              children: [
                Text("© 2025 Kisan Connect. All rights reserved.",
                    style: TextStyle(fontSize: isTablet ? 18 : 14)),
                Text(
                    "Customer Support: 1800 267 0997 | Email: customercare@kisanconnect.in",
                    style: TextStyle(fontSize: isTablet ? 16 : 12)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class EquipmentRentalPage extends StatefulWidget {
  @override
  _EquipmentRentalPageState createState() => _EquipmentRentalPageState();
}

class _EquipmentRentalPageState extends State<EquipmentRentalPage> {
  final List<Map<String, String>> equipmentData = [
    {
      'name': 'Tractor',
      'category': 'tractors',
      'location': 'Maharashtra',
      'duration': 'daily',
      'availability': 'Available',
      'image': 'assets/tractor.jpg'
    },
    {
      'name': 'Harvester',
      'category': 'harvesters',
      'location': 'Uttar Pradesh',
      'duration': 'weekly',
      'availability': 'Available',
      'image': 'assets/harvester.jpg'
    },
    {
      'name': 'Sprayer',
      'category': 'sprayers',
      'location': 'Karnataka',
      'duration': 'daily',
      'availability': 'Available',
      'image': 'assets/sprayer.jpg'
    },
    {
      'name': 'Seeder',
      'category': 'seeders',
      'location': 'Gujarat',
      'duration': 'daily',
      'availability': 'Available',
      'image': 'assets/seeder.jpg'
    }
  ];

  String selectedCategory = 'all';
  String selectedDuration = 'all';
  String locationQuery = '';

  List<Map<String, String>> get filteredEquipment {
    return equipmentData.where((item) {
      return (selectedCategory == 'all' ||
              item['category'] == selectedCategory) &&
          (selectedDuration == 'all' || item['duration'] == selectedDuration) &&
          (locationQuery.isEmpty ||
              item['location']!
                  .toLowerCase()
                  .contains(locationQuery.toLowerCase()));
    }).toList();
  }

  void showBookingDialog(String name) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Booking Confirmation'),
        content: Text('You have successfully booked the $name.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final isTablet = width > 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0d091e),
        title: Row(
          children: [
            Image.asset('assets/logo.png.jpg', width: isTablet ? 50 : 35),
            SizedBox(width: isTablet ? 20 : 10),
            Text('Kisan Connect',
                style: TextStyle(fontSize: isTablet ? 28 : 20)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('Contact Us', style: TextStyle(color: Colors.amber)),
          ),
          TextButton(
            onPressed: () {},
            child: Text('About Us', style: TextStyle(color: Colors.amber)),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(isTablet ? 32 : 16),
        children: [
          Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text('Welcome to Our Equipment Rental Platform',
                    style: TextStyle(
                        fontSize: isTablet ? 24 : 20,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(
                  'Rent farming machinery at affordable prices. Access the best equipment when you need it.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Card(
            color: Colors.white10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Find the Perfect Equipment',
                      style: TextStyle(
                          fontSize: isTablet ? 20 : 18,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: selectedCategory,
                    items: [
                      'all',
                      'tractors',
                      'harvesters',
                      'sprayers',
                      'irrigation',
                      'seeders'
                    ]
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e[0].toUpperCase() + e.substring(1)),
                            ))
                        .toList(),
                    onChanged: (val) => setState(() => selectedCategory = val!),
                    decoration: InputDecoration(labelText: 'Category'),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(labelText: 'Location'),
                    onChanged: (val) => setState(() => locationQuery = val),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: selectedDuration,
                    items: ['all', 'daily', 'weekly', 'seasonal']
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e[0].toUpperCase() + e.substring(1)),
                            ))
                        .toList(),
                    onChanged: (val) => setState(() => selectedDuration = val!),
                    decoration: InputDecoration(labelText: 'Rental Duration'),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Text('Available Equipment',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.greenAccent)),
          SizedBox(height: 10),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: filteredEquipment.map((item) {
              return Container(
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(item['image']!, height: 150, fit: BoxFit.cover),
                    SizedBox(height: 10),
                    Text(item['name']!,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('Availability: ${item['availability']}'),
                    Text('Location: ${item['location']}'),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => showBookingDialog(item['name']!),
                      child: Text('Book Now'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                    )
                  ],
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 40),
          Divider(),
          Center(
            child: Column(
              children: [
                Text('© 2025 Kisan Connect. All rights reserved.'),
                TextButton(
                  onPressed: () {},
                  child: Text('Privacy Policy'),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('Terms of Service'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WeatherMarketPage extends StatefulWidget {
  const WeatherMarketPage({super.key});

  @override
  State<WeatherMarketPage> createState() => _WeatherMarketPageState();
}

class _WeatherMarketPageState extends State<WeatherMarketPage> {
  final TextEditingController searchController = TextEditingController();
  final List<Map<String, String>> crops = [
    {
      'name': 'Tomato',
      'description':
          'Tomatoes are widely grown in India. They require warm weather and well-drained soil.',
      'image': 'https://via.placeholder.com/40'
    },
    {
      'name': 'Rice',
      'description':
          'Rice is a staple food in India. It requires a lot of water and grows well in tropical climates.',
      'image': 'https://via.placeholder.com/40'
    },
    {
      'name': 'Wheat',
      'description':
          'Wheat is a major crop in India. It grows well in cool climates and requires moderate rainfall.',
      'image': 'https://via.placeholder.com/40'
    },
  ];

  List<Map<String, String>> filteredCrops = [];

  @override
  void initState() {
    super.initState();
    filteredCrops = crops;
  }

  void onSearch(String query) {
    setState(() {
      filteredCrops = crops
          .where((crop) =>
              crop['name']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void showCropDetails(BuildContext context, Map<String, String> crop) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(crop['name']!),
        content: Text(crop['description']!),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close')),
        ],
      ),
    );
  }

  Widget buildDataTable(
      String title, List<List<String>> rows, List<String> headers) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 20, color: Colors.greenAccent)),
          const SizedBox(height: 10),
          Table(
            border: TableBorder.all(color: Colors.black87),
            columnWidths: const {
              0: FlexColumnWidth(),
              1: FlexColumnWidth(),
              2: FlexColumnWidth(),
              3: FlexColumnWidth(),
              4: FlexColumnWidth(),
              5: FlexColumnWidth(),
            },
            children: [
              TableRow(
                children: headers
                    .map((h) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(h,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ))
                    .toList(),
              ),
              ...rows.map((row) => TableRow(
                    children: row
                        .map((cell) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(cell),
                            ))
                        .toList(),
                  ))
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0d091e),
        title: Row(
          children: [
            Image.asset('assets/logo.png.jpg', width: 35),
            const SizedBox(width: 8),
            const Text('Kisan Connect'),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Search Bar
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: searchController,
                onChanged: onSearch,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search for a crop...',
                  hintStyle: const TextStyle(color: Colors.white54),
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white10,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              if (searchController.text.isNotEmpty)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: filteredCrops
                        .map((crop) => ListTile(
                              leading: Image.network(crop['image']!),
                              title: Text(crop['name']!,
                                  style: const TextStyle(color: Colors.black)),
                              onTap: () => showCropDetails(context, crop),
                            ))
                        .toList(),
                  ),
                ),
            ],
          ),

          buildDataTable(
            'Current Weather Conditions',
            [
              ['Pune, India', '28°C', '65%', '0 mm', '10 km/h', '5'],
            ],
            [
              'Location',
              'Temperature',
              'Humidity',
              'Rainfall',
              'Wind Speed',
              'UV Index'
            ],
          ),

          buildDataTable(
            'Seasonal Forecast',
            [
              ['25-30°C', '150 mm', 'Low']
            ],
            ['Expected Temperature', 'Rainfall Forecast', 'Frost Risk'],
          ),

          const SizedBox(height: 20),
          const Center(
              child: Text('© 2025 Kisan Connect. All rights reserved.')),
        ],
      ),
    );
  }
}

class AgricultureTrendsPage extends StatefulWidget {
  const AgricultureTrendsPage({super.key});

  @override
  State<AgricultureTrendsPage> createState() => _AgricultureTrendsPageState();
}

class _AgricultureTrendsPageState extends State<AgricultureTrendsPage> {
  bool showFruits = true;
  String searchQuery = '';

  final List<Map<String, String>> fruits = [
    {
      'name': 'Apple',
      'price': '150/kg',
      'season': 'Winter',
      'benefit': 'Rich in fiber'
    },
    {
      'name': 'Banana',
      'price': '50/dozen',
      'season': 'Year-round',
      'benefit': 'High potassium'
    },
    {
      'name': 'Orange',
      'price': '80/kg',
      'season': 'Winter',
      'benefit': 'High vitamin C'
    },
    {
      'name': 'Grapes',
      'price': '120/kg',
      'season': 'Summer',
      'benefit': 'Antioxidants'
    },
  ];

  final List<Map<String, String>> vegetables = [
    {
      'name': 'Tomato',
      'price': '40/kg',
      'season': 'Summer',
      'benefit': 'Vitamin C'
    },
    {
      'name': 'Potato',
      'price': '30/kg',
      'season': 'Year-round',
      'benefit': 'Carbohydrates'
    },
    {
      'name': 'Cabbage',
      'price': '25/kg',
      'season': 'Winter',
      'benefit': 'Vitamin K'
    },
    {
      'name': 'Carrot',
      'price': '40/kg',
      'season': 'Winter',
      'benefit': 'Beta-carotene'
    },
  ];

  List<Map<String, String>> get filteredItems =>
      (showFruits ? fruits : vegetables)
          .where((item) =>
              item['name']!.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final isTablet = width > 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0d091e),
        title: const Text('Kisan Connect'),
        actions: [
          TextButton(
              onPressed: () {},
              child:
                  const Text('Trends', style: TextStyle(color: Colors.amber))),
          TextButton(
              onPressed: () {},
              child: const Text('Contact Us',
                  style: TextStyle(color: Colors.amber))),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionBox('Agriculture Industry in India',
              'The Indian agriculture industry plays a critical role in the nation\'s economy...'),
          _sectionBox('Importance of Agriculture',
              'Agriculture contributes significantly to GDP and supports various industries...'),
          _sectionBox('Challenges Faced',
              'Challenges include climate change, water scarcity, and price fluctuations...'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => setState(() => showFruits = true),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text('Fruits'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => setState(() => showFruits = false),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text('Vegetables'),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: TextField(
              onChanged: (value) => setState(() => searchQuery = value),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search for a fruit or vegetable...',
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.white10,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Text(
              showFruits
                  ? 'Fruits and Their Prices'
                  : 'Vegetables and Their Prices',
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.greenAccent)),
          const SizedBox(height: 10),
          Table(
            border: TableBorder.all(color: Colors.white30),
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(2),
              3: FlexColumnWidth(3),
            },
            children: [
              const TableRow(children: [
                Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Name',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Price',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Season',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Benefit',
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ]),
              ...filteredItems.map((item) => TableRow(children: [
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(item['name']!)),
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(item['price']!)),
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(item['season']!)),
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(item['benefit']!)),
                  ]))
            ],
          ),
          const SizedBox(height: 30),
          const Text('Price Trends (Sample)',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.greenAccent)),
          const SizedBox(height: 10),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, _) {
                        const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May'];
                        return Text(months[value.toInt() % months.length]);
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: true),
                lineBarsData: [
                  LineChartBarData(
                    spots: showFruits
                        ? [
                            FlSpot(0, 150),
                            FlSpot(1, 160),
                            FlSpot(2, 155),
                            FlSpot(3, 165),
                            FlSpot(4, 170)
                          ]
                        : [
                            FlSpot(0, 40),
                            FlSpot(1, 42),
                            FlSpot(2, 38),
                            FlSpot(3, 45),
                            FlSpot(4, 50)
                          ],
                    isCurved: true,
                    barWidth: 3,
                    color:
                        showFruits ? Colors.greenAccent : Colors.orangeAccent,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Center(
              child: Text('© 2025 Kisan Connect. All rights reserved.')),
        ],
      ),
    );
  }

  Widget _sectionBox(String title, String content) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 20, color: Colors.greenAccent)),
          const SizedBox(height: 8),
          Text(content),
        ],
      ),
    );
  }
}

class EquipmentViewScreen extends StatefulWidget {
  const EquipmentViewScreen({super.key});

  @override
  State<EquipmentViewScreen> createState() => _EquipmentViewScreenState();
}

class _EquipmentViewScreenState extends State<EquipmentViewScreen> {
  final List<EquipmentItem> items = [
    EquipmentItem('What is the best tractor for small-scale farming?',
        'Compact tractors like the John Deere 1025R or Kubota BX Series are popular choices. They combine reliability with flexible attachments and are designed for small acreage or hobby farms.'),
    EquipmentItem('How do I maintain my agricultural tools?',
        'Keep your tools clean after each use, oil any moving parts, and store them in a cool, dry space. Regular maintenance ensures longevity and optimal performance.'),
    EquipmentItem('What is the lifespan of a plowing blade?',
        'Plowing blades last between 3 to 5 years under regular use. Their durability depends on soil type, operational care, and timely inspections for wear and tear.'),
    EquipmentItem('Can I use the same equipment for different crops?',
        'Yes, many machines are designed for versatility. However, adjustments or recalibrations may be necessary to meet the requirements of specific crops.'),
    EquipmentItem(
        'What safety precautions should I take when using power tools?',
        'Always wear protective gear such as gloves, goggles, and boots. Avoid distractions, follow the manufacturer\'s guide, and inspect the tools before every use.'),
    EquipmentItem('How often should I service my tractor?',
        'Tractors need servicing every 200-250 operational hours or once annually. Routine checks include oil changes, belt inspections, and filter replacements.'),
    EquipmentItem('What is the best way to sharpen a sickle or scythe?',
        'Use a fine-grit sharpening stone and maintain consistent blade angles. Regular sharpening after each use ensures precise and efficient cuts in the field.'),
    EquipmentItem('Are electric tools better than manual ones for gardening?',
        'Electric tools save time and reduce effort in larger tasks, but manual tools often offer better control. Choose based on the specific demands of your gardening project.'),
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredItems = items
        .where((item) =>
            item.question.toLowerCase().contains(searchQuery.toLowerCase()) ||
            item.answer.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Equipment FAQ's",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  onChanged: (value) => setState(() => searchQuery = value),
                  decoration: InputDecoration(
                    hintText: 'Search FAQs...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ...filteredItems.asMap().entries.map((entry) => ExpansionTile(
                      title: Text(
                        '${entry.key + 1}. ${entry.value.question}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      collapsedBackgroundColor: Colors.green,
                      backgroundColor: Colors.green.shade700,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            entry.value.answer,
                            style: const TextStyle(color: Colors.black),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EquipmentItem {
  final String question;
  final String answer;

  EquipmentItem(this.question, this.answer);
}

class CropsViewScreen extends StatefulWidget {
  const CropsViewScreen({super.key});

  @override
  State<CropsViewScreen> createState() => _CropsViewScreenState();
}

class _CropsViewScreenState extends State<CropsViewScreen> {
  final List<CropsItem> faqItems = [
    CropsItem(
        category: 'Buyers',
        question: 'What crops are available on the website?',
        answer:
            'We offer a variety of crops, including fruits (mangoes, apples), vegetables (potatoes, tomatoes), dairy products, poultry products, and exotic vegetables like broccoli and lettuce.'),
    CropsItem(
        category: 'Buyers',
        question: 'How do I place an order?',
        answer:
            'To place an order, browse through our product catalog, add items to your cart, and proceed to checkout with your shipping and payment details.'),
    CropsItem(
        category: 'Buyers',
        question: 'Are products on the website organic?',
        answer:
            'We provide both organic and non-organic options. Organic products are clearly labeled, and you can filter for them in the product catalog.'),
    CropsItem(
        category: 'Buyers',
        question: 'What if I receive damaged or low-quality produce?',
        answer:
            'If you receive damaged or unsatisfactory produce, please contact customer support within 24 hours of delivery. We offer refunds or replacements.'),
    CropsItem(
        category: 'Buyers',
        question: 'Do you deliver nationwide?',
        answer:
            'Yes, we deliver across India. Delivery times vary based on location and product type. Estimated delivery dates are provided at checkout.'),
    CropsItem(
        category: 'Farmers',
        question: 'How do I list my crops on the website?',
        answer:
            'To list your crops, create a farmer account, upload details about your produce, including type, quantity, and price, and wait for approval from our team.'),
    CropsItem(
        category: 'Farmers',
        question: 'Are there any fees for selling on this platform?',
        answer:
            'We charge a small commission on each sale. There are no upfront fees for listing your products, and detailed terms are shared during onboarding.'),
    CropsItem(
        category: 'Farmers',
        question: 'How will I get paid for my sales?',
        answer:
            'Payments are made directly to your registered bank account within 7 days of successful delivery and customer satisfaction.'),
    CropsItem(
        category: 'Farmers',
        question: 'What kind of crops are in high demand?',
        answer:
            'Fruits like mangoes and apples, vegetables like tomatoes and potatoes, and exotic vegetables like lettuce are often in high demand across markets.'),
    CropsItem(
        category: 'Farmers',
        question: 'Can I connect with buyers directly?',
        answer:
            'Yes, our platform facilitates communication between buyers and farmers through a secure messaging feature for any queries or custom orders.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                const Text('Buyer and Farmer FAQs',
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                const SizedBox(height: 20),
                ..._buildFAQSections(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFAQSections() {
    final buyerFAQs =
        faqItems.where((item) => item.category == 'Buyers').toList();
    final farmerFAQs =
        faqItems.where((item) => item.category == 'Farmers').toList();

    return [
      _buildCategorySection('FAQs for Buyers', buyerFAQs),
      const SizedBox(height: 20),
      _buildCategorySection('FAQs for Farmers', farmerFAQs),
    ];
  }

  Widget _buildCategorySection(String title, List<CropsItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(title,
              style: const TextStyle(fontSize: 18, color: Colors.white)),
        ),
        const SizedBox(height: 10),
        ...items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 12),
            backgroundColor: Colors.green.shade700,
            collapsedBackgroundColor: Colors.green,
            collapsedTextColor: Colors.white,
            textColor: Colors.white,
            title: Text('${index + 1}. ${item.question}',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(item.answer,
                    style: const TextStyle(color: Colors.black)),
              )
            ],
          );
        })
      ],
    );
  }
}

class CropsItem {
  final String category;
  final String question;
  final String answer;

  CropsItem({
    required this.category,
    required this.question,
    required this.answer,
  });
}

class ProduceFAQScreen extends StatefulWidget {
  const ProduceFAQScreen({super.key});

  @override
  State<ProduceFAQScreen> createState() => _ProduceFAQScreenState();
}

class _ProduceFAQScreenState extends State<ProduceFAQScreen> {
  final List<Map<String, String>> faqData = [
    {
      'question': 'What is the best tractor for small-scale farming?',
      'answer':
          'Compact tractors like the John Deere 1025R or Kubota BX Series are great options.'
    },
    {
      'question': 'How do I maintain my agricultural tools?',
      'answer':
          'Clean tools after every use, store them in a dry place, and regularly oil moving parts to prevent rust.'
    },
    {
      'question': 'What is the lifespan of a plowing blade?',
      'answer':
          'A plowing blade typically lasts 3-5 years, depending on soil conditions and usage.'
    },
    {
      'question': 'Can I use the same equipment for different crops?',
      'answer':
          'Yes, many tools are versatile, but ensure they are properly adjusted to suit the crop requirements.'
    },
    {
      'question':
          'What safety precautions should I take when using power tools?',
      'answer':
          'Always wear protective gear, follow manufacturer instructions, and inspect tools for damage before use.'
    },
    {
      'question': 'How often should I service my tractor?',
      'answer':
          'Tractors should be serviced every 200-250 hours of use or annually, whichever comes first.'
    },
    {
      'question': 'What is the best way to sharpen a sickle or scythe?',
      'answer':
          'Use a sharpening stone or file, maintaining a consistent angle, and hone the edge regularly during use.'
    },
    {
      'question': 'Are electric tools better than manual ones for gardening?',
      'answer':
          'Electric tools are more efficient for larger tasks, while manual tools offer more precision and control for delicate work.'
    },
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredData = faqData.where((faq) {
      final query = searchQuery.toLowerCase();
      return faq['question']!.toLowerCase().contains(query) ||
          faq['answer']!.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0d091e),
        title: Row(
          children: [
            Image.asset('assets/logo.png.jpg', width: 35),
            const SizedBox(width: 8),
            const Text('Kisan Connect'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child:
                const Text('About Us', style: TextStyle(color: Colors.amber)),
          ),
          TextButton(
            onPressed: () {},
            child:
                const Text('Contact Us', style: TextStyle(color: Colors.amber)),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Center(
            child: Text(
              "Fresh Produce FAQ's",
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            onChanged: (value) => setState(() => searchQuery = value),
            decoration: InputDecoration(
              hintText: 'Search FAQs...',
              filled: true,
              fillColor: Colors.white10,
              prefixIcon: const Icon(Icons.search, color: Colors.white54),
              hintStyle: const TextStyle(color: Colors.white54),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 20),
          ...filteredData.asMap().entries.map((entry) {
            final index = entry.key;
            final faq = entry.value;
            return ExpansionTile(
              collapsedBackgroundColor: Colors.green,
              backgroundColor: Colors.green.shade700,
              collapsedTextColor: Colors.white,
              textColor: Colors.white,
              title: Text(
                '${index + 1}. ${faq['question']}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.white,
                  child: Text(
                    faq['answer']!,
                    style: const TextStyle(color: Colors.black),
                  ),
                )
              ],
            );
          }),
        ],
      ),
    );
  }
}

class BuyerDashboardPage extends StatelessWidget {
  final List<Map<String, dynamic>> dashboardItems = [
    {"icon": Icons.apple, "title": "Organic Fruits"},
    {"icon": Icons.car_rental, "title": "Fresh Vegetables"},
    {"icon": Icons.local_drink, "title": "Dairy Products"},
    {"icon": Icons.egg, "title": "Poultry Products"},
    {"icon": Icons.local_fire_department, "title": "Exotic Vegetables"},
  ];

  final List<Map<String, String>> testimonials = [
    {
      "quote":
          "Kisan Connect has transformed my shopping experience. The quality of produce is exceptional!",
      "author": "— Prabhas, Buyer"
    },
    {
      "quote":
          "I love the convenience of ordering fresh fruits and vegetables online. Highly recommend!",
      "author": "— Krishna Babu, Customer"
    },
    {
      "quote":
          "The support from Kisan Connect has been invaluable. They truly care about customers!",
      "author": "— Jason Desabathula, Buyer"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0d091e),
        title: Row(
          children: [
            Image.asset("assets/logo.png.jpg", width: 35),
            const SizedBox(width: 8),
            const Text("Kisan Connect")
          ],
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => AboutUsPage()));
              },
              child: const Text("About Us",
                  style: TextStyle(color: Colors.white))),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ContractDetailsScreen()));
              },
              child: const Text("Guidelines",
                  style: TextStyle(color: Colors.white))),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.person, color: Colors.white),
            label:
                const Text("My Profile", style: TextStyle(color: Colors.white)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 50),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0aed61), Color(0x0606b26a)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: const [
                  Text("Welcome to Kisan Connect",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text("Empowering Buyers with Quality Produce",
                      style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for anything...',
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  const Text("Buyer Dashboard",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    alignment: WrapAlignment.center,
                    children: dashboardItems.map((item) {
                      return SizedBox(
                        width: isMobile ? width * 0.8 : width * 0.4,
                        height: 150,
                        child: GestureDetector(
                          onTap: () {
                            if (item['title'] == 'Organic Fruits') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          OrganicFruitMarketplace()));
                            } else if (item['title'] == 'Fresh Vegetables') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          FreshVegetablesMarketplace()));
                            } else if (item['title'] == 'Dairy Products') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          OrganicDairyMarketplace()));
                            } else if (item['title'] == 'Poultry Products') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => PoultryMarketplace()));
                            } else if (item['title'] == 'Exotic Vegetables') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          ExoticVegetablesMarketplace()));
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: const LinearGradient(
                                colors: [Color(0xFF38ef7d), Color(0xFF11998e)],
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10,
                                  offset: Offset(2, 4),
                                )
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(item['icon'],
                                    size: 40, color: Colors.white),
                                const SizedBox(height: 10),
                                Text(item['title'],
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Container(
              color: const Color(0xFF2c2c2c),
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
              child: Column(
                children: [
                  const Text("Testimonials",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  ...testimonials.map((t) => Column(
                        children: [
                          Text("\"${t['quote']}\"",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 16, fontStyle: FontStyle.italic)),
                          const SizedBox(height: 5),
                          Text(t['author']!,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 20),
                        ],
                      )),
                ],
              ),
            ),
            Container(
              color: const Color(0xFF0d091e),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: const [
                  Text("© 2025 Kisan Connect. All rights reserved.",
                      textAlign: TextAlign.center),
                  SizedBox(height: 5),
                  Text(
                      "Customer Support: 1800 267 0997 | Email: customercare@kisanconnect.in",
                      textAlign: TextAlign.center),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OrganicFruitMarketplace extends StatelessWidget {
  final List<Map<String, dynamic>> fruits = [
    {
      'id': 1,
      'name': 'Mangoes',
      'variety': 'Alphonso',
      'season': 'March-June',
      'description':
          'Premium Alphonso mangoes known for their rich, sweet taste and vibrant golden color.',
      'image': 'assets/mango.jpg',
      'farmers': [
        {
          'name': 'Rajesh Kumar',
          'location': 'Ratnagiri, Maharashtra',
          'quantity': '500 kg available',
          'rating': 4.8
        },
        {
          'name': 'Suresh Patel',
          'location': 'Valsad, Gujarat',
          'quantity': '800 kg available',
          'rating': 4.6
        },
      ],
    },
    {
      'id': 2,
      'name': 'Apples',
      'variety': 'Kinnaur',
      'season': 'September-December',
      'description':
          'Sweet and crispy apples from the hills of Himachal Pradesh.',
      'image': 'assets/apple.jpg',
      'farmers': [
        {
          'name': 'Vikram Singh',
          'location': 'Kinnaur, Himachal Pradesh',
          'quantity': '1000 kg available',
          'rating': 4.9
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;

    return Scaffold(
      backgroundColor: Color(0xFF141414),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Organic Fruit Marketplace'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Column(
              children: const [
                SizedBox(height: 20),
                Text(
                  'Connect directly with farmers for fresh, organic fruits',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          // Search Bar
          Row(
            children: [
              Expanded(
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFF1a1a1a),
                    hintText: 'Search for fruits...',
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.search, color: Colors.greenAccent),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          // Fruit Grid
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: fruits.map((fruit) {
              return GestureDetector(
                onTap: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Color(0xFF1a1a1a),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (_) => FruitDetailSheet(fruit: fruit),
                ),
                child: Container(
                  width: isMobile ? width * 0.9 : width * 0.42,
                  decoration: BoxDecoration(
                    color: Color(0xFF1a1a1a),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black45,
                        blurRadius: 10,
                        offset: Offset(2, 4),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(15)),
                        child: Image.asset(
                          fruit['image'],
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(fruit['name'],
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.greenAccent,
                                    fontWeight: FontWeight.bold)),
                            Text("Variety: ${fruit['variety']}",
                                style: TextStyle(color: Colors.grey)),
                            Text("Season: ${fruit['season']}",
                                style: TextStyle(color: Colors.grey)),
                            SizedBox(height: 5),
                            Text("${fruit['farmers'].length} Farmers Available",
                                style: TextStyle(color: Colors.green))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}

class FruitDetailSheet extends StatelessWidget {
  final Map<String, dynamic> fruit;

  const FruitDetailSheet({required this.fruit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              fruit['image'],
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          Text(fruit['name'],
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.greenAccent,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text("Variety: ${fruit['variety']}",
              style: TextStyle(color: Colors.white70)),
          Text("Season: ${fruit['season']}",
              style: TextStyle(color: Colors.white70)),
          Text("Description: ${fruit['description']}",
              style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 20),
          Text("Available Farmers",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ...fruit['farmers'].map<Widget>((farmer) => Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFF1a1a1a),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade700),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(farmer['name'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.greenAccent)),
                    Text("Location: ${farmer['location']}",
                        style: TextStyle(color: Colors.white70)),
                    Text("Quantity: ${farmer['quantity']}",
                        style: TextStyle(color: Colors.white70)),
                    Row(
                      children: [
                        Text("Rating: ",
                            style: TextStyle(color: Colors.white70)),
                        Row(
                          children: List.generate(
                            (farmer['rating']).round(),
                            (index) =>
                                Icon(Icons.star, color: Colors.amber, size: 16),
                          ),
                        ),
                        SizedBox(width: 5),
                        Text("${farmer['rating']}",
                            style: TextStyle(color: Colors.white70))
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.greenAccent,
                          ),
                          child: Text("Chat",
                              style: TextStyle(color: Colors.black)),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => MakeDealPopup()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                          ),
                          child: Text("Make a Deal"),
                        ),
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

class MakeDealPopup extends StatefulWidget {
  @override
  _MakeDealPopupState createState() => _MakeDealPopupState();
}

class _MakeDealPopupState extends State<MakeDealPopup> {
  final _formKey = GlobalKey<FormState>();
  String? _crop;
  DateTime? _fromDate;
  DateTime? _toDate;
  String? _buyerName;
  String? _contact;
  String? _unit = 'kg';
  String? _quantity;
  bool _submitted = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    return Scaffold(
      backgroundColor: Colors.black54,
      body: Center(
        child: Container(
          width: isMobile ? width * 0.95 : 500,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text('Propose a Deal',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      DropdownButtonFormField<String>(
                        value: _crop,
                        hint: Text('Select a crop'),
                        items: ['Wheat', 'Rice', 'Corn', 'Soybean']
                            .map((crop) => DropdownMenuItem(
                                  value: crop,
                                  child: Text(crop),
                                ))
                            .toList(),
                        onChanged: (value) => setState(() => _crop = value),
                        validator: (value) =>
                            value == null ? 'Please select a crop' : null,
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('From'),
                                TextFormField(
                                  readOnly: true,
                                  decoration:
                                      InputDecoration(hintText: 'Start Date'),
                                  onTap: () async {
                                    DateTime? picked = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2100));
                                    if (picked != null) {
                                      setState(() => _fromDate = picked);
                                    }
                                  },
                                  controller: TextEditingController(
                                      text: _fromDate == null
                                          ? ''
                                          : _fromDate!
                                              .toLocal()
                                              .toString()
                                              .split(' ')[0]),
                                  validator: (value) =>
                                      value == '' ? 'Select start date' : null,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('To'),
                                TextFormField(
                                  readOnly: true,
                                  decoration:
                                      InputDecoration(hintText: 'End Date'),
                                  onTap: () async {
                                    DateTime? picked = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2100));
                                    if (picked != null) {
                                      if (_fromDate != null &&
                                          picked.isBefore(_fromDate!)) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'End date must be after start date')));
                                        return;
                                      }
                                      setState(() => _toDate = picked);
                                    }
                                  },
                                  controller: TextEditingController(
                                      text: _toDate == null
                                          ? ''
                                          : _toDate!
                                              .toLocal()
                                              .toString()
                                              .split(' ')[0]),
                                  validator: (value) =>
                                      value == '' ? 'Select end date' : null,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Buyer Name'),
                        onChanged: (val) => _buyerName = val,
                        validator: (value) =>
                            value!.isEmpty ? 'Please enter buyer name' : null,
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        decoration:
                            InputDecoration(labelText: 'Contact Information'),
                        onChanged: (val) => _contact = val,
                        validator: (value) =>
                            value!.isEmpty ? 'Please enter contact info' : null,
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration:
                                  InputDecoration(labelText: 'Quantity'),
                              onChanged: (val) => _quantity = val,
                              validator: (value) =>
                                  value!.isEmpty ? 'Enter quantity' : null,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 1,
                            child: DropdownButtonFormField<String>(
                              value: _unit,
                              items: ['kg', 'tons', 'quintals']
                                  .map((unit) => DropdownMenuItem(
                                        value: unit,
                                        child: Text(unit),
                                      ))
                                  .toList(),
                              onChanged: (val) => setState(() => _unit = val),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          minimumSize: Size(200, 50),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() => _submitted = true);
                            Future.delayed(Duration(seconds: 2), () {
                              setState(() => _submitted = false);
                              _formKey.currentState!.reset();
                              _crop = null;
                              _fromDate = null;
                              _toDate = null;
                              _buyerName = null;
                              _contact = null;
                              _quantity = null;
                              _unit = 'kg';
                            });
                          }
                        },
                        child: Text('PROPOSE A DEAL'),
                      ),
                      if (_submitted)
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            'Deal proposed successfully! The farmer has been notified.',
                            style: TextStyle(color: Colors.green),
                            textAlign: TextAlign.center,
                          ),
                        )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FreshVegetablesMarketplace extends StatelessWidget {
  final List<Map<String, dynamic>> vegetables = [
    {
      'id': 1,
      'name': 'Tomatoes',
      'variety': 'Roma',
      'season': 'Year-round',
      'description': 'Fresh Roma tomatoes, perfect for sauces and salads.',
      'image': 'assets/tomato.jpg',
      'farmers': [
        {
          'name': 'Anil Sharma',
          'location': 'Pune, Maharashtra',
          'quantity': '300 kg available',
          'rating': 4.7,
        }
      ]
    },
    {
      'id': 2,
      'name': 'Carrots',
      'variety': 'Nantes',
      'season': 'November-March',
      'description': 'Crunchy and sweet Nantes carrots, ideal for snacking.',
      'image': 'assets/carrots.jpg',
      'farmers': [
        {
          'name': 'Ravi Kumar',
          'location': 'Indore, Madhya Pradesh',
          'quantity': '500 kg available',
          'rating': 4.8,
        }
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;

    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Fresh Vegetables Marketplace'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  'Connect directly with farmers for fresh, organic vegetables',
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFF1a1a1a),
                          hintText: 'Search for vegetables...',
                          hintStyle: TextStyle(color: Colors.grey),
                          prefixIcon:
                              Icon(Icons.search, color: Colors.greenAccent),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: vegetables.map((veg) {
                    return GestureDetector(
                      onTap: () => showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: const Color(0xFF1a1a1a),
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (_) => VegetableDetailSheet(vegetable: veg),
                      ),
                      child: Container(
                        width: isMobile ? width * 0.9 : width * 0.42,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1a1a1a),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black45,
                              blurRadius: 10,
                              offset: Offset(2, 4),
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(15)),
                              child: Image.asset(
                                veg['image'],
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(veg['name'],
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.greenAccent,
                                          fontWeight: FontWeight.bold)),
                                  Text("Variety: ${veg['variety']}",
                                      style:
                                          const TextStyle(color: Colors.grey)),
                                  Text("Season: ${veg['season']}",
                                      style:
                                          const TextStyle(color: Colors.grey)),
                                  const SizedBox(height: 5),
                                  Text(
                                      "${veg['farmers'].length} Farmers Available",
                                      style:
                                          const TextStyle(color: Colors.green))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class VegetableDetailSheet extends StatelessWidget {
  final Map<String, dynamic> vegetable;

  const VegetableDetailSheet({required this.vegetable});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              vegetable['image'],
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          Text(vegetable['name'],
              style: const TextStyle(
                  fontSize: 24,
                  color: Colors.greenAccent,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text("Variety: ${vegetable['variety']}",
              style: const TextStyle(color: Colors.white70)),
          Text("Season: ${vegetable['season']}",
              style: const TextStyle(color: Colors.white70)),
          Text("Description: ${vegetable['description']}",
              style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 20),
          const Text("Available Farmers",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ...vegetable['farmers'].map<Widget>((farmer) => Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1a1a1a),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade700),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(farmer['name'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.greenAccent)),
                    Text("Location: ${farmer['location']}",
                        style: const TextStyle(color: Colors.white70)),
                    Text("Quantity: ${farmer['quantity']}",
                        style: const TextStyle(color: Colors.white70)),
                    Row(
                      children: [
                        const Text("Rating: ",
                            style: TextStyle(color: Colors.white70)),
                        Row(
                          children: List.generate(
                            (farmer['rating']).round(),
                            (index) => const Icon(Icons.star,
                                color: Colors.amber, size: 16),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text("${farmer['rating']}",
                            style: const TextStyle(color: Colors.white70))
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.greenAccent,
                          ),
                          child: const Text("Chat",
                              style: TextStyle(color: Colors.black)),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => MakeDealPopup()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                          ),
                          child: const Text("Make a Deal"),
                        ),
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

class OrganicDairyMarketplace extends StatelessWidget {
  final List<Map<String, dynamic>> dairyItems = [
    {
      'id': 1,
      'name': 'Milk',
      'variety': 'Full Cream',
      'season': 'Year-round',
      'description':
          'Fresh, full cream milk from organic cows, rich in nutrients.',
      'image': 'assets/milk.jpg',
      'farmers': [
        {
          'name': 'Rajesh Kumar',
          'location': 'Nasik, Maharashtra',
          'quantity': '1000 liters available',
          'rating': 4.8
        },
        {
          'name': 'Suresh Patel',
          'location': 'Valsad, Gujarat',
          'quantity': '800 liters available',
          'rating': 4.6
        },
      ]
    },
    {
      'id': 2,
      'name': 'Paneer',
      'variety': 'Freshly made',
      'season': 'Year-round',
      'description': 'Fresh and soft paneer, perfect for cooking and snacks.',
      'image': 'assets/paneer.jpg',
      'farmers': [
        {
          'name': 'Vikram Singh',
          'location': 'Kinnaur, Himachal Pradesh',
          'quantity': '500 kg available',
          'rating': 4.9
        },
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;

    return Scaffold(
      backgroundColor: Color(0xFF141414),
      appBar: AppBar(
        backgroundColor: Color(0xFF0d091e),
        title: const Text('Dairy Products'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          const Text(
            'Connect directly with farmers for fresh, organic dairy products',
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFF1a1a1a),
                    hintText: 'Search for dairy products...',
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.search, color: Colors.greenAccent),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: dairyItems.map((item) {
              return GestureDetector(
                onTap: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Color(0xFF1a1a1a),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (_) => DairyDetailSheet(dairy: item),
                ),
                child: Container(
                  width: isMobile ? width * 0.9 : width * 0.42,
                  decoration: BoxDecoration(
                    color: Color(0xFF1a1a1a),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black45,
                        blurRadius: 10,
                        offset: Offset(2, 4),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(15)),
                        child: Image.asset(
                          item['image'],
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item['name'],
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.greenAccent,
                                    fontWeight: FontWeight.bold)),
                            Text("Variety: ${item['variety']}",
                                style: TextStyle(color: Colors.grey)),
                            Text("Season: ${item['season']}",
                                style: TextStyle(color: Colors.grey)),
                            SizedBox(height: 5),
                            Text("${item['farmers'].length} Farmers Available",
                                style: TextStyle(color: Colors.green))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}

class DairyDetailSheet extends StatelessWidget {
  final Map<String, dynamic> dairy;

  const DairyDetailSheet({required this.dairy});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              dairy['image'],
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          Text(dairy['name'],
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.greenAccent,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text("Variety: ${dairy['variety']}",
              style: TextStyle(color: Colors.white70)),
          Text("Season: ${dairy['season']}",
              style: TextStyle(color: Colors.white70)),
          Text("Description: ${dairy['description']}",
              style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 20),
          Text("Available Farmers",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ...dairy['farmers'].map<Widget>((farmer) => Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFF1a1a1a),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade700),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(farmer['name'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.greenAccent)),
                    Text("Location: ${farmer['location']}",
                        style: TextStyle(color: Colors.white70)),
                    Text("Quantity: ${farmer['quantity']}",
                        style: TextStyle(color: Colors.white70)),
                    Row(
                      children: [
                        Text("Rating: ",
                            style: TextStyle(color: Colors.white70)),
                        Row(
                          children: List.generate(
                            (farmer['rating']).round(),
                            (index) =>
                                Icon(Icons.star, color: Colors.amber, size: 16),
                          ),
                        ),
                        SizedBox(width: 5),
                        Text("${farmer['rating']}",
                            style: TextStyle(color: Colors.white70))
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.greenAccent),
                          child: Text("Chat",
                              style: TextStyle(color: Colors.black)),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => MakeDealPopup()));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent),
                          child: Text("Make a Deal"),
                        ),
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

class PoultryMarketplace extends StatelessWidget {
  final List<Map<String, dynamic>> poultryItems = [
    {
      'id': 1,
      'name': 'Chicken Meat',
      'variety': 'Broiler',
      'season': 'Available year-round',
      'image': 'assets/chicken.jpg',
      'description': 'Fresh broiler chicken meat sourced from certified farms.',
      'farmers': [
        {
          'name': 'Ramesh Gupta',
          'location': 'Pune, Maharashtra',
          'quantity': '300 kg available',
          'rating': 4.7
        },
        {
          'name': 'Anita Sharma',
          'location': 'Jaipur, Rajasthan',
          'quantity': '200 kg available',
          'rating': 4.8
        }
      ]
    },
    {
      'id': 2,
      'name': 'Eggs',
      'variety': 'Organic',
      'season': 'Available year-round',
      'image': 'assets/eggs.jpg',
      'description': 'Organic eggs from free-range hens, rich in nutrients.',
      'farmers': [
        {
          'name': 'Amit Khanna',
          'location': 'Bangalore, Karnataka',
          'quantity': '1000 units available',
          'rating': 4.9
        }
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;

    return Scaffold(
      backgroundColor: Color(0xFF141414),
      appBar: AppBar(
        backgroundColor: Color(0xFF0d091e),
        title: const Text('Poultry Marketplace'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          const Text(
            'Connect directly with farmers for fresh, organic poultry products',
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFF1a1a1a),
                    hintText: 'Search for poultry products...',
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.search, color: Colors.greenAccent),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: poultryItems.map((item) {
              return GestureDetector(
                onTap: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Color(0xFF1a1a1a),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (_) => PoultryDetailSheet(poultry: item),
                ),
                child: Container(
                  width: isMobile ? width * 0.9 : width * 0.42,
                  decoration: BoxDecoration(
                    color: Color(0xFF1a1a1a),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black45,
                        blurRadius: 10,
                        offset: Offset(2, 4),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(15)),
                        child: Image.asset(
                          item['image'],
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item['name'],
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.greenAccent,
                                    fontWeight: FontWeight.bold)),
                            Text("Variety: ${item['variety']}",
                                style: TextStyle(color: Colors.grey)),
                            Text("Season: ${item['season']}",
                                style: TextStyle(color: Colors.grey)),
                            SizedBox(height: 5),
                            Text("${item['farmers'].length} Farmers Available",
                                style: TextStyle(color: Colors.green))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}

class PoultryDetailSheet extends StatelessWidget {
  final Map<String, dynamic> poultry;

  const PoultryDetailSheet({required this.poultry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              poultry['image'],
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          Text(poultry['name'],
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.greenAccent,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text("Variety: ${poultry['variety']}",
              style: TextStyle(color: Colors.white70)),
          Text("Season: ${poultry['season']}",
              style: TextStyle(color: Colors.white70)),
          Text("Description: ${poultry['description']}",
              style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 20),
          Text("Available Farmers",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ...poultry['farmers'].map<Widget>((farmer) => Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFF1a1a1a),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade700),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(farmer['name'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.greenAccent)),
                    Text("Location: ${farmer['location']}",
                        style: TextStyle(color: Colors.white70)),
                    Text("Quantity: ${farmer['quantity']}",
                        style: TextStyle(color: Colors.white70)),
                    Row(
                      children: [
                        Text("Rating: ",
                            style: TextStyle(color: Colors.white70)),
                        Row(
                          children: List.generate(
                            (farmer['rating']).round(),
                            (index) =>
                                Icon(Icons.star, color: Colors.amber, size: 16),
                          ),
                        ),
                        SizedBox(width: 5),
                        Text("${farmer['rating']}",
                            style: TextStyle(color: Colors.white70))
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.greenAccent),
                          child: Text("Chat",
                              style: TextStyle(color: Colors.black)),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => MakeDealPopup()));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent),
                          child: Text("Make a Deal"),
                        ),
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

class ExoticVegetablesMarketplace extends StatelessWidget {
  final List<Map<String, dynamic>> vegetablesData = [
    {
      'id': 1,
      'name': 'Broccoli',
      'variety': 'Kinnaur',
      'season': 'April-June',
      'image':
          'https://agricultureguruji.com/wp-content/uploads/2018/08/vegetables-673181_1280.jpg',
      'description': 'A cool-season vegetable rich in vitamins and fiber.',
      'farmers': [
        {
          'name': 'Rajesh Kumar',
          'location': 'Delhi',
          'quantity': '150 kg available',
          'rating': 4.6
        },
        {
          'name': 'Sita Devi',
          'location': 'Madhya Pradesh',
          'quantity': '100 kg available',
          'rating': 4.5
        },
      ]
    },
    {
      'id': 2,
      'name': 'Celery',
      'variety': 'Pascal',
      'season': 'March-June',
      'image':
          'https://media.npr.org/assets/img/2016/06/13/celery_custom-8f0a770aa8a6091316802b63fb7a0f8e9edcc6ec.jpg',
      'description':
          'Pascal celery known for its crisp, flavorful stalks and high-quality yield.',
      'farmers': [
        {
          'name': 'Anil Verma',
          'location': 'Maharashtra',
          'quantity': '200 kg available',
          'rating': 4.8
        },
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0d091e),
        title: const Text('Exotic Vegetables Marketplace'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                    'Connect directly with farmers for fresh, organic exotic vegetables',
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF1a1a1a),
                hintText: 'Search for exotic vegetables...',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.greenAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: vegetablesData
                .map((veg) => _vegetableCard(context, veg, isMobile))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _vegetableCard(
      BuildContext context, Map<String, dynamic> veg, bool isMobile) {
    return GestureDetector(
      onTap: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: const Color(0xFF1a1a1a),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (_) => _vegetableDetailSheet(veg, context),
      ),
      child: Container(
        width: isMobile ? MediaQuery.of(context).size.width * 0.9 : 350,
        decoration: BoxDecoration(
          color: const Color(0xFF1a1a1a),
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 10,
              offset: Offset(2, 4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.network(
                veg['image'],
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(veg['name'],
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.greenAccent,
                          fontWeight: FontWeight.bold)),
                  Text("Variety: ${veg['variety']}",
                      style: const TextStyle(color: Colors.grey)),
                  Text("Season: ${veg['season']}",
                      style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 5),
                  Text("${veg['farmers'].length} Farmers Available",
                      style: const TextStyle(color: Colors.green))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _vegetableDetailSheet(Map<String, dynamic> veg, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              veg['image'],
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          Text(veg['name'],
              style: const TextStyle(
                  fontSize: 24,
                  color: Colors.greenAccent,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text("Variety: ${veg['variety']}",
              style: const TextStyle(color: Colors.white70)),
          Text("Season: ${veg['season']}",
              style: const TextStyle(color: Colors.white70)),
          Text("Description: ${veg['description']}",
              style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 20),
          const Text("Available Farmers",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ...veg['farmers']
              .map<Widget>((farmer) => _farmerCard(context, farmer))
              .toList()
        ],
      ),
    );
  }

  Widget _farmerCard(BuildContext context, Map<String, dynamic> farmer) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1a1a1a),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade700),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(farmer['name'],
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.greenAccent)),
          Text("Location: ${farmer['location']}",
              style: const TextStyle(color: Colors.white70)),
          Text("Quantity: ${farmer['quantity']}",
              style: const TextStyle(color: Colors.white70)),
          Row(
            children: [
              const Text("Rating: ", style: TextStyle(color: Colors.white70)),
              Row(
                children: List.generate(
                  (farmer['rating']).round(),
                  (index) =>
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                ),
              ),
              const SizedBox(width: 5),
              Text("${farmer['rating']}",
                  style: const TextStyle(color: Colors.white70))
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent),
                child:
                    const Text("Chat", style: TextStyle(color: Colors.black)),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => MakeDealPopup()));
                },
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                child: const Text("Make a Deal"),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ContractDetailsScreen extends StatefulWidget {
  @override
  State<ContractDetailsScreen> createState() => _ContractDetailsScreenState();
}

class _ContractDetailsScreenState extends State<ContractDetailsScreen> {
  bool showChat = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;

    return Scaffold(
      backgroundColor: const Color(0xFF111827),
      appBar: AppBar(
        backgroundColor: const Color(0xFF111827),
        elevation: 0,
        title: const Text('Contract Details',
            style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF9FE62C)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(17, 24, 39, 0.95),
                    border: Border.all(color: const Color(0xFF374151)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Color(0xFF374151))),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Rice Supply Contract',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF9FE62C))),
                            IconButton(
                              icon: const Icon(Icons.chat_bubble_outline,
                                  color: Color(0xFF9FE62C)),
                              onPressed: () {
                                setState(() {
                                  showChat = true;
                                });
                              },
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: isMobile
                            ? Column(children: [
                                _buyerInfo(),
                                const SizedBox(height: 24),
                                _contractInfo()
                              ])
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(child: _buyerInfo()),
                                  const SizedBox(width: 24),
                                  Expanded(child: _contractInfo()),
                                ],
                              ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          if (showChat)
            Positioned(
              bottom: 80,
              right: 16,
              child:
                  ChatWidget(onClose: () => setState(() => showChat = false)),
            )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF9FE62C),
        onPressed: () => setState(() => showChat = true),
        child: const Icon(Icons.chat_bubble, color: Color(0xFF111827)),
      ),
    );
  }

  Widget _buyerInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('Buyer Information',
            style: TextStyle(color: Color(0xFF9FE62C), fontSize: 18)),
        SizedBox(height: 16),
        InfoItem(icon: Icons.person, text: 'Name: Sarah Johnson'),
        InfoItem(icon: Icons.access_time, text: 'Status: Active'),
        InfoItem(icon: Icons.calendar_today, text: 'Join Date: 2023-12-01')
      ],
    );
  }

  Widget _contractInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('Contract Details',
            style: TextStyle(color: Color(0xFF9FE62C), fontSize: 18)),
        SizedBox(height: 16),
        InfoItem(text: 'Crop Type: Wheat'),
        InfoItem(text: 'Quantity: 300 tons'),
        InfoItem(text: 'Price: \$350/ton'),
        InfoItem(text: 'Start Date: 2025-01-15'),
        InfoItem(text: 'Duration: 4 months'),
        InfoItem(text: 'Payment Terms: Net 30'),
      ],
    );
  }
}

class InfoItem extends StatelessWidget {
  final IconData? icon;
  final String text;

  const InfoItem({this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 20, color: Color(0xFF9FE62C)),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Text(text, style: const TextStyle(color: Color(0xFFD1D5DB))),
          ),
        ],
      ),
    );
  }
}

class ChatWidget extends StatelessWidget {
  final VoidCallback onClose;

  const ChatWidget({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      constraints: BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 4))
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFF9FE62C),
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Chat with Buyer',
                    style: TextStyle(color: Color(0xFF111827))),
                IconButton(
                  icon: const Icon(Icons.close, color: Color(0xFF111827)),
                  onPressed: onClose,
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            height: 250,
            child: ListView(
              children: const [
                ChatBubble(
                  message:
                      "Hello, I'm interested in discussing the contract details.",
                  isSender: false,
                ),
                ChatBubble(
                  message:
                      "Sure, I'd be happy to discuss. What would you like to know?",
                  isSender: true,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Type your message...',
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: const Color(0xFF1F2937),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF374151)),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSender;

  const ChatBubble({required this.message, required this.isSender});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: isSender ? const Color(0xFF9FE62C) : const Color(0xFF374151),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isSender ? const Color(0xFF111827) : const Color(0xFFD1D5DB),
          ),
        ),
      ),
    );
  }
}
