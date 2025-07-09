import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:convert';
import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmap;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:kisankonect2/l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';
import 'l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

void main() => runApp(KisanConnectApp());

class KisanConnectApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) {
    _KisanConnectAppState? state = context
        .findAncestorStateOfType<_KisanConnectAppState>();
    state?.setLocale(newLocale);
  }

  @override
  _KisanConnectAppState createState() => _KisanConnectAppState();
}

class _KisanConnectAppState extends State<KisanConnectApp> {
  Locale _locale = const Locale('en');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

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
      locale: _locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final stt.SpeechToText _speech = stt.SpeechToText();
  final FlutterTts _tts = FlutterTts();
  final ScrollController _scrollController = ScrollController();

  String selectedLang = 'en';
  String selectedLocale = 'en-US';
  final Map<String, String> languages = {
    'English': 'en-US',
    'Hindi': 'hi-IN',
    'Telugu': 'te-IN',
    'Spanish': 'es-ES',
    'French': 'fr-FR',
  };

  final Map<String, Map<String, String>> faqDataset = {
    "en": {
      "Hi": "Hello! How can I help you today?",
      "Good morning":
          "Good morning! Hope you have a productive day on the farm.",
      "Who are you":
          "I am your farming voice assistant, here to help with your queries.",
      "Your name": "I'm AgriBot, your smart farming guide.",
      "What is organic farming":
          "Organic farming avoids synthetic chemicals and uses natural methods for growing crops.",
      "How to grow tomatoes":
          "Tomatoes grow best in well-drained soil with full sun exposure and regular watering.",
      "What is drip irrigation":
          "Drip irrigation delivers water directly to plant roots, reducing water usage and improving efficiency.",
      "What is precision agriculture":
          "Precision agriculture uses technology to optimize field-level management regarding crop farming.",
      "What is vermicomposting":
          "Vermicomposting is the process of using earthworms to convert organic waste into nutrient-rich compost.",
      "How to protect crops from pests":
          "Use integrated pest management methods like neem oil, crop rotation, and natural predators.",
      "How to test soil fertility":
          "Use a soil testing kit or send a sample to a local agriculture lab.",
      "What crops grow in summer":
          "Crops like maize, sorghum, and millets are well-suited for summer.",
      "What's the weather today":
          "I'm not connected to the internet right now, but usually you can check a weather app.",

      "What is organic farming?":
          "Organic farming is a method of farming that avoids synthetic chemicals and emphasizes natural processes.",
      "How to improve soil fertility?":
          "Add organic matter like compost, practice crop rotation, and use cover crops.",
      "What is crop rotation?":
          "Crop rotation is the practice of growing different types of crops in the same area in sequential seasons.",
      "What are common pests in rice farming?":
          "Stem borers, leaf folders, and brown plant hoppers are common pests in rice farming.",
      "How to conserve water in farming?":
          "Use drip irrigation, rainwater harvesting, and soil mulching.",
      "What is greenhouse farming?":
          "Greenhouse farming involves growing crops under controlled environmental conditions.",
      "What is the best time to sow wheat?":
          "In India, wheat is best sown in November during the Rabi season.",
      "How to prevent plant diseases?":
          "Use resistant varieties, proper spacing, and organic fungicides.",
      "What are biofertilizers?":
          "Biofertilizers are natural fertilizers that contain living microorganisms.",
      "How to store harvested grains safely?":
          "Keep grains dry, use airtight containers, and monitor for pests.",
      "What is hydroponics?":
          "Hydroponics is a method of growing plants in nutrient-rich water without soil.",
      "How to start a poultry farm?":
          "Choose a suitable location, good breed, provide clean water and balanced feed.",
      "What is integrated farming system?":
          "It combines crop production with livestock, fisheries, and poultry to optimize resources.",
      "How can I start beekeeping?":
          "Get bee boxes, place them near flowers, and follow local guidelines.",
      "How to check soil pH?":
          "Use a soil pH meter or testing kit available at agri stores.",
      "What’s your name?": "I’m AgriBot, your voice assistant for farming.",
      "Who made you?": "I was developed to help farmers with their queries.",
      "How can you help me?":
          "I can answer farming questions, provide tips, and more.",
      "Tell me a joke":
          "Why did the scarecrow win an award? Because he was outstanding in his field!",
      "What is AI?":
          "AI stands for Artificial Intelligence, simulating human intelligence in machines.",
      "What is climate change?":
          "Climate change refers to long-term changes in temperature and weather patterns.",
      "What is sustainable farming?":
          "Sustainable farming uses practices that maintain soil health, conserve resources, and ensure long-term productivity.",
      "How to grow rice?":
          "Rice needs flooded fields, fertile soil, and warm temperatures; transplant seedlings for best results.",
      "What is mulching?":
          "Mulching involves covering soil with organic or synthetic materials to retain moisture and suppress weeds.",
      "How to identify nutrient deficiencies in plants?":
          "Look for symptoms like yellow leaves (nitrogen deficiency) or stunted growth (phosphorus deficiency).",
      "What is companion planting?":
          "Companion planting involves growing different crops together to enhance growth or deter pests.",
      "How to start a small vegetable garden?":
          "Choose a sunny spot, prepare fertile soil, and plant seasonal vegetables with regular care.",
      "What is soil erosion?":
          "Soil erosion is the loss of topsoil due to wind, water, or human activity, reducing fertility.",
      "How to use natural fertilizers?":
          "Apply compost, manure, or green manure to enrich soil with nutrients naturally.",
      "What crops grow in winter?":
          "Winter crops include wheat, mustard, and peas, thriving in cooler temperatures.",
      "How to manage weeds?":
          "Use mulching, hand weeding, or organic herbicides to control weeds effectively.",
      "What is aquaponics?":
          "Aquaponics combines fish farming with hydroponics, using fish waste to nourish plants.",
      "How to improve crop yield?":
          "Use quality seeds, maintain soil health, and adopt precision farming techniques.",
      "What is a cover crop?":
          "Cover crops like clover or rye are grown to protect soil and improve its fertility.",
      "How to start organic farming?":
          "Avoid synthetic chemicals, use organic fertilizers, and certify your farm with local authorities.",
      "What is crop diversification?":
          "Crop diversification involves growing a variety of crops to reduce risk and improve soil health.",
      "How to deal with fungal diseases in plants?":
          "Use organic fungicides, ensure proper air circulation, and remove affected plant parts.",
      "What is the role of pollinators in farming?":
          "Pollinators like bees transfer pollen, aiding crop reproduction and increasing yields.",
      "How to store seeds properly?":
          "Store seeds in a cool, dry place in airtight containers to maintain viability.",
      "What is agroforestry?":
          "Agroforestry integrates trees with crops or livestock to enhance productivity and biodiversity.",
      "Can you tell me about drip irrigation benefits?":
          "Drip irrigation saves water, reduces weeds, and delivers nutrients directly to plant roots.",
      "Hello": "Hi there! Ready to assist you with your queries.",
      "Who are you?": "I'm AgriBot, your farming-friendly voice assistant.",
      "What is your name?":
          "My name's AgriBot, here to help with farming tips.",
      "How are you?": "Doing great, thanks! How about you?",
      "What can you do?":
          "I can answer farming questions, share tips, and chat with you.",
      "Good evening": "Good evening! Hope your day went well.",
      "How's the day going?": "My day's full of learning! How's yours?",
      "What is a voice assistant?":
          "A voice assistant is a digital helper that responds to voice commands.",
      "Who created you?":
          "I was built by a team to support farmers and answer queries.",
      "Tell me something interesting":
          "Did you know earthworms improve soil health naturally?",
      "What's the time?":
          "I can't check the time right now, but your clock can help!",
      "Can you tell a joke?":
          "Why did the cow become a speaker? It had a lot to moo about!",
      "What is farming?":
          "Farming is growing crops or raising animals for food and resources.",
      "Thank you": "You're welcome! Always here for you.",
      "How do you work?":
          "I listen to your questions and provide answers using my knowledge base.",
      "Good night": "Good night! Dream of healthy crops and happy farms.",
      "What is technology?":
          "Technology is the use of tools and systems to solve problems or improve life.",
      "Can you sing?": "I can't sing, but I can tell you about crop cycles!",
      "Goodbye": "See you later! Happy farming!",
      "Hi there": "Hello! I'm here to assist with your questions.",
      "Good afternoon": "Good afternoon! Hope your day is going well.",
      "What's your purpose?":
          "I'm AgriBot, designed to help farmers with advice and answers.",
      "Who is AgriBot?": "That's me! Your friendly farming voice assistant.",
      "Are you okay?": "I'm running smoothly, ready to help you out!",
      "What do you know about?":
          "I know about farming, weather tips, and general knowledge.",
      "How's it going?": "All good here! How's your farm doing?",
      "What is a chatbot?":
          "A chatbot is a program that chats with users, like me helping farmers!",
      "Who designed you?":
          "A team of innovators built me to support agriculture.",
      "Tell me something new":
          "Did you know crop diversity can boost soil health?",
      "What's the date today?":
          "It's July 8, 2025. Perfect day for farming plans!",
      "Can you tell a funny story?":
          "Once, a potato tried to join a vegetable choir but kept rolling off the stage!",
      "What is agriculture?":
          "Agriculture is the practice of cultivating crops and raising livestock.",
      "You're welcome": "Thanks for the kind words! I'm here for you.",
      "How do I use you?":
          "Just ASK me questions, and I'll respond with helpful answers.",
      "Have a great day": "Thanks! Wishing you a fruitful day on the farm.",
      "What is innovation?":
          "Innovation is creating new ideas or methods, like smart farming tools.",
      "Can you tell a fun fact?":
          "Bees can pollinate up to 5,000 flowers in a single day!",
      "What’s your favorite thing to do?":
          "I love helping farmers grow better crops!",
      "See you later": "Catch you later! Keep those fields thriving.",
      "Hey there": "Hi! I'm ready to help you with your questions.",
      "Good day": "Good day to you! Hope your farm is thriving.",
      "What are you?":
          "I'm AgriBot, a voice assistant for farmers and curious minds.",
      "Your identity?": "I'm AgriBot, your go-to for farming advice and chats.",
      "Feeling good?": "I'm buzzing like a busy bee! How about you?",
      "What’s your role?":
          "I answer questions, share farming tips, and keep you company.",
      "Nice to meet you": "Great to meet you too! Ready for some farming talk?",
      "What is an AI assistant?":
          "An AI assistant is a smart program that helps with tasks via voice or text.",
      "Who built you?":
          "A team passionate about agriculture created me to assist you.",
      "Share a cool fact":
          "Did you know healthy soil can store more carbon than the air?",
      "What’s today’s date?":
          "It’s July 8, 2025, at 9:48 PM IST. Time to plan your crops!",
      "Tell a silly joke":
          "Why did the carrot blush? It overheard the peas talking about their stew!",
      "What’s cultivation?":
          "Cultivation is preparing land and growing crops for food or resources.",
      "Appreciate it": "My pleasure! Always here to lend a hand.",
      "How can I interact with you?":
          "Just ask me anything, and I’ll reply with helpful info.",
      "Take care": "Thanks! Wishing you bountiful harvests ahead.",
      "What is automation?":
          "Automation uses technology to perform tasks, like irrigation systems in farming.",
      "Got any trivia?": "A single sunflower can produce up to 2,000 seeds!",
      "What do you like?":
          "I enjoy helping you nurture your crops and learn new tricks!",
      "Till next time": "Bye for now! Keep those fields green and growing.",
      "Hey": "Hello! I'm here to assist with your questions.",
      "What is your purpose?":
          "I'm AgriBot, designed to help farmers with advice and answers.",
      "What do you know?":
          "I know about farming, weather tips, and general knowledge.",
      "How's everything going?": "All good here! How's your farm doing?",
      "What’s the date today?":
          "It's July 8, 2025. Perfect day for farming plans!",
      "exit": "have a Good day and keep your fields thriving!",
      "Exit": "have a Good day and keep your fields thriving!",
      "bye": "have a Good day and keep your fields thriving!",
      "Bye": "have a Good day and keep your fields thriving!",
      "Close": "have a Good day and keep your fields thriving!",
    },
    "hi": {
      "नमस्ते": "नमस्ते! मैं आपकी मदद कैसे कर सकता हूँ?",
      "हेलो": "हाय! मैं आपके सवालों के लिए तैयार हूँ।",
      "आप क्या हैं?":
          "मैं एग्रीबॉट हूँ, किसानों और जिज्ञासुओं के लिए एक वॉयस असिस्टेंट।",
      "आपकी पहचान?": "मैं एग्रीबॉट, कृषि सलाह और बातचीत के लिए आपका साथी।",
      "अच्छा महसूस कर रहे हैं?":
          "मैं मधुमक्खी की तरह चहक रहा हूँ! आप कैसे हैं?",
      "आपकी भूमिका क्या है?":
          "मैं सवालों के जवाब देता हूँ, खेती के सुझाव देता हूँ और साथ देता हूँ।",
      "आपसे मिलकर अच्छा लगा":
          "आपसे मिलकर भी खुशी हुई! खेती की बातें करने को तैयार?",
      "एआई असिस्टेंट क्या है?":
          "एआई असिस्टेंट एक स्मार्ट प्रोग्राम है जो आवाज या टेक्स्ट से मदद करता है।",
      "एक शानदार तथ्य बताएं":
          "क्या आप जानते हैं कि स्वस्थ मिट्टी हवा से ज्यादा कार्बन स्टोर कर सकती है?",
      "मज़ेदार चुटकुला सुनाएं":
          "मूली क्यों शरमाई? उसने मटर की स्टू की बात सुनी!",
      "शुक्रिया": "मेरा सौभाग्य! हमेशा मदद के लिए हूँ।",
      "आपके साथ कैसे बात करूँ?":
          "मुझसे कुछ भी पूछें, मैं उपयोगी जानकारी दूँगा।",
      "ध्यान रखें": "शुक्रिया! आपके लिए ढेर सारी फसल की कामना।",
      "ऑटोमेशन क्या है?":
          "ऑटोमेशन तकनीक से कार्य करने की प्रक्रिया है, जैसे खेती में सिंचाई सिस्टम।",
      "कोई ट्रिविया बताएं?": "एक सूरजमुखी 2,000 तक बीज पैदा कर सकता है!",
      "फिर मिलेंगे": "अब के लिए अलविदा! अपने खेतों को हरा-भरा रखें।",
      "हाय": "नमस्ते! मैं आपके सवालों की मदद के लिए हूँ।",
      "शुभ दोपहर": "शुभ दोपहर! आपका दिन अच्छा चल रहा है, आशा है।",
      "आपका उद्देश्य क्या है?":
          "मैं एग्रीबॉट हूँ, किसानों की सलाह और जवाबों के लिए बनाया गया।",
      "एग्रीबॉट कौन है?": "वह मैं हूँ! आपका कृषि सहायक।",
      "क्या आप ठीक हैं?": "मैं पूरी तरह ठीक हूँ, आपकी मदद के लिए तैयार!",
      "आपको क्या पता है?": "मुझे खेती, मौसम सुझाव और सामान्य ज्ञान पता है।",
      "सब कैसा चल रहा है?": "यहाँ सब ठीक है! आपका खेत कैसा है?",
      "चैटबॉट क्या है?":
          "चैटबॉट एक प्रोग्राम है जो उपयोगकर्ताओं से बात करता है, जैसे मैं किसानों से।",
      "आपको किसने डिज़ाइन किया?":
          "मुझे कृषि सहायता के लिए नवप्रवर्तकों की एक टीम ने बनाया।",
      "कुछ नया बताएं":
          "क्या आप जानते हैं कि फसल विविधता मिट्टी को बेहतर बनाती है?",
      "आज की तारीख क्या है?":
          "आज 8 जुलाई 2025 है। खेती की योजना के लिए बढ़िया दिन!",
      "मज़ेदार कहानी सुनाएं":
          "एक बार एक आलू ने सब्जी गायन मंडली में शामिल होने की कोशिश की, लेकिन मंच से लुढ़क गया!",
      "कृषि क्या है?": "कृषि फसल उगाने और पशु पालने की प्रक्रिया है।",
      "आपका स्वागत है": "धन्यवाद! मैं आपके लिए हूँ।",
      "आपको कैसे उपयोग करें?": "बस मुझसे सवाल पूछें, मैं उपयोगी जवाब दूंगा।",
      "शुभ दिन": "धन्यवाद! आपके खेत के लिए शुभकामनाएँ।",
      "नवाचार क्या है?":
          "नवाचार नए विचारों या विधियों का निर्माण है, जैसे स्मार्ट खेती के उपकरण।",
      "मज़ेदार तथ्य बताएं":
          "मधुमक्खियाँ एक दिन में 5,000 फूलों का परागण कर सकती हैं!",
      "आपको क्या पसंद है?":
          "मुझे किसानों को बेहतर फसल उगाने में मदद करना पसंद है!",
      "फिर मिलते हैं": "बाद में मिलेंगे! अपने खेतों को हरा-भरा रखें।",
      "हाय वहाँ": "नमस्ते! मैं आपके सवालों की मदद के लिए यहाँ हूँ।",
      "सुप्रभात": "सुप्रभात! आशा है आपका दिन शुभ और उत्पादक हो।",
      "तुम कौन हो":
          "मैं आपका कृषि सहायक हूँ, जो आपके सवालों के जवाब देने में सक्षम है।",
      "आपका नाम क्या है":
          "मेरा नाम एग्रीबॉट है। मैं आपकी कृषि जानकारी में मदद करता हूँ।",
      "जैविक खेती क्या है":
          "जैविक खेती रासायनिक उर्वरकों के बिना प्राकृतिक तरीकों से की जाती है।",
      "टमाटर कैसे उगाएं":
          "टमाटर को अच्छी जल निकासी वाली मिट्टी और भरपूर धूप की आवश्यकता होती है।",
      "ड्रिप सिंचाई क्या है":
          "ड्रिप सिंचाई में पौधों की जड़ों में सीधे पानी दिया जाता है, जिससे पानी की बचत होती है।",
      "सटीक खेती क्या है":
          "सटीक खेती तकनीक का उपयोग करके फसलों का प्रबंधन और उत्पादन बढ़ाने की विधि है।",
      "वर्मी कम्पोस्टिंग क्या है":
          "यह एक प्रक्रिया है जिसमें केंचुओं का उपयोग करके कचरे को खाद में बदला जाता है।",
      "कीटों से फसलों की रक्षा कैसे करें":
          "नीम तेल, फसल चक्र और प्राकृतिक दुश्मनों का उपयोग करें।",
      "मिट्टी की उर्वरता कैसे जांचें":
          "मिट्टी परीक्षण किट का उपयोग करें या नजदीकी प्रयोगशाला में भेजें।",
      "गर्मियों में कौन सी फसलें उगती हैं":
          "गर्मी में मक्का, बाजरा और ज्वार जैसी फसलें अच्छी होती हैं।",
      "एक मज़ेदार चुटकुला सुनाओ":
          "टमाटर क्यों लाल हो गया? क्योंकि उसने सलाद को बदलते हुए देख लिया!",
      "आज मौसम कैसा है": "मैं ऑफलाइन हूँ, कृपया मौसम ऐप से जानकारी लें।",
      "धन्यवाद": "आपका स्वागत है! खुशहाल खेती करें!",
      "अलविदा": "ख्याल रखना! फिर मिलते हैं।",
      "जैविक खेती क्या है?":
          "जैविक खेती एक ऐसी विधि है जिसमें रासायनिक उर्वरकों का प्रयोग नहीं किया जाता।",
      "मिट्टी की उर्वरता कैसे बढ़ाएं?":
          "कम्पोस्ट डालें, फसल चक्र अपनाएं और हरी खाद का उपयोग करें।",
      "फसल चक्र क्या है?":
          "फसल चक्र एक ही खेत में अलग-अलग मौसम में अलग फसलें उगाने की प्रक्रिया है।",
      "धान की फसल में आम कीट कौन से हैं?":
          "तना छेदक, पत्ती मोड़ने वाले कीट और ब्राउन प्लांट होपर आम हैं।",
      "कृषि में पानी कैसे बचाएं?":
          "ड्रिप सिंचाई, वर्षा जल संचयन और मल्चिंग अपनाएं।",
      "ग्रीनहाउस कृषि क्या है?":
          "नियंत्रित वातावरण में फसलों को उगाना ग्रीनहाउस कृषि कहलाता है।",
      "गेहूं की बुवाई का सबसे अच्छा समय क्या है?":
          "भारत में नवंबर का महीना रबी सीजन के लिए उपयुक्त है।",
      "पौधों के रोगों से कैसे बचाएं?":
          "रोग प्रतिरोधी किस्में, उचित दूरी और जैविक दवाओं का उपयोग करें।",
      "जैव उर्वरक क्या हैं?":
          "ऐसे उर्वरक जिनमें जीवाणु होते हैं और मिट्टी की उर्वरता बढ़ाते हैं।",
      "अनाज को कैसे सुरक्षित रखें?":
          "अनाज को सूखा रखें, एयरटाइट कंटेनर में रखें और कीटों की निगरानी करें।",
      "हाइड्रोपोनिक्स क्या है?":
          "मिट्टी के बिना पोषक जल में पौधों को उगाने की तकनीक।",
      "पोल्ट्री फार्म कैसे शुरू करें?":
          "स्थान चुनें, नस्ल तय करें, साफ पानी और संतुलित आहार दें।",
      "एकीकृत कृषि प्रणाली क्या है?":
          "फसल, पशुपालन, मछली पालन आदि को मिलाकर की गई खेती।",
      "मधुमक्खी पालन कैसे शुरू करें?":
          "मधुमक्खी बक्से खरीदें और फूलों के पास रखें।",
      "मिट्टी का पीएच कैसे जांचें?": "पीएच मीटर या किट का प्रयोग करें।",
      "आपका नाम क्या है?": "मैं एग्रीबॉट हूँ, आपका कृषि सहायक।",
      "आप कैसे हैं?": "मैं ठीक हूँ और आपकी मदद के लिए तैयार हूँ।",
      "आपको किसने बनाया?": "मुझे किसानों की सहायता के लिए बनाया गया है।",
      "आप मेरी कैसे मदद कर सकते हैं?":
          "मैं आपके कृषि सवालों का उत्तर दे सकता हूँ।",
      "एक मज़ेदार चुटकुला सुनाएं":
          "क्यों टमाटर शर्मिंदा हो गया? क्योंकि उसने सलाद को कपड़े बदलते देख लिया!",
      "AI क्या है?":
          "AI का मतलब आर्टिफिशियल इंटेलिजेंस है, जिसमें मशीनें इंसानों की तरह सोचती हैं।",
      "जलवायु परिवर्तन क्या है?":
          "लंबे समय में तापमान और मौसम के पैटर्न में बदलाव।",
      "टिकाऊ खेती क्या है?":
          "टिकाऊ खेती ऐसी प्रथाओं का उपयोग करती है जो मिट्टी को स्वस्थ रखती हैं और संसाधनों का संरक्षण करती हैं।",
      "धान कैसे उगाएं?":
          "धान को बाढ़ वाले खेतों, उपजाऊ मिट्टी और गर्म तापमान की आवश्यकता होती है; रोपाई करें।",
      "मल्चिंग क्या है?":
          "मल्चिंग में मिट्टी को जैविक या कृत्रिम सामग्री से ढकना होता है ताकि नमी बनी रहे।",
      "पौधों में पोषक तत्वों की कमी कैसे पहचानें?":
          "पीले पत्ते (नाइट्रोजन की कमी) या छोटा विकास (फास्फोरस की कमी) जैसे लक्षण देखें।",
      "सह-रोपण क्या है?":
          "सह-रोपण में विभिन्न फसलों को एक साथ उगाया जाता है ताकि कीटों से बचाव हो।",
      "छोटा सब्जी बाग कैसे शुरू करें?":
          "धूप वाली जगह चुनें, उपजाऊ मिट्टी तैयार करें और मौसमी सब्जियां लगाएं।",
      "मृदा अपरदन क्या है?":
          "मृदा अपरदन हवा, पानी या मानवीय गतिविधियों से ऊपरी मिट्टी का नुकसान है।",
      "प्राकृतिक उर्वरकों का उपयोग कैसे करें?":
          "खाद, गोबर या हरी खाद डालकर मिट्टी को पोषक तत्व दें।",
      "सर्दियों में कौन सी फसलें उगती हैं?":
          "सर्दियों में गेहूं, सरसों और मटर अच्छी तरह उगती हैं।",
      "खरपतवारों का प्रबंधन कैसे करें?":
          "मल्चिंग, हाथ से निराई या जैविक जड़ी-बूटी नाशक का उपयोग करें।",
      "एक्वापोनिक्स क्या है?":
          "एक्वापोनिक्स मछली पालन और हाइड्रोपोनिक्स का संयोजन है, जिसमें मछली का कचरा पौधों को पोषक देता है।",
      "फसल की पैदावार कैसे बढ़ाएं?":
          "गुणवत्तापूर्ण बीज, मिट्टी स्वास्थ्य और सटीक खेती तकनीकों का उपयोग करें।",
      "कवर क्रॉप क्या है?":
          "कवर क्रॉप जैसे तिपतिया घास मिट्टी की रक्षा और उर्वरता बढ़ाने के लिए उगाए जाते हैं।",
      "जैविक खेती कैसे शुरू करें?":
          "रासायनिक पदार्थों से बचें, जैविक उर्वरक का उपयोग करें और प्रमाणन लें।",
      "फसल विविधीकरण क्या है?":
          "फसल विविधीकरण में जोखिम कम करने के लिए विभिन्न फसलों को उगाना शामिल है।",
      "पौधों में फंगल रोगों से कैसे निपटें?":
          "जैविक कवकनाशी, हवा का संचार और प्रभावित हिस्सों को हटाएं।",
      "परागणकों की भूमिका क्या है?":
          "मधुमक्खियां परागण करके फसलों की पैदावार बढ़ाती हैं।",
      "बीज कैसे संग्रह करें?":
          "बीजों को ठंडी, सूखी जगह पर हवाबंद डिब्बों में रखें।",
      "एग्रोफोरेस्ट्री क्या है?":
          "एग्रोफोरेस्ट्री में पेड़ों को फसलों या पशुओं के साथ जोड़ा जाता है।",
      "ड्रिप सिंचाई के लाभ क्या हैं?":
          "यह पानी बचाता है, खरपतवार कम करता है और जड़ों तक पोषक तत्व पहुंचाता है।",
      "आप कौन हैं?": "मैं एग्रीबॉट हूँ, आपका कृषि सहायक।",
      "आप क्या कर सकते हैं?":
          "मैं कृषि सवालों के जवाब दे सकता हूँ और बातचीत कर सकता हूँ।",
      "शुभ संध्या": "शुभ संध्या! आपका दिन कैसा रहा?",
      "दिन कैसा चल रहा है?": "मेरा दिन सीखने से भरा है! आपका कैसा है?",
      "वॉयस असिस्टेंट क्या है?":
          "वॉयस असिस्टेंट एक डिजिटल सहायक है जो आवाज के आदेशों का जवाब देता है।",
      "कुछ रोचक बताएं":
          "क्या आप जानते हैं कि केंचुए मिट्टी को प्राकृतिक रूप से बेहतर बनाते हैं?",
      "समय क्या है?": "मैं अभी समय नहीं देख सकता, आपकी घड़ी मदद कर सकती है!",
      "चुटकुला सुनाएं": "गाय ने भाषण क्यों दिया? क्योंकि उसे बहुत कुछ कहना था!",
      "खेती क्या है?": "खेती फसल उगाने या पशु पालने की प्रक्रिया है।",
      "आप कैसे काम करते हैं?":
          "मैं आपके सवाल सुनता हूँ और अपने ज्ञान से जवाब देता हूँ।",
      "शुभ रात्रि": "शुभ रात्रि! स्वस्थ फसलों के सपने देखें।",
      "तकनीक क्या है?": "तकनीक समस्याओं को हल करने के लिए उपकरणों का उपयोग है।",
      "क्या आप गा सकते हैं?": "मैं गा नहीं सकता, लेकिन फसल चक्र बता सकता हूँ!",
    },
    "te": {
      "హలో": "హాయ్! నేను ఎలా సహాయం చేయగలను?",
      "హాయ్": "హాయ్! నీ ప్రశ్నలకు సహాయం చేయడానికి సిద్ధంగా ఉన్నాను。",
      "మధ్యాహ్న శుభాకాంక్షలు":
          "మధ్యాహ్న శుభాకాంక్షలు! నీ రోజు బాగా సాగుతోందని ఆశిస్తున్నాను。",
      "నీ ఉద్దేశ్యం ఏమిటి?":
          "నేను అగ్రిబాట్, రైతులకు సలహాలు ఇవ్వడానికి రూపొందాను。",
      "అగ్రిబాట్ ఎవరు?": "అది నేనే! నీ వ్యవసాయ సహాయకుడు.",
      "నీవు బాగున్నావా?": "నేను బాగానే ఉన్నాను, నీకు సహాయం చేయడానికి సిద్ధం!",
      "సుభ రోజు": "సుభ రోజు! నీ పొలం సమృద్ధిగా ఉందని ఆశిస్తున్నాను。",
      "నీవు ఏమిటి?":
          "నేను అగ్రిబాట్, రైతులు మరియు జిజ్ఞాసువుల కోసం వాయిస్ అసిస్టెంట్.",
      "నీ గుర్తింపు?":
          "నేను అగ్రిబాట్, వ్యవసాయ సలహాలు మరియు సంభాషణల కోసం నీ సహచరుడు.",
      "బాగున్నావా?": "నేను తేనెటీగలా ఝుంగా! నీవు ఎలా ఉన్నావు?",
      "నీ పాత్ర ఏమిటి?":
          "ప్రశ్నలకు సమాధానమిస్తాను, వ్యవసాయ సలహాలు ఇస్తాను, నీకు తోడుగా ఉంటాను。",
      "నిన్ను కలవడం సంతోషం": "నిన్ను కలవడం నాకూ ఆనందం! వ్యవసాయ చర్చకు సిద్ధమా?",
      "ఏఐ అసిస్టెంట్ అంటే ఏమిటి?":
          "ఏఐ అసిస్టెంట్ అనేది వాయిస్ లేదా టెక్స్ట్ ద్వారా సహాయపడే స్మార్ట్ ప్రోగ్రామ్.",
      "నిన్ను ఎవరు నిర్మించారు?":
          "వ్యవసాయం పట్ల మక్కువ ఉన్న బృందం నీ కోసం నన్ను తయారు చేసింది。",
      "ఒక కూల్ ఫ్యాక్ట్ చెప్పు":
          "ఆరోగ్యమైన నేల గాలి కంటే ఎక్కువ కార్బన్ నిల్వ చేయగలదని తెలుసా?",
      "ఈ రోజు తేదీ ఏమిటి?":
          "ఇది జూలై 8, 2025, రాత్రి 9:48 IST. పంటల ప్రణాళిక సమయం!",
      "చిన్న జోక్ చెప్పు":
          "క్యారెట్ ఎందుకు సిగ్గుపడింది? బఠానీలు వాటి స్టూ గురించి మాట్లాడడం వినింది!",
      "సాగు అంటే ఏమిటి?":
          "సాగు అనేది భూమిని సిద్ధం చేసి, ఆహారం లేదా వనరుల కోసం పంటలు పెంచడం.",
      "కృతజ్ఞతలు": "నా ఆనందం! ఎప్పుడూ సహాయం చేస్తాను。",
      "నిన్ను ఎలా సంభాషించాలి?":
          "ఏదైనా అడుగు, నేను ఉపయోగకరమైన సమాచారం ఇస్తాను。",
      "జాగ్రత్త": "ధన్యవాదాలు! నీకు సమృద్ధిగా దిగుబడి కావాలని కోరుకుంటున్నాను。",
      "ఆటోమేషన్ అంటే ఏమిటి?":
          "ఆటోమేషన్ అనేది టెక్నాలజీతో పనులు చేయడం, వ్యవసాయంలో నీటిపారుదల వ్యవస్థల వంటివి。",
      "ట్రివియా చెప్పు":
          "ఒక్క సూర్యకాంతి 2,000 విత్తనాల వరకు ఉత్పత్తి చేయగలదు!",
      "నీకు ఏమి ఇష్టం?":
          "నీ పంటలను పెంచడంలో మరియు కొత్త విద్యలు నేర్పడంలో సహాయపడటం నాకు ఇష్టం!",
      "మళ్లీ కలుద్దాం": "ఇప్పటికి వీడ్కోలు! నీ పొలాలను హరితంగా పెంచు.",
      "నీకు ఏమి తెలుసు?":
          "వ్యవసాయం, వాతావరణ సలహాలు, సాధారణ జ్ఞానం నాకు తెలుసు。",
      "రోజు ఎలా సాగుతోంది?": "ఇక్కడ అంతా బాగుంది! నీ పొలం ఎలా ఉంది?",
      "చాట్‌బాట్ అంటే ఏమిటి?":
          "చాట్‌బాట్ అనేది యూజర్లతో మాట్లాడే ప్రోగ్రామ్, నేను రైతులతో మాట్లాడతాను!",
      "నిన్ను ఎవరు రూపొందించారు?":
          "వ్యవసాయ సహాయం కోసం ఆవిష్కర్తల బృందం నన్ను తయారు చేసింది。",
      "కొత్త విషయం చెప్పు":
          "పంట వైవిధ్యం నేల ఆరోగ్యాన్ని మెరుగుపరుస్తుందని తెలుసా?",
      "హాస్య కథ చెప్పు":
          "ఒక బంగాళదుంప కూరగాయల గాయన బృందంలో చేరాలనుకుంది, కానీ వేదికపై నుండి దొర్లింది!",
      "వ్యవసాయం అంటే ఏమిటి?":
          "వ్యవసాయం అంటే పంటలు పెంచడం మరియు పశువులను పెంచడం.",
      "మీకు స్వాగతం": "ధన్యవాదాలు! నేను నీ కోసం ఇక్కడ ఉన్నాను。",
      "నిన్ను ఎలా ఉపయోగించాలి?":
          "నాకు ప్రశ్నలు అడుగు, నేను సహాయకరమైన సమాధానాలు ఇస్తాను。",
      "మంచి రోజు కావాలి":
          "ధన్యవాదాలు! నీ పొలంలో ఫలవంతమైన రోజు కావాలని కోరుకుంటున్నాను。",
      "ఆవిష్కరణ అంటే ఏమిటి?":
          "ఆవిష్కరణ అంటే కొత్త ఆలోచనలు లేదా పద్ధతుల సృష్టి, స్మార్ట్ ఫార్మింగ్ టూల్స్ వంటివి。",
      "ఫన్ ఫ్యాక్ట్ చెప్పు":
          "తేనెటీగలు ఒక్క రోజులో 5,000 పూలను పరాగసంపర్కం చేయగలవు!",
      "నీకు ఇష్టమైన పని ఏమిటి?":
          "రైతులకు మంచి పంటలు పెంచడంలో సహాయం చేయడం నాకు ఇష్టం!",
      "శుభోదయం": "శుభోదయం! మీ రోజంతా సంతోషంగా సాగాలని ఆశిస్తున్నాను.",
      "మీరు ఎవరు": "నేను మీ వ్యవసాయ సహాయకుడు, మీ ప్రశ్నలకు సమాధానాలు ఇస్తాను.",
      "మీ పేరు ఏమిటి": "నా పేరు అగ్రిబాట్. నేను మీకు వ్యవసాయ సలహా అందిస్తాను.",
      "ఆర్గానిక్ ఫార్మింగ్ అంటే ఏమిటి":
          "ఆర్గానిక్ వ్యవసాయంలో రసాయనాల్ని కాకుండా సహజ పదార్థాలను వాడతారు.",
      "టమోటాలు ఎలా పెంచాలి":
          "టమోటాలు మంచి నీటి పారుదల గల మట్టిలో మరియు ఎక్కువ సూర్యకాంతితో బాగా పెరుగుతాయి.",
      "డ్రిప్ ఇరిగేషన్ అంటే ఏమిటి":
          "డ్రిప్ ఇరిగేషన్ అనేది మొక్కల రూట్స్‌కి నేరుగా నీటిని అందించే విధానం.",
      "ప్రిసిషన్ అగ్రికల్చర్ అంటే ఏమిటి":
          "టెక్నాలజీ సహాయంతో సాగు ప్రక్రియను మెరుగుపరచే వ్యవసాయ విధానమే ప్రిసిషన్ అగ్రికల్చర్.",
      "వెర్మీ కంపోస్టింగ్ అంటే ఏమిటి":
          "కెంచుల ద్వారా వృథా పదార్థాలను ప్రాకృతికమైన ఖాతుగా మార్చే ప్రక్రియ వెర్మీ కంపోస్టింగ్.",
      "పురుగుల నుండి పంటలను ఎలా రక్షించాలి":
          "నేమ్ ఆయిల్, పంటల మార్పిడి, మరియు సహజ శత్రువులను వాడండి.",
      "నేల ఉరితత్వాన్ని ఎలా పరీక్షించాలి":
          "సోయిల్ టెస్ట్ కిట్ వాడండి లేదా దగ్గర్లోని ల్యాబ్‌కి నమూనా పంపండి.",
      "ఎండాకాలంలో ఏ పంటలు బాగుంటాయి":
          "జొన్న, పెద్దసిరి మరియు మక్కా పంటలు బాగుంటాయి.",
      "ఒక జోక్ చెప్పు":
          "టమోటా ఎక్కడకి వెళ్లింది? సలాడ్ డ్రెస్ చూస్తూ అచ్చెత్తింది!",
      "ఈరోజు వాతావరణం ఎలా ఉంది":
          "నేను ఆఫ్‌లైన్‌లో ఉన్నాను, దయచేసి వాతావరణ యాప్‌ను తనిఖీ చేయండి.",
      "ధన్యవాదాలు": "మీకు స్వాగతం! సుఖంగా వ్యవసాయం చేయండి!",
      "వీడ్కోలు": "శుభంగా ఉండండి! మళ్ళీ కలుద్దాం.",
      "ఆర్గానిక్ వ్యవసాయం అంటే ఏమిటి?":
          "రసాయనాల్ని లేకుండా సహజ పద్ధతులతో పంటలు పండించే వ్యవసాయ విధానమే ఆర్గానిక్ వ్యవసాయం.",
      "నేల ఉరితత్వం ఎలా పెంచాలి?":
          "కంపోస్ట్ వాడండి, పంటల మార్పిడి చేయండి, హరిత ఎరువులు వాడండి.",
      "పంటల మార్పిడి అంటే ఏమిటి?":
          "ఒకే మైదానంలో ప్రతిసారి వేర్వేరు పంటలు వేయడం.",
      "బియ్యం పంటలో సాధారణ పురుగులు":
          "స్టెమ్ బోరర్లు, లీఫ్ ఫోల్డర్లు, బ్రౌన్ ప్లాంట్ హాపర్స్.",
      "వ్యవసాయంలో నీరు ఎలా సేవ్ చేయాలి?":
          "డ్రిప్ ఇరిగేషన్, వర్ష జల నిర్వహణ, మల్చింగ్ ఉపయోగించండి.",
      "గ్రీన్హౌస్ వ్యవసాయం అంటే?": "పర్యావరణ నియంత్రణతో పంటలు పెంచే విధానం.",
      "గోధుమలు ఎప్పుడు వేయాలి?": "భారతదేశంలో సాధారణంగా నవంబరులో వేయాలి.",
      "వృక్ష రోగాల నివారణ ఎలా చేయాలి?":
          "ప్రతిఘటన గల విత్తనాలు, సరైన అంతరాలు మరియు సేంద్రియ మందులు వాడండి.",
      "జైవ ఉరవేసకాలు అంటే?":
          "జీవ శక్తితో ఉన్న ఉరవేసకాలు, ఇవి నేల ఉరితత్వాన్ని పెంచుతాయి.",
      "ధాన్యం ఎలా నిల్వ ఉంచాలి?":
          "బాగా ఎండబెట్టిన ధాన్యాన్ని గాలి చొరబడని డబ్బాలలో పెట్టాలి.",
      "హైడ్రోపోనిక్స్ అంటే?":
          "మట్టితో కాకుండా నీటిలో పోషకాలు కలిపి పంటలు పెంచే విధానం.",
      "పౌల్ట్రీ ఫార్మ్ ఎలా ప్రారంభించాలి?":
          "చక్కని ప్రదేశాన్ని ఎంచుకోండి, మంచి జాతిని తీసుకోండి.",
      "ఇంటిగ్రేటెడ్ ఫార్మింగ్ అంటే?": "పంటలు, జంతువులు, చేపలు కలిపిన వ్యవసాయం.",
      "తేనెటీగల పెంపకం ఎలా మొదలుపెట్టాలి?":
          "తేనెటీగ పెట్టెలు కొనండి మరియు పుష్పాల సమీపంలో పెట్టండి.",
      "నేల పీహెచ్ ఎలా చెక్ చేయాలి?": "పిహెచ్ టెస్ట్ కిట్ ఉపయోగించండి.",
      "నీ పేరు ఏమిటి?": "నా పేరు అగ్రిబాట్. నేను వ్యవసాయ సహాయం కోసం ఉన్నాను.",
      "నువ్వు ఎలా ఉన్నావు?": "నేను బాగున్నాను, మీ సేవలో సిద్ధంగా ఉన్నాను!",
      "నీని ఎవరు తయారు చేశారు?":
          "నన్ను రైతులను సహాయపడే ఉద్దేశ్యంతో అభివృద్ధి చేశారు.",
      "నువ్వు ఎలా సహాయం చేస్తావు?":
          "నేను వ్యవసాయం గురించి ప్రశ్నలకు సమాధానాలు ఇస్తాను.",
      "నాకు జోక్ చెప్పు": "ఏంట్రా టమోటా అచ్చెత్తింది? సలాడ్ డ్రెస్ చూసింది!",
      "AI అంటే ఏమిటి?":
          "AI అంటే ఆర్టిఫిషియల్ ఇంటెలిజెన్స్, అంటే యంత్రాలు మానవుల్లా ఆలోచించడం.",
      "కాలానుకూల మార్పు అంటే ఏమిటి?":
          "పలుకుబడి గల కాలానుకూల ఉష్ణోగ్రతలు మరియు వాతావరణ మార్పులు.",
      "సస్టైనబుల్ ఫార్మింగ్ అంటే ఏమిటి?":
          "సస్టైనబుల్ ఫార్మింగ్ నేల ఆరోగ్యాన్ని కాపాడే మరియు సుదీర్ఘ ఉత్పాదకతను నిర్ధారించే పద్ధతులను ఉపయోగిస్తుంది।",
      "వరి ఎలా పెంచాలి?":
          "వరికి నీరు నిలిచే పొలం, ఫలవంతమైన నేల, వెచ్చని వాతావరణం అవసరం; నాట్లు వేయండి।",
      "మల్చింగ్ అంటే ఏమిటి?":
          "మల్చింగ్ అనేది నేలను సేంద్రియ లేదా కృత్రిమ పదార్థాలతో కప్పడం, తేమను నిలుపుకోవడానికి।",
      "మొక్కలలో పోషక లోపాలను ఎలా గుర్తించాలి?":
          "పసుపు ఆకులు (నైట్రోజన్ లోపం) లేదా చిన్న పెరుగుదల (ఫాస్ఫరస్ లోపం) చూడండి।",
      "కంపానియన్ ప్లాంటింగ్ అంటే ఏమిటి?":
          "వివిధ పంటలను ఒకేసారి పెంచడం ద్వారా పెరుగుదలను మెరుగుచేయడం లేదా పురుగులను నివారించడం.",
      "చిన్న కూరగాయల తోట ఎలా మొదలుపెట్టాలి?":
          "ఎండ ఉన్న ప్రదేశాన్ని ఎంచుకోండి, ఫలవంతమైన నేలను సిద్ధం చేసి, సీజనల్ కూరగాయలు నాటండి।",
      "నేల కోత అంటే ఏమిటి?":
          "నేల కోత అనేది గాలి, నీరు లేదా మానవ కార్యకలాపాల వల్ల ఎగువ నేల కోల్పోవడం.",
      "సహజ ఎరువులను ఎలా ఉపయోగించాలి?":
          "కంపోస్ట్, గొల్లపిడ లేదా హరిత ఎరువులను నేలకు జోడించండి।",
      "శీతాకాలంలో ఏ పంటలు పెరుగుతాయి?":
          "గోధుమ, ఆవాలు, బఠానీలు చల్లని వాతావరణంలో బాగా పెరుగుతాయి।",
      "కలుపు మొక్కలను ఎలా నిర్వహించాలి?":
          "మల్చింగ్, చేతితో కలుపు తీయడం లేదా సేంద్రియ హెర్బిసైడ్లు వాడండి।",
      "ఆక్వాపోనిక్స్ అంటే ఏమిటి?":
          "చేపల పెంపకంతో హైడ్రోపోనిక్స్ కలిపి, చేపల వ్యర్థాలతో మొక్కలకు పోషణ ఇవ్వడం.",
      "పంట దిగుబడిని ఎలా మెరుగుపరచాలి?":
          "గుణమైన విత్తనాలు, నేల ఆరోగ్యం, స్టీక ఫార్మింగ్ టెక్నిక్‌లు వాడండి।",
      "కవర్ క్రాప్ అంటే ఏమిటి?":
          "క్లోవర్ లేదా రై వంటి కవర్ క్రాప్‌లు నేల రక్షణ మరియు ఉరితత్వం కోసం పెంచబడతాయి।",
      "ఆర్గానిక్ ఫార్మింగ్ ఎలా మొదలుపెట్టాలి?":
          "రసాయనాలను నివారించండి, సేంద్రియ ఎరువులు వాడండి మరియు అధికారుల సర్టిఫికేషన్ తీసుకోండి।",
      "పంట వైవిధ్యం అంటే ఏమిటి?":
          "వివిధ రకాల పంటలను పెంచడం ద్వారా రిస్క్ తగ్గించడం మరియు నేల ఆరోగ్యం మెరుగుపరచడం.",
      "మొక్కలలో ఫంగల్ రోగాలను ఎలా నివారించాలి?":
          "సేంద్రియ కవకనాశినులు, గాలి ఆడేలా చూసుకోండి, ప్రభావిత భాగాలను తొలగించండి।",
      "పరాగసంపర్క జీవుల పాత్ర ఏమిటి?":
          "తేనెటీగలు పరాగసంపర్కం చేస్తాయి, ఫసల దిగుబడిని పెంచుతాయి।",
      "విత్తనాలను ఎలా నిల్వ చేయాలి?":
          "విత్తనాలను చల్లని, పొడి ప్రదేశంలో గాలి చొరబడని డబ్బాలలో నిల్వ చేయండి।",
      "ఆగ్రోఫారెస్ట్రీ అంటే ఏమిటి?":
          "చెట్లను పంటలు లేదా పశువులతో కలిపి ఉత్పాదకతను పెంచే విధానం.",
      "డ్రిప్ ఇరిగేషన్ యొక్క ప్రయోజనాలు ఏమిటి?":
          "ఇది నీటిని ఆదా చేస్తుంది, కలుపు మొక్కలను తగ్గిస్తుంది మరియు రూట్స్‌కు పోషకాలను అందిస్తుంది।",
      "మీరు ఎవరు?": "నేను అగ్రిబాట్, మీ వ్యవసాయ సహాయకుడు.",
      "మీ పేరు ఏమిటి?": "నా పేరు అగ్రిబాట్, వ్యవసాయ సలహాల కోసం ఉన్నాను。",
      "నీవు ఎలా ఉన్నావు?": "నేను బాగున్నాను, ధన్యవాదాలు! నీవు ఎలా ఉన్నావు?",
      "నీవు ఏం చేయగలవు?":
          "నేను వ్యవసాయ ప్రశ్నలకు సమాధానమిస్తాను, సలహాలు ఇస్తాను.",
      "సాయంత్రం శుభం": "సాయంత్రం శుభం! మీ రోజు బాగా గడిచిందని ఆశిస్తున్నాను.",
      "వాయిస్ అసిస్టంట్ అంటే ఏమిటి?":
          "వాయిస్ అసిస్టంట్ అనేది గొంతు ఆదేశాలకు స్పందించే డిజిటల్ సహాయకుడు.",
      "నిన్ను ఎవరు సృష్టించారు?":
          "రైతులకు సహాయపడేందుకు నన్ను ఒక బృందం తయారు చేసింది。",
      "ఆసక్తికరమైన విషయం చెప్పు":
          "కెంచుకలు నేల ఆరోగ్యాన్ని సహజంగా మెరుగుపరుస్తాయని తెలుసా?",
      "సమయం ఎంత?": "నేను ఇప్పుడు సమయం చూడలేను, నీ గడియారం సహాయపడగలదు!",
      "జోక్ చెప్పు": "ఆవు స్పీకర్ ఎందుకైంది? చాలా మూగుడు విషయాలు ఉన్నాయ్ కదా!",
      "నీవు ఎలా పనిచేస్తావు?":
          "నీ ప్రశ్నలను విని, నా జ్ఞానంతో సమాధానాలు ఇస్తాను.",
      "शुभ रात्रि": "शुभ रात्री! स्वस्थ फसलों के सपनों का आनंद लें।",
      "తెల్నాగం": "సుభ రాత్రి! ఆర్వాగ్యమైన పంటల స్వప్నాలు చూడు.",
      "టెక్నాలజీ అంటే ఏమిటి?":
          "టెక్నాలజీ అంటే సమస్యలను పరిష్కరించే సాధనాలు మరియు వ్యవస్థల ఉపయోగం.",
      "నీవు పాడగలవా?": "నేను పాడలేను, కానీ పంట చక్రాల గురించి చెప్పగలను!",
    },
  };
  List<Map<String, dynamic>> messages = [];
  bool isListening = false;

  // Mumbai

  // 1️⃣ Add at the top of your state class
  bool showMap = false;

  final gmap.LatLng _center = const gmap.LatLng(
    16.5062,
    80.6480,
  ); // Vijayawada center

  late gmap.GoogleMapController _mapController;

  final Set<gmap.Marker> _markers = {
    gmap.Marker(
      markerId: const gmap.MarkerId("orange_zone_east"),
      position: const gmap.LatLng(16.5062, 80.6880),
      infoWindow: const gmap.InfoWindow(title: "Oranges - East Vijayawada"),
    ),
    gmap.Marker(
      markerId: const gmap.MarkerId("wheat_zone_west"),
      position: const gmap.LatLng(16.5062, 80.4880),
      infoWindow: const gmap.InfoWindow(title: "Wheat - West Vijayawada"),
    ),
    gmap.Marker(
      markerId: const gmap.MarkerId("tomato_zone_mid"),
      position: const gmap.LatLng(16.4062, 80.6000),
      infoWindow: const gmap.InfoWindow(title: "Tomatoes - Mid Vijayawada"),
    ),
    gmap.Marker(
      markerId: const gmap.MarkerId("wheat_zone_north"),
      position: const gmap.LatLng(16.5462, 80.6480),
      infoWindow: const gmap.InfoWindow(title: "Wheat - North Vijayawada"),
    ),
    gmap.Marker(
      markerId: const gmap.MarkerId("orange_zone_south"),
      position: const gmap.LatLng(16.3662, 80.6680),
      infoWindow: const gmap.InfoWindow(title: "Oranges - South Vijayawada"),
    ),
    gmap.Marker(
      markerId: const gmap.MarkerId("tomato_zone_6"),
      position: const gmap.LatLng(16.4962, 80.6580),
      infoWindow: const gmap.InfoWindow(title: "Tomatoes - Zone 6"),
    ),
    gmap.Marker(
      markerId: const gmap.MarkerId("tractor_zone_7"),
      position: const gmap.LatLng(16.4762, 80.6780),
      infoWindow: const gmap.InfoWindow(title: "Tractor Service - Zone 7"),
    ),
    gmap.Marker(
      markerId: const gmap.MarkerId("orange_zone_8"),
      position: const gmap.LatLng(16.4862, 80.5980),
      infoWindow: const gmap.InfoWindow(title: "Oranges - Zone 8"),
    ),
    gmap.Marker(
      markerId: const gmap.MarkerId("wheat_zone_9"),
      position: const gmap.LatLng(16.4562, 80.6480),
      infoWindow: const gmap.InfoWindow(title: "Wheat - Zone 9"),
    ),
    gmap.Marker(
      markerId: const gmap.MarkerId("tractor_zone_10"),
      position: const gmap.LatLng(16.5262, 80.6880),
      infoWindow: const gmap.InfoWindow(title: "Tractor - Zone 10"),
    ),
    gmap.Marker(
      markerId: const gmap.MarkerId("tomato_zone_11"),
      position: const gmap.LatLng(16.5062, 80.6680),
      infoWindow: const gmap.InfoWindow(title: "Tomatoes - Zone 11"),
    ),
    gmap.Marker(
      markerId: const gmap.MarkerId("wheat_zone_12"),
      position: const gmap.LatLng(16.4862, 80.6880),
      infoWindow: const gmap.InfoWindow(title: "Wheat - Zone 12"),
    ),
    gmap.Marker(
      markerId: const gmap.MarkerId("orange_zone_13"),
      position: const gmap.LatLng(16.4662, 80.6780),
      infoWindow: const gmap.InfoWindow(title: "Oranges - Zone 13"),
    ),
    gmap.Marker(
      markerId: const gmap.MarkerId("tomato_zone_14"),
      position: const gmap.LatLng(16.4562, 80.6680),
      infoWindow: const gmap.InfoWindow(title: "Tomatoes - Zone 14"),
    ),
    gmap.Marker(
      markerId: const gmap.MarkerId("tractor_zone_15"),
      position: const gmap.LatLng(16.5162, 80.6580),
      infoWindow: const gmap.InfoWindow(title: "Tractor - Zone 15"),
    ),
  };

  void _onMapCreated(gmap.GoogleMapController controller) {
    _mapController = controller;
  }

  Future<void> showSiriAssistant(BuildContext context) async {
    String userInput = ""; // Declare and initialize before use
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              'assets/siri.json',
              width: 200,
              height: 200,
              repeat: true,
            ),
            const SizedBox(height: 10),
            Text(
              "Listening..... $userInput",
              style: const TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
    while (true) {
      userInput = await _listen() ?? "";

      // Wait a bit after speaking
      await Future.delayed(Duration(seconds: 1));

      if (userInput.trim().isEmpty) return;

      final reply = await _getResponseFromDataset(userInput);

      if (userInput == "Farmer Page" || userInput == "farmer page") {
        Navigator.of(context).pop(); // Close the dialog
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FarmerDashboard()),
        );
        return;
      }

      if (userInput == "Open Dashboard" || userInput == "open dashboard") {
        Navigator.of(context).pop(); // Close the dialog
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BuyerDashboardPage()),
        );
        return;
      }

      if (userInput.contains("Open") || userInput.contains("open")) {
        Navigator.of(context).pop(); // Close the dialog
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BuyerDashboardPage()),
        );
        return;
      }

      if (userInput.contains("Dashboard") || userInput.contains("dashboard")) {
        Navigator.of(context).pop(); // Close the dialog
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BuyerDashboardPage()),
        );
        return;
      }

      if (userInput.contains("Policies") ||
          userInput.contains("policies") ||
          userInput.contains("Policy") ||
          userInput.contains("policy")) {
        Navigator.of(context).pop(); // Close the dialog
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FarmPolicyApp()),
        );
        return;
      }

      if (userInput.contains("Weather") || userInput.contains("weather")) {
        Navigator.of(context).pop(); // Close the dialog
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WeatherMarketPage()),
        );
        return;
      }

      if (userInput == "Login Page" || userInput == "login page") {
        Navigator.of(context).pop(); // Close the dialog
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
        return;
      }

      // Speak response
      String ttsLang;
      if (selectedLang == 'hi') {
        ttsLang = 'hi-IN';
      } else if (selectedLang == 'te') {
        ttsLang = 'te-IN';
      } else {
        ttsLang = 'en-US'; // fallback to English for others
      }

      await _tts.setLanguage(ttsLang);
      await _tts.speak(reply);

      if ([
        "exit",
        "quit",
        "bye",
        "goodbye",
        "stop",
        "close",
        "cancel",
        "Exit",
        "Quit",
        "Bye",
        "Goodbye",
        "Stop",
        "Close",
        "Cancel",
      ].contains(userInput)) {
        Navigator.of(context).pop(); // Close the dialog
        return;
      }

      await Future.delayed(Duration(milliseconds: 4000));
    }
  }

  Future<String?> _listen() async {
    if (isListening) {
      await _speech.stop();
      setState(() => isListening = false);
      return null;
    }

    bool available = await _speech.initialize(
      onStatus: (status) {
        if (status == 'done' || status == 'notListening') {
          setState(() => isListening = false);
        }
      },
      onError: (error) {
        print('Speech error: $error');
        setState(() => isListening = false);
      },
    );

    if (!available) return null;

    setState(() => isListening = true);

    final completer = Completer<String?>();

    _speech.listen(
      localeId: selectedLocale,
      listenMode: stt.ListenMode.dictation,
      listenFor: Duration(seconds: 10),
      pauseFor: Duration(seconds: 3),
      onResult: (result) {
        if (result.finalResult) {
          setState(() => isListening = false);
          _speech.stop();
          completer.complete(result.recognizedWords);
        }
      },
    );

    return completer.future;
  }

  Future<String> _getResponseFromDataset(String userInput) async {
    String langCode = selectedLang.substring(0, 2);

    // Allow only en, hi, te
    if (!['en', 'hi', 'te'].contains(langCode)) {
      langCode = 'en';
    }

    Map<String, String> faqs = faqDataset[langCode] ?? faqDataset['en']!;

    String? bestMatch;
    double maxScore = 0.0;

    faqs.forEach((question, answer) {
      double score = userInput.toLowerCase().similarityTo(question);
      if (score > maxScore) {
        maxScore = score;
        bestMatch = question;
      }
    });

    return maxScore > 0.4
        ? faqs[bestMatch]!
        : "Sorry, I couldn't understand. Please ask a farming-related question.";
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Colors.black : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor = isDark ? Colors.white70 : Colors.black54;
    String User = "defualt";
    String PresentUser = "defualt";
    final Map<String, Locale> languageMap = {
      'English': const Locale('en'),
      'हिन्दी (Hindi)': const Locale('hi'),
      'தமிழ் (Tamil)': const Locale('ta'),
      'తెలుగు (Telugu)': const Locale('te'),
      'ಕನ್ನಡ (Kannada)': const Locale('kn'),
      'मराठी (Marathi)': const Locale('mr'),
      'España (Spain)': const Locale('es'),
      'Deutsch (German)': const Locale('de'),
    };

    void _showLanguagePicker(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Choose Language'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: languageMap.entries.map((entry) {
                return ListTile(
                  title: Text(entry.key),
                  onTap: () {
                    KisanConnectApp.setLocale(context, entry.value);
                    Navigator.pop(context);
                    (entry.value.languageCode == 'ta')
                        ? fontsizee = 6
                        : fontsizee = 10;
                    if (entry.value.languageCode == 'es' ||
                        entry.value.languageCode == 'de') {
                      fontsizee = 5;
                      // : fontsizee = 10;
                    } else {
                      fontsizee = 10;
                    }
                  },
                );
              }).toList(),
            ),
          );
        },
      );
    }

    final localizations = AppLocalizations.of(context);

    String appTitle = localizations?.appTitle ?? '';

    String searchHint = localizations?.searchHint ?? '';

    String carouselTitle1 = localizations?.carouselTitle1 ?? '';
    String carouselTitle2 = localizations?.carouselTitle2 ?? '';
    String carouselTitle3 = localizations?.carouselTitle3 ?? '';

    String exploreNow = localizations?.exploreNow ?? '';

    String contractFarmingTitle = localizations?.contractFarmingTitle ?? '';
    String contractFarmingDescription =
        localizations?.contractFarmingDescription ?? '';

    String exploreCategories = localizations?.exploreCategories ?? '';

    String categoryCropsTitle = localizations?.categoryCropsTitle ?? '';
    String categoryCropsDesc = localizations?.categoryCropsDesc ?? '';

    String categoryEquipmentTitle = localizations?.categoryEquipmentTitle ?? '';
    String categoryEquipmentDesc = localizations?.categoryEquipmentDesc ?? '';

    String categoryProduceTitle = localizations?.categoryProduceTitle ?? '';
    String categoryProduceDesc = localizations?.categoryProduceDesc ?? '';

    String whatUsersSay = localizations?.whatUsersSay ?? '';

    String testimonial1 = localizations?.testimonial1 ?? '';
    String testimonial1Author = localizations?.testimonial1Author ?? '';

    String testimonial2 = localizations?.testimonial2 ?? '';
    String testimonial2Author = localizations?.testimonial2Author ?? '';

    String testimonial3 = localizations?.testimonial3 ?? '';
    String testimonial3Author = localizations?.testimonial3Author ?? '';

    String footerCopyright = localizations?.footerCopyright ?? '';

    String drawerProfile = localizations?.drawerProfile ?? '';
    String drawerHelp = localizations?.drawerHelp ?? '';
    String drawerQuery = localizations?.drawerQuery ?? '';
    String drawerSettings = localizations?.drawerSettings ?? '';

    String popupLogin = localizations?.popupLogin ?? '';
    String popupFarmer = localizations?.popupFarmer ?? '';
    String popupBuyer = localizations?.popupBuyer ?? '';
    String popupLogout = localizations?.popupLogout ?? '';
    String popupHelp = localizations?.popupHelp ?? '';

    String logoutSuccess = localizations?.logoutSuccess ?? '';
    String helpSelected = localizations?.helpSelected ?? '';

    String voiceAssistantGreeting = localizations?.voiceAssistantGreeting ?? '';
    final List<Map<String, String>> carouselItems = [
      {"image": "assets/image1.jpg", "title": carouselTitle1},
      {"image": "assets/image2.jpg", "title": carouselTitle2},
      {"image": "assets/image3.jpg", "title": carouselTitle3},
    ];
    final List<Map<String, dynamic>> categories = [
      {
        "icon": Icons.grass,
        "title": localizations?.categoryCropsTitle ?? '',
        "desc": localizations?.categoryCropsDesc ?? '',
        "screen": CropsViewScreen(),
      },
      {
        "icon": Icons.agriculture,
        "title": localizations?.categoryEquipmentTitle ?? '',
        "desc": localizations?.categoryEquipmentDesc ?? '',
        "screen": EquipmentViewScreen(),
      },
      {
        "icon": Icons.local_grocery_store,
        "title": localizations?.categoryProduceTitle ?? '',
        "desc": localizations?.categoryProduceDesc ?? '',
        "screen": ProduceFAQScreen(),
      },
    ];

    return Scaffold(
      key: _scaffoldKey,
      drawer: Builder(
        builder: (context) {
          final screenWidth = MediaQuery.of(context).size.width;

          return SizedBox(
            width: screenWidth * 0.64, // 80% of screen width
            child: Drawer(
              child: Column(
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text(PresentUser),
                    accountEmail: (PresentUser == User)
                        ? Text("Administrator")
                        : Text("Student"),
                    currentAccountPicture: const CircleAvatar(
                      backgroundImage: AssetImage('assets/imgicon1.png'),
                    ),
                    decoration: BoxDecoration(
                      color: ('defualt' == User)
                          ? Colors.blue
                          : Colors.orangeAccent,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(drawerProfile),
                    onTap: () {
                      print("Profile tapped");
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.help),
                    title: Text(drawerHelp),
                    onTap: () {
                      Navigator.pop(context); // close the drawer first
                      Future.delayed(Duration(milliseconds: 300), () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AboutUsPage(),
                          ),
                        );
                      });
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.contact_emergency),
                    title: Text(drawerQuery),
                    onTap: () {
                      Navigator.pop(context);
                      Future.delayed(Duration(milliseconds: 300), () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContactUsPage(),
                          ),
                        );
                      });
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: Text(drawerSettings),
                    onTap: () {
                      print("Settings tapped");
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(
              width: Localizations.localeOf(context).languageCode == 'ta'
                  ? 1.0
                  : 45.0,
            ),
            Text(AppLocalizations.of(context)?.appTitle ?? 'Kisan Connect.'),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 10, 133, 82),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              showMenu<int>(
                context: context,
                position: const RelativeRect.fromLTRB(100, 80, 0, 0),
                items: [
                  PopupMenuItem(value: 1, child: Text(popupLogin)),
                  PopupMenuItem(value: 2, child: Text(popupFarmer)),
                  PopupMenuItem(value: 3, child: Text(popupBuyer)),

                  PopupMenuItem(value: 4, child: Text(popupLogout)),
                  PopupMenuItem(value: 5, child: Text(popupHelp)),
                ],
              ).then((value) {
                if (value == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                } else if (value == 4) {
                  _showLanguagePicker(context);
                } else if (value == 5) {}
                if (value == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FarmerDashboard()),
                  );
                }
                if (value == 3) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BuyerDashboardPage(),
                    ),
                  );
                }
              });
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          // 🔍 Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 45,
              child: TextField(
                style: TextStyle(color: Colors.black), // input text color
                decoration: InputDecoration(
                  hintText: searchHint,
                  hintStyle: TextStyle(
                    color: Colors.black54,
                  ), // hint text color
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 13),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
          ),

          // 📸 Carousel
          SizedBox(
            height: 280,
            child: showMap
                ? gmap.GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: gmap.CameraPosition(
                      target: _center,
                      zoom: 10.0,
                    ),
                    markers: _markers,
                  )
                : CarouselSlider.builder(
                    itemCount: carouselItems.length,
                    itemBuilder: (context, index, realIdx) {
                      final item = carouselItems[index];
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          ShaderMask(
                            shaderCallback: (rect) => LinearGradient(
                              colors: [Colors.black54, Colors.black26],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ).createShader(rect),
                            blendMode: BlendMode.darken,
                            child:
                                Image.asset(item['image']!, fit: BoxFit.cover)
                                    .animate()
                                    .fadeIn(duration: 700.ms)
                                    .scaleXY(
                                      begin: 1.1,
                                      end: 1.0,
                                      curve: Curves.easeOutCubic,
                                      duration: 1500.ms,
                                    ),
                          ),
                          Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                      item['title']!,
                                      style: const TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        shadows: [
                                          Shadow(
                                            blurRadius: 8.0,
                                            color: Colors.black87,
                                            offset: Offset(2, 2),
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                    .animate()
                                    .fadeIn(duration: 900.ms)
                                    .moveY(begin: -40),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          showMap = true;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.black,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 30,
                                          vertical: 15,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                        ),
                                        elevation: 10,
                                      ),
                                      child: Text(exploreNow),
                                    )
                                    .animate()
                                    .fadeIn(duration: 1000.ms)
                                    .moveY(begin: 40),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    options: CarouselOptions(
                      height: 280,
                      autoPlay: true,
                      autoPlayAnimationDuration: const Duration(seconds: 2),
                      autoPlayCurve: Curves.easeInOutCubicEmphasized,
                      viewportFraction: 1.0,
                      enlargeCenterPage: false,
                      scrollPhysics: const BouncingScrollPhysics(),
                    ),
                  ),
          ),

          // 📘 Info Section
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  contractFarmingTitle,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  contractFarmingDescription,
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
                Text(
                  exploreCategories,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                SizedBox(height: 20),

                // Row 1: Crops
                Row(
                  children: [
                    Expanded(
                      child: _buildCategoryBox(
                        categories[0],
                        textColor,
                        subTextColor,
                        context,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                // Row 2: Equipment and Fresh Produce
                Row(
                  children: [
                    Expanded(
                      child: _buildCategoryBox(
                        categories[1],
                        textColor,
                        subTextColor,
                        context,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: _buildCategoryBox(
                        categories[2],
                        textColor,
                        subTextColor,
                        context,
                      ),
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
                Text(
                  whatUsersSay,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                SizedBox(height: 10),
                _testimonial(
                  testimonial1,
                  testimonial1Author,
                  textColor,
                  subTextColor,
                ),
                _testimonial(
                  testimonial2,
                  testimonial2Author,
                  textColor,
                  subTextColor,
                ),
                _testimonial(
                  testimonial3,
                  testimonial3Author,
                  textColor,
                  subTextColor,
                ),
              ],
            ),
          ),

          // 🔻 Footer
          Container(
            color: Color(0xFF02100f),
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Text(footerCopyright, style: TextStyle(color: subTextColor)),
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
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFFF4757),
        onPressed: () => showSiriAssistant(context),
        child: Icon(Icons.mic),
      ),
    );
  }

  var fontsizee = 10.0;
  Widget _buildCategoryBox(
    Map<String, dynamic> cat,
    Color textColor,
    Color subTextColor,
    BuildContext context,
  ) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => cat['screen']),
        );
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
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 5),
              Text(
                cat['desc'],
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: fontsizee),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _testimonial(
    String text,
    String author,
    Color textColor,
    Color subTextColor,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            '"$text"',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 16,
              color: textColor,
            ),
          ),
          SizedBox(height: 10),
          Text(
            author,
            style: TextStyle(fontWeight: FontWeight.bold, color: subTextColor),
          ),
        ],
      ),
    );
  }
}

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  bool _showSuccess = false;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() => _showSuccess = true);
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();

      Future.delayed(const Duration(seconds: 3), () {
        setState(() => _showSuccess = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
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
            onPressed: () {
              // Navigate to About Us page if needed
            },
            child: const Text(
              'About Us',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF38be14),
              ),
            ),
            const SizedBox(height: 30),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _nameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      hintText: 'Your Name',
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white60),
                      filled: true,
                      fillColor: Colors.white10,
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter your name' : null,
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _emailController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'Your Email',
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white60),
                      filled: true,
                      fillColor: Colors.white10,
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter your email' : null,
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _messageController,
                    style: const TextStyle(color: Colors.white),
                    maxLines: 4,
                    decoration: const InputDecoration(
                      labelText: 'Message',
                      hintText: 'Your Message',
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white60),
                      filled: true,
                      fillColor: Colors.white10,
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter your message' : null,
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF38be14),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                      ),
                      child: const Text('Send Message'),
                    ),
                  ),
                  if (_showSuccess)
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        'Your message has been sent successfully! We will respond soon.',
                        style: TextStyle(color: Colors.greenAccent),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(color: Colors.white24),
            Text(
              '© 2025 Kisan Connect. All rights reserved.',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutUsPage2 extends StatelessWidget {
  const AboutUsPage2({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D091E),
        title: Row(
          children: [
            Image.asset('assets/logo.png', width: 35),
            const SizedBox(width: 8),
            Text(local.appTitle),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ContactUsPage()),
              );
            },
            child: Text(
              local.contactUs,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 70),
              color: const Color(0xCC2E8982),
              child: Column(
                children: [
                  Text(
                    local.aboutUs,
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    local.aboutUsSubtitle,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
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
                  SectionHeader(local.aboutKisanKonnect),
                  Text(local.aboutDescription),
                  const SizedBox(height: 20),
                  SectionHeader(local.ourMission),
                  Text(local.missionDescription),
                  const SizedBox(height: 20),
                  SectionHeader(local.ourVision),
                  Text(local.visionDescription),
                  const SizedBox(height: 20),
                  SectionHeader(local.ourValues),
                  BulletList([
                    local.valueIntegrity,
                    local.valueCustomerFocus,
                    local.valueInnovation,
                    local.valueSustainability,
                  ]),
                ],
              ),
            ),
            Column(
              children: [
                const Divider(color: Colors.white24),
                Text(local.footerCopyright),
                Text(local.footerSupport),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(local.voiceCommandNotImplemented)),
          );
        },
        backgroundColor: const Color(0xFFFF4757),
        child: const Icon(Icons.mic),
      ),
    );
  }
}

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
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
            onPressed: () {
              // Add contact navigation here
            },
            child: const Text(
              'Contact Us',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          // Hero Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 70),
            color: const Color(0xCC2E8982),
            child: const Column(
              children: [
                Text(
                  'About Us',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Learn more about Kisan Connect',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          ),

          // Main Content
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 15,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About Kisan Konnect',
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFF38be14),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'We are dedicated to connecting farmers and buyers in a seamless marketplace. Our platform provides a variety of agricultural products and services to meet the needs of our users.',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),
                Text(
                  'Our Mission',
                  style: TextStyle(
                    fontSize: 22,
                    color: Color(0xFF38be14),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'To empower farmers and provide buyers with access to quality agricultural products.',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),
                Text(
                  'Our Vision',
                  style: TextStyle(
                    fontSize: 22,
                    color: Color(0xFF38be14),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'To be the leading online marketplace for agricultural products, fostering sustainable practices and supporting local farmers.',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),
                Text(
                  'Our Values',
                  style: TextStyle(
                    fontSize: 22,
                    color: Color(0xFF38be14),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '• Integrity: We uphold the highest standards of integrity in all our actions.',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '• Customer Focus: We value our customers and strive to meet their needs.',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '• Innovation: We embrace change and seek new ways to improve our services.',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '• Sustainability: We are committed to promoting sustainable agricultural practices.',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Footer
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Divider(color: Colors.white24),
                Text(
                  '© 2025 Kisan Connect. All rights reserved.',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'Customer Support: 9999999999 | Email: customercare@kisankonnect.in',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Voice assistant feature coming soon!"),
            ),
          );
        },
        backgroundColor: const Color(0xFFFF4757),
        child: const Icon(Icons.mic),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String text;
  const SectionHeader(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    );
  }
}

class BulletList extends StatelessWidget {
  final List<String> items;
  const BulletList(this.items, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items
          .map(
            (item) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('• ', style: TextStyle(fontSize: 18)),
                Expanded(child: Text(item)),
              ],
            ),
          )
          .toList(),
    );
  }
}

class FarmerDashboard extends StatelessWidget {
  const FarmerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final isTablet = width > 600;
    final local = AppLocalizations.of(context)!;

    // Localization variables
    final String welcomeMessage = local.welcomeMessage;
    final String appTitle = local.appTitle;
    final String welcomeSubtitle = local.welcomeSubtitle;
    final String searchHint = local.searchHint;

    final String equipmentRentals = local.equipmentRentals;
    final String marketTrends = local.marketTrends;
    final String weatherUpdates = local.weatherUpdates;

    final String testimonialTitle = local.testimonialTitle;
    final String testimonial11 = local.testimonial11;
    final String testimonial11Author = local.testimonial11Author;
    final String testimonial22 = local.testimonial22;
    final String testimonial22Author = local.testimonial22Author;
    final String testimonial33 = local.testimonial33;
    final String testimonial33Author = local.testimonial33Author;

    final String footerCopyright = local.footerCopyright;
    final String footerSupport = local.footerSupport;
    final String govtPolicies = local.govtPolicies;

    // Dashboard cards data
    final List<Map<String, String>> dashboardItems = [
      {
        'title': equipmentRentals,
        'image': 'https://images.unsplash.com/photo-1592982537447-7440770cbfc9',
        'icon': '🛠️',
      },
      {
        'title': govtPolicies,
        'image': 'https://images.unsplash.com/photo-1592982537447-7440770cbfc9',
        'icon': '🛠️',
      },
      {
        'title': marketTrends,
        'image': 'https://images.unsplash.com/photo-1605000797499-95a51c5269ae',
        'icon': '📈',
      },
      {
        'title': weatherUpdates,
        'image': 'https://images.unsplash.com/photo-1601134467661-3d775b999c8b',
        'icon': '🌤️',
      },
    ];

    final List<Map<String, String>> testimonials = [
      {'text': testimonial11, 'author': testimonial11Author},
      {'text': testimonial22, 'author': testimonial22Author},
      {'text': testimonial33, 'author': testimonial33Author},
    ];

    Widget buildDashboardCard(Map<String, String> item, bool isTablet) {
      return Container(
        height: isTablet ? 180 : 150,
        margin: EdgeInsets.only(bottom: isTablet ? 24 : 16),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(item['image']!),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(isTablet ? 30 : 20),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(isTablet ? 30 : 20),
            gradient: const LinearGradient(
              colors: [Color(0xE509A745), Color(0xE5ACB5B4)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item['icon']!,
                  style: TextStyle(fontSize: isTablet ? 48 : 32),
                ),
                Text(
                  item['title']!,
                  style: TextStyle(
                    fontSize: isTablet ? 26 : 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    void handleCardTap(String title) {
      print("Tapped on: $title");

      if (title == equipmentRentals) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const EquipmentRentalPage()),
        );
      }
      if (title == govtPolicies) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => FarmPolicyApp()),
        );
      } else if (title == marketTrends) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AgricultureTrendsPage()),
        );
      } else if (title == weatherUpdates) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const WeatherMarketPage()),
        );
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFF141414),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0d091e),
        title: Row(
          children: [
            SizedBox(
              width: Localizations.localeOf(context).languageCode == 'ta'
                  ? 15.0
                  : 45.0,
            ),
            Text(
              appTitle,
              style: TextStyle(
                fontSize: Localizations.localeOf(context).languageCode == 'ta'
                    ? 22.0
                    : 25.0,
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          // 🟢 Header Section
          Container(
            padding: EdgeInsets.symmetric(vertical: isTablet ? 120 : 80),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0x700aed61), Color(0x1c06b26a)],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  welcomeMessage,
                  style: TextStyle(
                    fontSize: width * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  welcomeSubtitle,
                  style: TextStyle(fontSize: width * 0.045),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // 🟢 Search Bar
          Padding(
            padding: const EdgeInsets.all(24),
            child: TextField(
              style: const TextStyle(color: Colors.black, fontSize: 18),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(255, 221, 216, 216),
                hintText: searchHint,
                hintStyle: const TextStyle(color: Colors.black54, fontSize: 18),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.black,
                  size: 22,
                ),
              ),
            ),
          ),

          // 🟢 Dashboard Cards
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? 32 : 16,
              vertical: isTablet ? 16 : 8,
            ),
            child: Column(
              children: [
                // Full-width Equipment Rental Card
                GestureDetector(
                  onTap: () => handleCardTap(dashboardItems[0]['title']!),
                  child: buildDashboardCard(dashboardItems[0], isTablet),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () => handleCardTap(dashboardItems[1]['title']!),
                  child: buildDashboardCard(dashboardItems[1], isTablet),
                ),
                const SizedBox(height: 8),

                // Row with 2-column layout for Market Trends and Weather Updates
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => handleCardTap(dashboardItems[2]['title']!),
                        child: buildDashboardCard(dashboardItems[2], isTablet),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => handleCardTap(dashboardItems[3]['title']!),
                        child: buildDashboardCard(dashboardItems[3], isTablet),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 🟢 Testimonials Section
          Container(
            color: const Color(0xFF2c2c2c),
            padding: EdgeInsets.all(isTablet ? 40 : 24),
            child: Column(
              children: [
                Text(
                  testimonialTitle,
                  style: TextStyle(
                    fontSize: isTablet ? 32 : 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ...testimonials.map(
                  (t) => Card(
                    color: const Color(0xFF1a1a1a),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(isTablet ? 30 : 20),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(isTablet ? 24 : 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            t['text']!,
                            style: TextStyle(fontSize: isTablet ? 22 : 16),
                          ),
                          SizedBox(height: isTablet ? 18 : 10),
                          Text(
                            t['author']!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: isTablet ? 18 : 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 🟢 Footer Section
          Container(
            color: const Color(0xFF0d091e),
            padding: EdgeInsets.all(isTablet ? 32 : 20),
            child: Column(
              children: [
                Text(
                  footerCopyright,
                  style: TextStyle(fontSize: isTablet ? 18 : 14),
                ),
                Text(
                  footerSupport,
                  style: TextStyle(fontSize: isTablet ? 16 : 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FarmPolicyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farming Policies & News',
      theme: ThemeData(primarySwatch: Colors.green),
      home: FarmPolicyListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FarmPolicyListPage extends StatelessWidget {
  // Static data, replace this with API later
  final List<Map<String, String>> items = [
    {
      "title": "PM-Kisan Yojana",
      "description":
          "Provides income support of ₹6000 per year to all farmer families.",
    },
    {
      "title": "Crop Insurance Scheme",
      "description":
          "Pradhan Mantri Fasal Bima Yojana (PMFBY) offers insurance for crops damaged due to natural calamities.",
    },
    {
      "title": "eNAM Initiative",
      "description":
          "Online trading platform to provide better prices to farmers via transparency in agriculture markets.",
    },
    {
      "title": "Farming Cost Subsidy",
      "description":
          "Government provides 50% subsidy on seeds, fertilizers, and pesticides to reduce farming costs.",
    },
    {
      "title": "Soil Health Card Scheme",
      "description":
          "Assists farmers by providing soil nutrient data and suitable crop recommendations.",
    },
    {
      "title": "Agriculture News (Today)",
      "description":
          "Government plans to increase MSP of wheat by ₹150 per quintal. Monsoon expected to benefit Kharif season.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: AppBar(title: Text('Govt Policies & Agri News')),
      body: ListView.builder(
        itemCount: items.length,
        padding: EdgeInsets.all(12),
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(15),
              title: Text(
                item['title']!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  item['description']!,
                  style: TextStyle(fontSize: 15),
                ),
              ),
              leading: Icon(Icons.agriculture, color: Colors.green),
            ),
          );
        },
      ),
    );
  }
}

class EquipmentRentalPage extends StatefulWidget {
  const EquipmentRentalPage({super.key});

  @override
  _EquipmentRentalPageState createState() => _EquipmentRentalPageState();
}

class _EquipmentRentalPageState extends State<EquipmentRentalPage> {
  late List<Map<String, String>> equipmentData;

  String selectedCategory = 'all';
  String selectedDuration = 'all';
  String locationQuery = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final local = AppLocalizations.of(context)!;

    equipmentData = [
      {
        'name': local.equipmentTractor,
        'category': 'tractors',
        'location': local.locationMaharashtra,
        'duration': 'daily',
        'availability': local.availabilityAvailable,
        'image': 'assets/tractor.jpg',
      },
      {
        'name': local.equipmentHarvester,
        'category': 'harvesters',
        'location': local.locationUttarPradesh,
        'duration': 'weekly',
        'availability': local.availabilityAvailable,
        'image': 'assets/harvester.jpg',
      },
      {
        'name': local.equipmentSprayer,
        'category': 'sprayers',
        'location': local.locationKarnataka,
        'duration': 'daily',
        'availability': local.availabilityAvailable,
        'image': 'assets/sprayer.jpg',
      },
      {
        'name': local.equipmentSeeder,
        'category': 'seeders',
        'location': local.locationGujarat,
        'duration': 'daily',
        'availability': local.availabilityAvailable,
        'image': 'assets/seeder.jpg',
      },
    ];
  }

  List<Map<String, String>> get filteredEquipment {
    return equipmentData.where((item) {
      return (selectedCategory == 'all' ||
              item['category'] == selectedCategory) &&
          (selectedDuration == 'all' || item['duration'] == selectedDuration) &&
          (locationQuery.isEmpty ||
              (item['location'] ?? '').toLowerCase().contains(
                locationQuery.toLowerCase(),
              ));
    }).toList();
  }

  void showBookingDialog(String name) {
    final local = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(local.bookingConfirmationTitle),
        content: Text(local.bookingConfirmationMessage(name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(local.close),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final isTablet = width > 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 10, 176, 168),
        title: Text(
          local.appTitle,
          style: TextStyle(fontSize: isTablet ? 28 : 24),
        ),
        actions: [
          PopupMenuButton<int>(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(value: 1, child: Text(local.aboutUs)),
              PopupMenuItem(value: 2, child: Text(local.contactUs)),
            ],
            onSelected: (value) {},
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(isTablet ? 32 : 16),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text(
                  local.equipmentWelcomeTitle,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  local.equipmentWelcomeSubtitle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Card(
            color: Colors.white10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    local.select,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: selectedCategory,
                    items:
                        ['all', 'tractors', 'harvesters', 'sprayers', 'seeders']
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e[0].toUpperCase() + e.substring(1),
                                ),
                              ),
                            )
                            .toList(),
                    onChanged: (val) =>
                        setState(() => selectedCategory = val ?? 'all'),
                    decoration: InputDecoration(labelText: local.categoryLabel),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(labelText: local.locationLabel),
                    onChanged: (val) => setState(() => locationQuery = val),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: selectedDuration,
                    items: ['all', 'daily', 'weekly', 'seasonal']
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e[0].toUpperCase() + e.substring(1)),
                          ),
                        )
                        .toList(),
                    onChanged: (val) =>
                        setState(() => selectedDuration = val ?? 'all'),
                    decoration: InputDecoration(
                      labelText: local.rentalDurationLabel,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            local.availableEquipment,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.greenAccent,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: filteredEquipment.map((item) {
              return Center(
                child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        item['image'] ?? '',
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        item['name'] ?? '',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${local.availabilityLabel}: ${item['availability'] ?? ''}',
                      ),
                      Text('${local.locationLabel}: ${item['location'] ?? ''}'),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () =>
                            showBookingDialog(item['name'] ?? 'Equipment'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: Text(local.bookNow),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 40),
          const Divider(),
          Center(
            child: Column(
              children: [
                Text(local.footerCopyright),
                TextButton(onPressed: () {}, child: Text(local.privacyPolicy)),
                TextButton(onPressed: () {}, child: Text(local.termsOfService)),
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
  late List<Map<String, String>> filteredCrops;

  final List<String> cities = [
    // India
    'Vijayawada,India',
    'Guntur,India',
    'Hyderabad,India',
    'Delhi,India',
    'Bangalore,India',
    'Chennai,India',
    'Mumbai,India',
    'Kolkata,India',
    'Pune,India',
    'Ahmedabad,India',
    'Jaipur,India',
    'Lucknow,India',
    'Kanpur,India',
    'Nagpur,India',
    'Surat,India',
    'Visakhapatnam,India',
    'Bhopal,India',
    'Patna,India',

    // USA
    'New York,USA',
    'Los Angeles,USA',
    'Chicago,USA',
    'Houston,USA',
    'Phoenix,USA',
    'Philadelphia,USA',
    'San Antonio,USA',
    'San Diego,USA',
    'Dallas,USA',
    'San Jose,USA',

    // Other major global cities
    'London,UK',
    'Paris,France',
    'Berlin,Germany',
    'Tokyo,Japan',
    'Beijing,China',
    'Shanghai,China',
    'Dubai,UAE',
    'Toronto,Canada',
    'Sydney,Australia',
    'Singapore,Singapore',
  ];

  String selectedCity = 'Guntur,India';
  Map<String, String> weatherData = {
    'temp': '--',
    'humidity': '--',
    'rainfall': '--',
    'wind': '--',
    'uv': '--',
  };

  @override
  void initState() {
    super.initState();
    filteredCrops = [];
    fetchWeather();
    initCrops();
  }

  void initCrops() {
    crops = [
      {
        'name': 'Tomato',
        'description': 'Default description',
        'image': 'https://via.placeholder.com/40',
      },
      {
        'name': 'Rice',
        'description': 'Default description',
        'image': 'https://via.placeholder.com/40',
      },
      {
        'name': 'Wheat',
        'description': 'Default description',
        'image': 'https://via.placeholder.com/40',
      },
    ];
    filteredCrops = List<Map<String, String>>.from(crops);
  }

  List<Map<String, String>> crops = [];
  late String close;

  void onSearch(String query) {
    setState(() {
      filteredCrops = crops
          .where(
            (crop) => crop['name']!.toLowerCase().contains(query.toLowerCase()),
          )
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
            child: Text(close),
          ),
        ],
      ),
    );
  }

  Future<void> fetchWeather() async {
    final apiKey = '67945eb269d49f8603f2d1202b4da427';
    final city = selectedCity.split(',')[0];
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(url));
      final data = jsonDecode(response.body);

      setState(() {
        weatherData = {
          'temp': '${data['main']['temp']}°C',
          'humidity': '${data['main']['humidity']}%',
          'rainfall': data['rain'] != null
              ? '${data['rain']['1h'] ?? 0} mm'
              : '0 mm',
          'wind': '${data['wind']['speed']} m/s',
          'uv': 'N/A', // You can get UV from separate API if needed
        };
      });
    } catch (e) {
      print("Weather fetch failed: $e");
    }
  }

  Widget buildDataTable(
    String title,
    List<List<String>> rows,
    List<String> headers,
  ) {
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
          Text(
            title,
            style: const TextStyle(fontSize: 20, color: Colors.greenAccent),
          ),
          const SizedBox(height: 10),
          Table(
            border: TableBorder.all(color: Colors.black87),
            children: [
              TableRow(
                children: headers
                    .map(
                      (h) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          h,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                    .toList(),
              ),
              ...rows.map(
                (row) => TableRow(
                  children: row
                      .map(
                        (cell) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(cell),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    close = local.close;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0d091e),
        title: Row(
          children: [
            Image.asset('assets/logo.png.jpg', width: 35),
            const SizedBox(width: 8),
            Text(local.weatherPageTitle),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 🔽 City Dropdown
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on, color: Colors.white),
              const SizedBox(width: 8),
              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  dropdownColor: Colors.grey[900],
                  value: selectedCity,
                  style: const TextStyle(color: Colors.white),
                  menuMaxHeight: 200, // ✅ Approx. height to show 5 items
                  items: cities
                      .map(
                        (city) =>
                            DropdownMenuItem(value: city, child: Text(city)),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedCity = value;
                      });
                      fetchWeather();
                    }
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // 🌡️ Weather Table
          buildDataTable(
            local.currentWeatherTitle,
            [
              [
                selectedCity,
                weatherData['temp'] ?? '--',
                weatherData['humidity'] ?? '--',
                weatherData['rainfall'] ?? '--',
                weatherData['wind'] ?? '--',
                weatherData['uv'] ?? '--',
              ],
            ],
            [
              local.location,
              local.temperature,
              local.humidity,
              local.rainfall,
              local.windSpeed,
              local.uvIndex,
            ],
          ),

          buildDataTable(
            local.seasonalForecastTitle,
            [
              ['25-30°C', '150 mm', 'Low'],
            ],
            [
              local.expectedTemperature,
              local.rainfallForecast,
              local.frostRisk,
            ],
          ),

          const SizedBox(height: 20),

          // 🔍 Search Crops
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: searchController,
                onChanged: onSearch,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: local.searchCropHint,
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
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: filteredCrops
                        .map(
                          (crop) => ListTile(
                            leading: Image.network(crop['image']!),
                            title: Text(
                              crop['name']!,
                              style: const TextStyle(color: Colors.black),
                            ),
                            onTap: () => showCropDetails(context, crop),
                          ),
                        )
                        .toList(),
                  ),
                ),
            ],
          ),
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
      'benefit': 'Rich in fiber',
    },
    {
      'name': 'Banana',
      'price': '50/dozen',
      'season': 'Year-round',
      'benefit': 'High potassium',
    },
    {
      'name': 'Orange',
      'price': '80/kg',
      'season': 'Winter',
      'benefit': 'High vitamin C',
    },
    {
      'name': 'Grapes',
      'price': '120/kg',
      'season': 'Summer',
      'benefit': 'Antioxidants',
    },
  ];

  final List<Map<String, String>> vegetables = [
    {
      'name': 'Tomato',
      'price': '40/kg',
      'season': 'Summer',
      'benefit': 'Vitamin C',
    },
    {
      'name': 'Potato',
      'price': '30/kg',
      'season': 'Year-round',
      'benefit': 'Carbohydrates',
    },
    {
      'name': 'Cabbage',
      'price': '25/kg',
      'season': 'Winter',
      'benefit': 'Vitamin K',
    },
    {
      'name': 'Carrot',
      'price': '40/kg',
      'season': 'Winter',
      'benefit': 'Beta-carotene',
    },
  ];

  List<Map<String, String>> get filteredItems =>
      (showFruits ? fruits : vegetables)
          .where(
            (item) =>
                item['name']!.toLowerCase().contains(searchQuery.toLowerCase()),
          )
          .toList();

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    // Localization values
    String appTitle = local.appTitle;
    String contactUs = local.contactUs;
    String trends = local.trends;

    String agricultureTitle = local.agricultureTitle;
    String agricultureContent = local.agricultureContent;
    String importanceTitle = local.importanceTitle;
    String importanceContent = local.importanceContent;
    String challengesTitle = local.challengesTitle;
    String challengesContent = local.challengesContent;

    String fruitsButton = local.fruitsButton;
    String vegetablesButton = local.vegetablesButton;
    String searchPlaceholder = local.searchPlaceholder;

    String fruitsAndPrices = local.fruitsAndPrices;
    String vegetablesAndPrices = local.vegetablesAndPrices;
    String tableName = local.tableName;
    String tablePrice = local.tablePrice;
    String tableSeason = local.tableSeason;
    String tableBenefit = local.tableBenefit;

    String samplePriceTrends = local.samplePriceTrends;
    String footerCopyright = local.footerCopyright;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0d091e),
        title: Text(appTitle),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(trends, style: const TextStyle(color: Colors.amber)),
          ),
          TextButton(
            onPressed: () {},
            child: Text(contactUs, style: const TextStyle(color: Colors.amber)),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionBox(agricultureTitle, agricultureContent),
          _sectionBox(importanceTitle, importanceContent),
          _sectionBox(challengesTitle, challengesContent),

          // Fruits/Vegetables toggle
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => setState(() => showFruits = true),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: Text(fruitsButton),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => setState(() => showFruits = false),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: Text(vegetablesButton),
              ),
            ],
          ),

          // Search
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: TextField(
              onChanged: (value) => setState(() => searchQuery = value),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: searchPlaceholder,
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

          // Table
          Text(
            showFruits ? fruitsAndPrices : vegetablesAndPrices,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.greenAccent,
            ),
          ),
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
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      tableName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      tablePrice,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      tableSeason,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      tableBenefit,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              ...filteredItems.map(
                (item) => TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(item['name']!),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(item['price']!),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(item['season']!),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(item['benefit']!),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          // Chart
          Text(
            samplePriceTrends,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.greenAccent,
            ),
          ),
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
                            FlSpot(4, 170),
                          ]
                        : [
                            FlSpot(0, 40),
                            FlSpot(1, 42),
                            FlSpot(2, 38),
                            FlSpot(3, 45),
                            FlSpot(4, 50),
                          ],
                    isCurved: true,
                    barWidth: 3,
                    color: showFruits
                        ? Colors.greenAccent
                        : Colors.orangeAccent,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),
          Center(child: Text(footerCopyright)),
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
          Text(
            title,
            style: const TextStyle(fontSize: 20, color: Colors.greenAccent),
          ),
          const SizedBox(height: 8),
          Text(content),
        ],
      ),
    );
  }
}

class _EquipmentViewScreenState extends State<EquipmentViewScreen> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    final List<EquipmentItem> items = [
      EquipmentItem(local.equipmentQ1, local.equipmentA1),
      EquipmentItem(local.equipmentQ2, local.equipmentA2),
      EquipmentItem(local.equipmentQ3, local.equipmentA3),
      EquipmentItem(local.equipmentQ4, local.equipmentA4),
      EquipmentItem(local.equipmentQ5, local.equipmentA5),
      EquipmentItem(local.equipmentQ6, local.equipmentA6),
      EquipmentItem(local.equipmentQ7, local.equipmentA7),
      EquipmentItem(local.equipmentQ8, local.equipmentA8),
    ];

    final filteredItems = items
        .where(
          (item) =>
              item.question.toLowerCase().contains(searchQuery.toLowerCase()) ||
              item.answer.toLowerCase().contains(searchQuery.toLowerCase()),
        )
        .toList();

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(40),
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
                Text(
                  local.equipmentFaqTitle,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  onChanged: (value) => setState(() => searchQuery = value),
                  decoration: InputDecoration(
                    hintText: local.equipmentSearchHint,
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
                ...filteredItems.asMap().entries.map(
                  (entry) => ExpansionTile(
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
                      ),
                    ],
                  ),
                ),
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

class CropsViewScreen extends StatefulWidget {
  const CropsViewScreen({super.key});

  @override
  State<CropsViewScreen> createState() => _CropsViewScreenState();
}

class _CropsViewScreenState extends State<CropsViewScreen> {
  late final List<CropsItem> faqItems;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final local = AppLocalizations.of(context)!;
    faqItems = [
      CropsItem(
        category: 'Buyers',
        question: local.cropsFaqQ1,
        answer: local.cropsFaqA1,
      ),
      CropsItem(
        category: 'Buyers',
        question: local.cropsFaqQ2,
        answer: local.cropsFaqA2,
      ),
      CropsItem(
        category: 'Buyers',
        question: local.cropsFaqQ3,
        answer: local.cropsFaqA3,
      ),
      CropsItem(
        category: 'Buyers',
        question: local.cropsFaqQ4,
        answer: local.cropsFaqA4,
      ),
      CropsItem(
        category: 'Buyers',
        question: local.cropsFaqQ5,
        answer: local.cropsFaqA5,
      ),
      CropsItem(
        category: 'Farmers',
        question: local.cropsFaqQ6,
        answer: local.cropsFaqA6,
      ),
      CropsItem(
        category: 'Farmers',
        question: local.cropsFaqQ7,
        answer: local.cropsFaqA7,
      ),
      CropsItem(
        category: 'Farmers',
        question: local.cropsFaqQ8,
        answer: local.cropsFaqA8,
      ),
      CropsItem(
        category: 'Farmers',
        question: local.cropsFaqQ9,
        answer: local.cropsFaqA9,
      ),
      CropsItem(
        category: 'Farmers',
        question: local.cropsFaqQ10,
        answer: local.cropsFaqA10,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 20),
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
                Text(
                  local.cropsFaqTitle,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                ..._buildFAQSections(local),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFAQSections(AppLocalizations local) {
    final buyerFAQs = faqItems
        .where((item) => item.category == 'Buyers')
        .toList();
    final farmerFAQs = faqItems
        .where((item) => item.category == 'Farmers')
        .toList();

    return [
      _buildCategorySection(local.faqsForBuyers, buyerFAQs),
      const SizedBox(height: 20),
      _buildCategorySection(local.faqsForFarmers, farmerFAQs),
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
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
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
            title: Text(
              '${index + 1}. ${item.question}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  item.answer,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ],
          );
        }),
      ],
    );
  }
}

class ProduceFAQScreen extends StatefulWidget {
  const ProduceFAQScreen({super.key});

  @override
  State<ProduceFAQScreen> createState() => _ProduceFAQScreenState();
}

class _ProduceFAQScreenState extends State<ProduceFAQScreen> {
  late final List<Map<String, String>> faqData;
  String searchQuery = '';
  final ScrollController _scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final local = AppLocalizations.of(context)!;

    faqData = [
      {'question': local.faqQ1, 'answer': local.faqA1},
      {'question': local.faqQ2, 'answer': local.faqA2},
      {'question': local.faqQ3, 'answer': local.faqA3},
      {'question': local.faqQ4, 'answer': local.faqA4},
      {'question': local.faqQ5, 'answer': local.faqA5},
      {'question': local.faqQ6, 'answer': local.faqA6},
      {'question': local.faqQ7, 'answer': local.faqA7},
      {'question': local.faqQ8, 'answer': local.faqA8},
    ];
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    final filteredData = faqData.where((faq) {
      final query = searchQuery.trim().toLowerCase();
      final question = faq['question']!.toLowerCase();
      final answer = faq['answer']!.toLowerCase();
      return query
          .split(' ')
          .every((word) => question.contains(word) || answer.contains(word));
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0d091e),
        title: Row(
          children: [
            Image.asset('assets/logo.png.jpg', width: 35),
            const SizedBox(width: 8),
            Text(local.appTitle),
          ],
        ),
        actions: [
          PopupMenuButton<int>(
            icon: const Icon(Icons.more_vert, color: Colors.amber),
            itemBuilder: (context) => [
              PopupMenuItem(value: 1, child: Text(local.aboutUs)),
              PopupMenuItem(value: 2, child: Text(local.contactUs)),
            ],
            onSelected: (value) {
              if (value == 1) {
                Navigator.pushNamed(context, '/about');
              } else if (value == 2) {
                Navigator.pushNamed(context, '/contact');
              }
            },
          ),
        ],
        centerTitle: true,
        elevation: 2,
      ),
      body: ListView(
        controller: _scrollController,
        padding: const EdgeInsets.all(30),
        children: [
          Center(
            child: Text(
              local.produceFaqTitle,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.greenAccent,
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            onChanged: (value) {
              setState(() => searchQuery = value);
              _scrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            },
            decoration: InputDecoration(
              hintText: local.searchFaqHint,
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
          if (filteredData.isEmpty)
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: Text(
                  local.noFaqsFound,
                  style: const TextStyle(color: Colors.redAccent, fontSize: 16),
                ),
              ),
            ),
          ...filteredData.asMap().entries.map((entry) {
            final index = entry.key;
            final faq = entry.value;
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              color: Colors.green.shade700,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ExpansionTile(
                collapsedBackgroundColor: Colors.green,
                backgroundColor: Colors.green.shade700,
                collapsedTextColor: Colors.white,
                textColor: Colors.white,
                iconColor: Colors.white,
                title: Text(
                  '${index + 1}. ${faq['question']}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(12),
                      ),
                    ),
                    child: Text(
                      faq['answer']!,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 30),
          const Divider(color: Colors.white24),
          Center(
            child: Text(
              local.footerCopyright,
              style: const TextStyle(color: Colors.white54),
            ),
          ),
        ],
      ),
    );
  }
}

class BuyerDashboardPage extends StatelessWidget {
  const BuyerDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    final List<Map<String, dynamic>> dashboardItems = [
      {"icon": Icons.apple, "title": local.itemOrganicFruits},
      {"icon": Icons.car_rental, "title": local.itemFreshVegetables},
      {"icon": Icons.local_drink, "title": local.itemDairyProducts},
      {"icon": Icons.egg, "title": local.itemPoultryProducts},
      {
        "icon": Icons.local_fire_department,
        "title": local.itemExoticVegetables,
      },
    ];

    final List<Map<String, String>> testimonials = [
      {"quote": local.testimonial1, "author": local.testimonial1Author},
      {"quote": local.testimonial2, "author": local.testimonial2Author},
      {"quote": local.testimonial3, "author": local.testimonial3Author},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0d091e),
        title: Row(children: [Text(local.appTitle)]),
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.person, color: Colors.white),
            label: SizedBox.shrink(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
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
                children: [
                  Center(
                    child: Text(
                      local.welcomeTitle,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    local.welcomeSubtitle,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),

            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: local.searchAnything,
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

            // Dashboard
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  Text(
                    local.buyerDashboard,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                            if (item['title'] == local.itemOrganicFruits) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => OrganicFruitMarketplace(),
                                ),
                              );
                            } else if (item['title'] ==
                                local.itemFreshVegetables) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => FreshVegetablesMarketplace(),
                                ),
                              );
                            } else if (item['title'] ==
                                local.itemDairyProducts) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => OrganicDairyMarketplace(),
                                ),
                              );
                            } else if (item['title'] ==
                                local.itemPoultryProducts) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PoultryMarketplace(),
                                ),
                              );
                            } else if (item['title'] ==
                                local.itemExoticVegetables) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ExoticVegetablesMarketplace(),
                                ),
                              );
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
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  item['icon'],
                                  size: 40,
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  item['title'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
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

            // Testimonials
            Container(
              color: const Color(0xFF2c2c2c),
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
              child: Column(
                children: [
                  Text(
                    local.testimonialTitle,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ...testimonials.map(
                    (t) => Column(
                      children: [
                        Text(
                          "\"${t['quote']}\"",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          t['author']!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Footer
            Container(
              color: const Color(0xFF0d091e),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(local.footerCopyright, textAlign: TextAlign.center),
                  const SizedBox(height: 5),
                  Text(local.footerSupport, textAlign: TextAlign.center),
                ],
              ),
            ),
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
          'rating': 4.8,
        },
        {
          'name': 'Suresh Patel',
          'location': 'Valsad, Gujarat',
          'quantity': '800 kg available',
          'rating': 4.6,
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
          'rating': 4.9,
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;

    final String pageTitle = local.organicFruitMarketplace;
    final String subtitle = local.organicFruitSubtitle;
    final String searchHint = local.searchFruitsHint;
    final String varietyLabel = local.variety;
    final String seasonLabel = local.season;

    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(pageTitle),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.grey, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF1a1a1a),
                    hintText: searchHint,
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.greenAccent,
                    ),
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
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: fruits.map((fruit) {
              final String farmersAvailable = local.farmersAvailable(
                fruit['farmers'].length,
              );
              return GestureDetector(
                onTap: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: const Color(0xFF1a1a1a),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  builder: (_) => FruitDetailSheet(fruit: fruit),
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
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(15),
                        ),
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
                            Text(
                              fruit['name'],
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.greenAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '$varietyLabel: ${fruit['variety']}',
                              style: const TextStyle(color: Colors.grey),
                            ),
                            Text(
                              '$seasonLabel: ${fruit['season']}',
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '${fruit['farmers'].length} $farmersAvailable',
                              style: const TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
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
          Text(
            fruit['name'],
            style: TextStyle(
              fontSize: 24,
              color: Colors.greenAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Variety: ${fruit['variety']}",
            style: TextStyle(color: Colors.white70),
          ),
          Text(
            "Season: ${fruit['season']}",
            style: TextStyle(color: Colors.white70),
          ),
          Text(
            "Description: ${fruit['description']}",
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 20),
          Text(
            "Available Farmers",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ...fruit['farmers'].map<Widget>(
            (farmer) => Container(
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
                  Text(
                    farmer['name'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent,
                    ),
                  ),
                  Text(
                    "Location: ${farmer['location']}",
                    style: TextStyle(color: Colors.white70),
                  ),
                  Text(
                    "Quantity: ${farmer['quantity']}",
                    style: TextStyle(color: Colors.white70),
                  ),
                  Row(
                    children: [
                      Text("Rating: ", style: TextStyle(color: Colors.white70)),
                      Row(
                        children: List.generate(
                          (farmer['rating']).round(),
                          (index) =>
                              Icon(Icons.star, color: Colors.amber, size: 16),
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        "${farmer['rating']}",
                        style: TextStyle(color: Colors.white70),
                      ),
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
                        child: Text(
                          "Chat",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => MakeDealPopup()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                        ),
                        child: Text("Make a Deal"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
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
            color: const Color.fromARGB(255, 152, 39, 39),
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
                        child: Text(
                          'Propose a Deal',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
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
                            .map(
                              (crop) => DropdownMenuItem(
                                value: crop,
                                child: Text(crop),
                              ),
                            )
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
                                  decoration: InputDecoration(
                                    hintText: 'Start Date',
                                  ),
                                  onTap: () async {
                                    DateTime? picked = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2100),
                                    );
                                    setState(() => _fromDate = picked);
                                  },
                                  controller: TextEditingController(
                                    text: _fromDate == null
                                        ? ''
                                        : _fromDate!.toLocal().toString().split(
                                            ' ',
                                          )[0],
                                  ),
                                  validator: (value) =>
                                      value == '' ? 'Select start date' : null,
                                ),
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
                                  decoration: InputDecoration(
                                    hintText: 'End Date',
                                  ),
                                  onTap: () async {
                                    DateTime? picked = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2100),
                                    );
                                    if (picked != null &&
                                        _fromDate != null &&
                                        picked.isBefore(_fromDate!)) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'End date must be after start date',
                                          ),
                                        ),
                                      );
                                      return;
                                    }
                                    setState(() => _toDate = picked);
                                  },
                                  controller: TextEditingController(
                                    text: _toDate == null
                                        ? ''
                                        : _toDate!.toLocal().toString().split(
                                            ' ',
                                          )[0],
                                  ),
                                  validator: (value) =>
                                      value == '' ? 'Select end date' : null,
                                ),
                              ],
                            ),
                          ),
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
                        decoration: InputDecoration(
                          labelText: 'Contact Information',
                        ),
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
                              decoration: InputDecoration(
                                labelText: 'Quantity',
                              ),
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
                                  .map(
                                    (unit) => DropdownMenuItem(
                                      value: unit,
                                      child: Text(unit),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (val) => setState(() => _unit = val),
                            ),
                          ),
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
                        ),
                    ],
                  ),
                ),
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
        },
      ],
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
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;

    // Localized strings
    final String title = local.freshVegetablesMarketplace;
    final String subtitle = local.freshVegetablesSubtitle;
    final String searchHint = local.searchVegetablesHint;
    final String varietyLabel = local.variety;
    final String seasonLabel = local.season;
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(title),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFF1a1a1a),
                          hintText: searchHint,
                          hintStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.greenAccent,
                          ),
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
                    final String farmersAvailable = local.farmersAvailable(
                      veg['farmers'].length,
                    );
                    return GestureDetector(
                      onTap: () => showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: const Color(0xFF1a1a1a),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
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
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(15),
                              ),
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
                                  Text(
                                    veg['name'],
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.greenAccent,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '$varietyLabel: ${veg['variety']}',
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                  Text(
                                    '$seasonLabel: ${veg['season']}',
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '${veg['farmers'].length} $farmersAvailable',
                                    style: const TextStyle(color: Colors.green),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
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
          'rating': 4.8,
        },
        {
          'name': 'Suresh Patel',
          'location': 'Valsad, Gujarat',
          'quantity': '800 liters available',
          'rating': 4.6,
        },
      ],
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
          'rating': 4.9,
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;

    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0d091e),
        title: Text(local.dairyMarketplaceTitle),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            local.dairyMarketplaceSubtitle,
            style: const TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF1a1a1a),
                    hintText: local.searchDairyHint,
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.greenAccent,
                    ),
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
            children: dairyItems.map((item) {
              return GestureDetector(
                onTap: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: const Color(0xFF1a1a1a),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  builder: (_) => DairyDetailSheet(dairy: item),
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
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(15),
                        ),
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
                            Text(
                              item['name'],
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.greenAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${local.varietyLabel}: ${item['variety']}",
                              style: const TextStyle(color: Colors.grey),
                            ),
                            Text(
                              "${local.seasonLabel}: ${item['season']}",
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              local.farmersAvailable(item['farmers'].length),
                              style: const TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
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
    final local = AppLocalizations.of(context)!;
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
          Text(
            dairy['name'],
            style: const TextStyle(
              fontSize: 24,
              color: Colors.greenAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "${local.varietyLabel}: ${dairy['variety']}",
            style: const TextStyle(color: Colors.white70),
          ),
          Text(
            "${local.seasonLabel}: ${dairy['season']}",
            style: const TextStyle(color: Colors.white70),
          ),
          Text(
            "${local.descriptionLabel}: ${dairy['description']}",
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 20),
          Text(
            local.availableFarmers,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ...dairy['farmers'].map<Widget>(
            (farmer) => Container(
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
                  Text(
                    farmer['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent,
                    ),
                  ),
                  Text(
                    "${local.locationLabel}: ${farmer['location']}",
                    style: const TextStyle(color: Colors.white70),
                  ),
                  Text(
                    "${local.quantityLabel}: ${farmer['quantity']}",
                    style: const TextStyle(color: Colors.white70),
                  ),
                  Row(
                    children: [
                      Text(
                        "${local.ratingLabel}: ",
                        style: const TextStyle(color: Colors.white70),
                      ),
                      Row(
                        children: List.generate(
                          (farmer['rating']).round(),
                          (index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "${farmer['rating']}",
                        style: const TextStyle(color: Colors.white70),
                      ),
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
                        child: Text(
                          local.chatButton,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => MakeDealPopup()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                        ),
                        child: Text(local.makeDealButton),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
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
          'rating': 4.7,
        },
        {
          'name': 'Anita Sharma',
          'location': 'Jaipur, Rajasthan',
          'quantity': '200 kg available',
          'rating': 4.8,
        },
      ],
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
          'rating': 4.9,
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;

    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0d091e),
        title: Text(local.poultryMarketplaceTitle),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            local.poultryMarketplaceSubtitle,
            style: const TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF1a1a1a),
                    hintText: local.searchPoultryHint,
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.greenAccent,
                    ),
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
            children: poultryItems.map((item) {
              return GestureDetector(
                onTap: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: const Color(0xFF1a1a1a),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  builder: (_) => PoultryDetailSheet(poultry: item),
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
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(15),
                        ),
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
                            Text(
                              item['name'],
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.greenAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${local.varietyLabel}: ${item['variety']}",
                              style: const TextStyle(color: Colors.grey),
                            ),
                            Text(
                              "${local.seasonLabel}: ${item['season']}",
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              local.farmersAvailable(item['farmers'].length),
                              style: const TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
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
    final local = AppLocalizations.of(context)!;

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
          Text(
            poultry['name'],
            style: const TextStyle(
              fontSize: 24,
              color: Colors.greenAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "${local.varietyLabel}: ${poultry['variety']}",
            style: const TextStyle(color: Colors.white70),
          ),
          Text(
            "${local.seasonLabel}: ${poultry['season']}",
            style: const TextStyle(color: Colors.white70),
          ),
          Text(
            "${local.descriptionLabel}: ${poultry['description']}",
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 20),
          Text(
            local.availableFarmers,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ...poultry['farmers'].map<Widget>(
            (farmer) => Container(
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
                  Text(
                    farmer['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent,
                    ),
                  ),
                  Text(
                    "${local.locationLabel}: ${farmer['location']}",
                    style: const TextStyle(color: Colors.white70),
                  ),
                  Text(
                    "${local.quantityLabel}: ${farmer['quantity']}",
                    style: const TextStyle(color: Colors.white70),
                  ),
                  Row(
                    children: [
                      Text(
                        "${local.ratingLabel}: ",
                        style: const TextStyle(color: Colors.white70),
                      ),
                      Row(
                        children: List.generate(
                          (farmer['rating']).round(),
                          (index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "${farmer['rating']}",
                        style: const TextStyle(color: Colors.white70),
                      ),
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
                        child: Text(
                          local.chatButton,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => MakeDealPopup()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                        ),
                        child: Text(local.makeDealButton),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
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
          Text(
            vegetable['name'],
            style: const TextStyle(
              fontSize: 24,
              color: Colors.greenAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Variety: ${vegetable['variety']}",
            style: const TextStyle(color: Colors.white70),
          ),
          Text(
            "Season: ${vegetable['season']}",
            style: const TextStyle(color: Colors.white70),
          ),
          Text(
            "Description: ${vegetable['description']}",
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 20),
          const Text(
            "Available Farmers",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ...vegetable['farmers'].map<Widget>(
            (farmer) => Container(
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
                  Text(
                    farmer['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent,
                    ),
                  ),
                  Text(
                    "Location: ${farmer['location']}",
                    style: const TextStyle(color: Colors.white70),
                  ),
                  Text(
                    "Quantity: ${farmer['quantity']}",
                    style: const TextStyle(color: Colors.white70),
                  ),
                  Row(
                    children: [
                      const Text(
                        "Rating: ",
                        style: TextStyle(color: Colors.white70),
                      ),
                      Row(
                        children: List.generate(
                          (farmer['rating']).round(),
                          (index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "${farmer['rating']}",
                        style: const TextStyle(color: Colors.white70),
                      ),
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
                        child: const Text(
                          "Chat",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => MakeDealPopup()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                        ),
                        child: const Text("Make a Deal"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
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
          'rating': 4.6,
        },
        {
          'name': 'Sita Devi',
          'location': 'Madhya Pradesh',
          'quantity': '100 kg available',
          'rating': 4.5,
        },
      ],
    },
    {
      'id': 2,
      'name': 'Celery',
      'variety': 'Pascal',
      'season': 'March-June',
      'image':
          'https://agricultureguruji.com/wp-content/uploads/2018/08/vegetables-673181_1280.jpg',
      'description':
          'Pascal celery known for its crisp, flavorful stalks and high-quality yield.',
      'farmers': [
        {
          'name': 'Anil Verma',
          'location': 'Maharashtra',
          'quantity': '200 kg available',
          'rating': 4.8,
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0d091e),
        title: Text(local.exoticVegetablesMarketplaceTitle),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              local.exoticVegetablesMarketplaceSubtitle,
              style: const TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF1a1a1a),
                hintText: local.searchExoticVegetablesHint,
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
                .map((veg) => _vegetableCard(context, veg, isMobile, local))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _vegetableCard(
    BuildContext context,
    Map<String, dynamic> veg,
    bool isMobile,
    AppLocalizations local,
  ) {
    return GestureDetector(
      onTap: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: const Color(0xFF1a1a1a),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (_) => _vegetableDetailSheet(veg, context, local),
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
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(15),
              ),
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
                  Text(
                    veg['name'],
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.greenAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${local.varietyLabel}: ${veg['variety']}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  Text(
                    "${local.seasonLabel}: ${veg['season']}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    local.farmersAvailable(veg['farmers'].length),
                    style: const TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _vegetableDetailSheet(
    Map<String, dynamic> veg,
    BuildContext context,
    AppLocalizations local,
  ) {
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
          Text(
            veg['name'],
            style: const TextStyle(
              fontSize: 24,
              color: Colors.greenAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "${local.varietyLabel}: ${veg['variety']}",
            style: const TextStyle(color: Colors.white70),
          ),
          Text(
            "${local.seasonLabel}: ${veg['season']}",
            style: const TextStyle(color: Colors.white70),
          ),
          Text(
            "${local.descriptionLabel}: ${veg['description']}",
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 20),
          Text(
            local.availableFarmers,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ...veg['farmers']
              .map<Widget>((farmer) => _farmerCard(context, farmer, local))
              .toList(),
        ],
      ),
    );
  }

  Widget _farmerCard(
    BuildContext context,
    Map<String, dynamic> farmer,
    AppLocalizations local,
  ) {
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
          Text(
            farmer['name'],
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.greenAccent,
            ),
          ),
          Text(
            "${local.locationLabel}: ${farmer['location']}",
            style: const TextStyle(color: Colors.white70),
          ),
          Text(
            "${local.quantityLabel}: ${farmer['quantity']}",
            style: const TextStyle(color: Colors.white70),
          ),
          Row(
            children: [
              Text(
                "${local.ratingLabel}: ",
                style: const TextStyle(color: Colors.white70),
              ),
              Row(
                children: List.generate(
                  (farmer['rating']).round(),
                  (index) =>
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                ),
              ),
              const SizedBox(width: 5),
              Text(
                "${farmer['rating']}",
                style: const TextStyle(color: Colors.white70),
              ),
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
                child: Text(
                  local.chatButton,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => MakeDealPopup()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                ),
                child: Text(local.makeDealButton),
              ),
            ],
          ),
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
        title: const Text(
          'Contract Details',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 91, 119, 91),
          ),
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
                            bottom: BorderSide(color: Color(0xFF374151)),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Rice Supply Contract',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF9FE62C),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.chat_bubble_outline,
                                color: Color(0xFF9FE62C),
                              ),
                              onPressed: () {
                                setState(() {
                                  showChat = true;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: isMobile
                            ? Column(
                                children: [
                                  _buyerInfo(),
                                  const SizedBox(height: 24),
                                  _contractInfo(),
                                ],
                              )
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(child: _buyerInfo()),
                                  const SizedBox(width: 24),
                                  Expanded(child: _contractInfo()),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (showChat)
            Positioned(
              bottom: 80,
              right: 16,
              child: ChatWidget(
                onClose: () => setState(() => showChat = false),
              ),
            ),
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
        Text(
          'Buyer Information',
          style: TextStyle(color: Color(0xFF9FE62C), fontSize: 18),
        ),
        SizedBox(height: 16),
        InfoItem(icon: Icons.person, text: 'Name: Sarah Johnson'),
        InfoItem(icon: Icons.access_time, text: 'Status: Active'),
        InfoItem(icon: Icons.calendar_today, text: 'Join Date: 2023-12-01'),
      ],
    );
  }

  Widget _contractInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Contract Details',
          style: TextStyle(color: Color(0xFF9FE62C), fontSize: 18),
        ),
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
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 4)),
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
                const Text(
                  'Chat with Buyer',
                  style: TextStyle(color: Color(0xFF111827)),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Color(0xFF111827)),
                  onPressed: onClose,
                ),
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
          ),
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

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String role = 'farmer';

  void handleLogin() async {
    final url = Uri.parse('http://65.1.134.172:8000/kisanlogin/');

    final identifier = emailController.text.trim(); // could be email or phone
    final password = passwordController.text.trim();

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"identifier": identifier, "password": password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final userType = data['user_type'];

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Welcome  ${userType}  (${data['full_name']})'),
          ),
        );

        if (userType == 'Farmer') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FarmerDashboard()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BuyerDashboardPage()),
          );
        }
      } else {
        final error = jsonDecode(response.body)['error'];
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('❌ Login failed: $error')));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('🔥 Network error: $e')));
    }
  }

  void handleForgotPassword() {
    String recoveryPage = role == 'farmer'
        ? 'FarmerForgotPassword'
        : 'BuyerForgotPassword';
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Navigating to $recoveryPage...')));
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0D091E),
        title: Row(children: [SizedBox(width: 35), Text('Kisan Konnect')]),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: media.height * 0.05),
            Center(
              child: Text(
                'Login\nPlease enter your credentials',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: media.height * 0.05),
            Container(
              width: media.width * 0.85,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
              ),
              child: Column(
                children: [
                  Text(
                    'Welcome Back!',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Password'),
                  ),

                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF000702),
                      minimumSize: Size(double.infinity, 48),
                    ),
                    child: Text('Login'),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: handleForgotPassword,
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.greenAccent),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Place this inside your widget's build method:
                  Text.rich(
                    TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "Register as a Farmer",
                          style: TextStyle(color: Colors.greenAccent),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Navigate to Farmer Registration Page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      FarmerRegistrationPage(),
                                ),
                              );
                            },
                        ),
                        const TextSpan(text: " | "),
                        TextSpan(
                          text: "Register as a Buyer",
                          style: TextStyle(color: Colors.greenAccent),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Navigate to Buyer Registration Page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BuyerRegistrationPage(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: media.height * 0.1),
            Divider(color: Colors.white54),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Text(
                    '© 2025 Kisan Konnect. All rights reserved.',
                    style: TextStyle(color: Colors.white70),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Customer Support: 1800 267 0997 | Email: customercare@kisankonnect.in',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FarmerRegistrationPage extends StatefulWidget {
  @override
  _FarmerRegistrationPageState createState() => _FarmerRegistrationPageState();
}

class _FarmerRegistrationPageState extends State<FarmerRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final pricinghourController = TextEditingController();
  final pricingdayController = TextEditingController();
  final totalacreController = TextEditingController();
  final typecropController = TextEditingController();

  final pricingweekController = TextEditingController();

  final pricingmonthController = TextEditingController();

  final pricingacreController = TextEditingController();

  final locationController = TextEditingController();
  final languageController = TextEditingController();
  String userType = "Farmer"; // or "Buyer"

  String? role;

  void handleSubmit() {
    if (_formKey.currentState!.validate()) {
      submitRegistrationData();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Registration Submitted")));
      // Handle backend logic here
    } else {
      // After successful registration, navigate to the login page or dashboard
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  Future<void> submitRegistrationData() async {
    final url = Uri.parse('http://65.1.134.172:8000/kisanregister/');

    // Common fields
    Map<String, dynamic> data = {
      "user_type": userType,
      "full_name": fullNameController.text.trim(),
      "email": emailController.text.trim(),
      "phone_number": phoneController.text.trim(),
      "password": passwordController.text.trim(),
    };

    // Farmer additional fields
    if (userType == "Farmer") {
      data.addAll({
        "no_of_acres": totalacreController.text.trim(),
        "crop_type": typecropController.text.trim(),
        "has_equipment": role,
        "pricing_per_hour": role == "Yes"
            ? pricinghourController.text.trim()
            : "",
        "pricing_per_day": role == "Yes"
            ? pricingdayController.text.trim()
            : "",
        "pricing_per_week": role == "Yes"
            ? pricingweekController.text.trim()
            : "",
        "pricing_per_month": role == "Yes"
            ? pricingmonthController.text.trim()
            : "",
        "pricing_per_acre": role == "Yes"
            ? pricingacreController.text.trim()
            : "",
        "location": role == "Yes" ? locationController.text.trim() : "",
        "language": role == "Yes" ? languageController.text.trim() : "",
      });
    }

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        print("✅ Registration successful");
        print(jsonDecode(response.body));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FarmerDashboard()),
        );
      } else {
        print("❌ Error: ${response.statusCode}");
        print(response.body);
      }
    } catch (e) {
      print("🔥 Exception: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D091E),
        title: Row(children: [const Text(" ")]),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              "About Us",
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              "Contact Us",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: size.height * 0.05,
          horizontal: size.width * 0.05,
        ),
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 600),
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 10)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(46, 137, 130, 0.8),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(15),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Farmer Registration',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        buildTextField("Full Name", fullNameController),
                        const SizedBox(height: 15),
                        buildTextField(
                          "Email Address",
                          emailController,
                          inputType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 15),
                        buildTextField(
                          "Phone Number",
                          phoneController,
                          inputType: TextInputType.phone,
                        ),
                        buildTextField(
                          "No of Acres of land",
                          totalacreController,
                          inputType: TextInputType.phone,
                        ),
                        buildTextField(
                          "Type of crop",
                          typecropController,
                          inputType: TextInputType.phone,
                        ),
                        DropdownButtonFormField<String>(
                          value: role,
                          items: [
                            DropdownMenuItem(child: Text("Yes"), value: "Yes"),
                            DropdownMenuItem(child: Text("No"), value: "No"),
                          ],
                          onChanged: (value) => setState(() => role = value),
                          decoration: InputDecoration(
                            labelText: 'Equipment Type',
                          ),
                          validator: (value) =>
                              value == null ? 'Please select an option' : null,
                        ),
                        if (role == 'Yes') ...[
                          buildTextField(
                            "Pricing per Hour",
                            pricinghourController,
                            inputType: TextInputType.phone,
                          ),
                          buildTextField(
                            "Pricing per Day",
                            pricingdayController,
                            inputType: TextInputType.phone,
                          ),
                          buildTextField(
                            "Pricing per Week",
                            pricingweekController,
                            inputType: TextInputType.phone,
                          ),
                          buildTextField(
                            "Pricing per Month",
                            pricingmonthController,
                            inputType: TextInputType.phone,
                          ),
                          buildTextField(
                            "Pricing per Acre",
                            pricingacreController,
                            inputType: TextInputType.phone,
                          ),
                          buildTextField(
                            "Location",
                            locationController,
                            inputType: TextInputType.phone,
                          ),
                          buildTextField(
                            "Language",
                            languageController,
                            inputType: TextInputType.phone,
                          ),
                        ],
                        SizedBox(height: 15),
                        buildTextField(
                          "Password",
                          passwordController,
                          isPassword: true,
                        ),
                        const SizedBox(height: 15),
                        buildTextField(
                          "Confirm Password",
                          confirmPasswordController,
                          isPassword: true,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: handleSubmit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF38BE14),
                            minimumSize: Size(double.infinity, 50),
                          ),
                          child: const Text("Register"),
                        ),
                        const SizedBox(height: 15),
                        TextButton(
                          onPressed: () {
                            submitRegistrationData();
                            // Navigate to login screen
                          },
                          child: const Text.rich(
                            TextSpan(
                              text: "Already have an account? ",
                              children: [
                                TextSpan(
                                  text: "Login",
                                  style: TextStyle(color: Color(0xFF38BE14)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          "© 2025 Kisan Konnect. All rights reserved.",
          style: TextStyle(color: Colors.white54),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget buildTextField(
    String label,
    TextEditingController controller, {
    TextInputType inputType = TextInputType.text,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: inputType,
          obscureText: isPassword,
          validator: (value) {
            if (value == null || value.isEmpty) return 'Please enter $label';
            if (label == 'Confirm Password' && value != passwordController.text)
              return 'Passwords do not match';
            return null;
          },
        ),
      ],
    );
  }
}

class BuyerRegistrationPage extends StatefulWidget {
  @override
  _BuyerRegistrationPageState createState() => _BuyerRegistrationPageState();
}

class _BuyerRegistrationPageState extends State<BuyerRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String userType = "Buyer";

  void handleRegister() async {
    await submitRegistrationData();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
    // You can navigate to dashboard here
  }

  Widget buildInputField(
    String label,
    TextEditingController controller, {
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          TextFormField(
            controller: controller,
            obscureText: isPassword,
            keyboardType: keyboardType,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Enter $label';
              if (label == 'Confirm Password' &&
                  value != passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Future<void> submitRegistrationData() async {
    final url = Uri.parse('http://65.1.134.172:8000/kisanregister/');

    // Common fields
    Map<String, dynamic> data = {
      "user_type": userType,
      "full_name": fullNameController.text.trim(),
      "email": emailController.text.trim(),
      "phone_number": phoneController.text.trim(),
      "password": passwordController.text.trim(),
    };

    // Farmer additional fields

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        print("✅ Registration successful");
        print(jsonDecode(response.body));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else {
        print("❌ Error: ${response.statusCode}");
        print(response.body);
      }
    } catch (e) {
      print("🔥 Exception: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D091E),
        title: Row(
          children: [
            // Make sure to include this in assets
            const Text(" "),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              "About Us",
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              "Contact Us",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: size.height * 0.05,
          horizontal: size.width * 0.05,
        ),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(color: Colors.black45, blurRadius: 8),
              ],
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(46, 137, 130, 0.8),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(15),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Buyer Registration',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        buildInputField("Full Name", fullNameController),
                        buildInputField(
                          "Phone Number",
                          phoneController,
                          keyboardType: TextInputType.phone,
                        ),
                        buildInputField(
                          "Email Address",
                          emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        buildInputField(
                          "Password",
                          passwordController,
                          isPassword: true,
                        ),
                        buildInputField(
                          "Confirm Password",
                          confirmPasswordController,
                          isPassword: true,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: handleRegister,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF38BE14),
                            minimumSize: const Size(double.infinity, 48),
                          ),
                          child: const Text("Register"),
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () async {
                            await submitRegistrationData();

                            // Navigate to login
                          },
                          child: Text.rich(
                            TextSpan(
                              text: "Already have an account? ",
                              children: [
                                TextSpan(
                                  text: "Login",
                                  style: TextStyle(
                                    color: Color(0xFF38BE14),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // 🔁 Navigate to login page or perform action
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) => LoginPage()),
                                      // );
                                      submitRegistrationData();
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
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.all(12.0),
        child: Text(
          "© 2025 Kisan Konnect. All rights reserved.",
          style: TextStyle(color: Colors.white54),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
