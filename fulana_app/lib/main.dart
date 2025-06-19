// ignore_for_file: library_prefixes

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as googleMaps;
import 'package:lottie/lottie.dart' as lottie;

void main() {
  runApp(const RomanticApp());
}

class RomanticApp extends StatelessWidget {
  const RomanticApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        textTheme: GoogleFonts.cardoTextTheme(),
      ),
      home: const RomanticHomePage(),
    );
  }
}

class RomanticHomePage extends StatefulWidget {
  const RomanticHomePage({super.key});

  @override
  State<RomanticHomePage> createState() => _RomanticHomePageState();
}

class _RomanticHomePageState extends State<RomanticHomePage> {
  late googleMaps.GoogleMapController _mapController;
  late googleMaps.LatLng _currentLocation;

  final Set<googleMaps.Marker> _markers = {};
final List<Map<String, String>> _bars = [
  {
    "name": "Charada Pampulha",
    "description": "Bar aconchegante com chope gelado e clima perfeito pra casal."
  },
  {
    "name": "Bistrô Chaplin",
    "description": "Ambiente intimista com pratos refinados e toque francês."
  },
  {
    "name": "Quintalzinho da Pampulha",
    "description": "Espaço ao ar livre, descontraído e cheio de charme."
  },
  {
    "name": "Chalezinho da Pampulha",
    "description": "Lugar romântico, com vista linda e clima de cabana dos sonhos."
  },
  {
    "name": "Bar do Museu Clube da Esquina",
    "description": "Música boa, vibes culturais e drinks autorais num cantinho especial."
  },
];


  @override
  void initState() {
    super.initState();
    _currentLocation = const googleMaps.LatLng(-19.8686, -43.9917);

    _markers.addAll([
      googleMaps.Marker(
        markerId: const googleMaps.MarkerId('charada'),
        position: const googleMaps.LatLng(-19.8655, -43.9924),
        infoWindow: const googleMaps.InfoWindow(title: 'Charada Pampulha'),
      ),
      googleMaps.Marker(
        markerId: const googleMaps.MarkerId('bistro'),
        position: const googleMaps.LatLng(-19.8702, -43.9932),
        infoWindow: const googleMaps.InfoWindow(title: 'Bistrô Chaplin'),
      ),
      googleMaps.Marker(
        markerId: const googleMaps.MarkerId('cafe'),
        position: const googleMaps.LatLng(-19.8731, -43.9872),
        infoWindow: const googleMaps.InfoWindow(title: 'Café com Letras'),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          googleMaps.GoogleMap(
            initialCameraPosition: googleMaps.CameraPosition(
              target: _currentLocation,
              zoom: 15,
            ),
            onMapCreated: (controller) => _mapController = controller,
            markers: _markers,
          ),

          // Texto animado com fundo
          Positioned(
            top: 60,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.pink.withOpacity(0.7),
                borderRadius: BorderRadius.circular(16),
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Bemm, qual lugar vc prefere para o nosso datee!',
                    textStyle: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    speed: const Duration(milliseconds: 90),
                  ),
                ],
                totalRepeatCount: 1,
                isRepeatingAnimation: false,
                pause: Duration.zero,
              ),
            ),
          ),

          // Lista de lugares
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 270,
              decoration: const BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _bars.length,
                itemBuilder: (context, index) {
                  final bar = _bars[index];
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      title: Text(
                        bar['name']!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                        ),
                      ),
                      subtitle: Text(
                        bar['description']!,
                        style: const TextStyle(fontSize: 14),
                      ),
                      onTap: () {
                        _mapController.animateCamera(
                          googleMaps.CameraUpdate.newLatLngZoom(
                            googleMaps.LatLng(
                              _currentLocation.latitude + index * 0.001,
                              _currentLocation.longitude + index * 0.001,
                            ),
                            16,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),

          // Foto da garota com sombra e borda
          Positioned(
            top: 120,
            right: 20,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(2, 4),
                  ),
                ],
                border: Border.all(color: Colors.white, width: 4),
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/Sample3.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Coração animado (opcional)
          Positioned(
            top: 15,
            right: -5,
            child: lottie.Lottie.asset(
              'assets/heart.json',
              width: 80,
              repeat: true,
            ),
          ),
        ],
      ),
    );
  }
}
