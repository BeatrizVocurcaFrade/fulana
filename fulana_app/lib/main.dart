import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
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
  final List<Map<String, dynamic>> _bars = [
    {
      "name": "Charada Pampulha",
      "description": "Bar aconchegante com chope gelado e clima perfeito pra casal.",
      "latLng": LatLng(-19.8655, -43.9924),
    },
    {
      "name": "Bistrô Chaplin",
      "description": "Ambiente intimista com pratos refinados e toque francês.",
      "latLng": LatLng(-19.8702, -43.9932),
    },
    {
      "name": "Quintalzinho da Pampulha",
      "description": "Espaço ao ar livre, descontraído e cheio de charme.",
      "latLng": LatLng(-19.8672, -43.9895),
    },
    {
      "name": "Chalezinho da Pampulha",
      "description": "Lugar romântico, com vista linda e clima de cabana dos sonhos.",
      "latLng": LatLng(-19.8710, -43.9908),
    },
    {
      "name": "Bar do Museu Clube da Esquina",
      "description": "Música boa, vibes culturais e drinks autorais num cantinho especial.",
      "latLng": LatLng(-19.9367, -43.9378),
    },
  ];

  late LatLng _currentLocation = LatLng(-19.8686, -43.9917); // Posição inicial
  late MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  // Método para alterar a posição do mapa
  void _focusOnBar(LatLng latLng) {
    setState(() {
      _currentLocation = latLng;
    });
    _mapController.move(latLng, 14.5); // Mover para a nova posição
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Mapa usando flutter_map (funciona em web e mobile)
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: _currentLocation,
              zoom: 14.5,
            ),
            children: [
              TileLayer(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: _bars.map((bar) {
                  return Marker(
                    point: bar['latLng'],
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.location_pin,
                      color: Colors.pink,
                      size: 40,
                    ),
                  );
                }).toList(),
              ),
            ],
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

          // Lista de bares
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
                  return GestureDetector(
                    onTap: () {
                      _focusOnBar(bar['latLng']);
                    },
                    child: Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListTile(
                        title: Text(
                          bar['name'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink,
                          ),
                        ),
                        subtitle: Text(
                          bar['description'],
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Foto decorativa
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

          // Coração animado
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
