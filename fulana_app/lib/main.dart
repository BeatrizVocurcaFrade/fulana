import 'dart:math';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

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
        textTheme: GoogleFonts.dmSerifDisplayTextTheme(),
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

class _RomanticHomePageState extends State<RomanticHomePage>
    with TickerProviderStateMixin {
  late AnimationController _photoController;
  late AnimationController _pulseController;
  late Animation<Offset> _girlOffset;
  late Animation<Offset> _boyOffset;
  late Animation<double> _pulseAnimation;

  double _x = 0;
  double _y = 0;
  bool _showText = true;

  @override
  void initState() {
    super.initState();

    _photoController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _girlOffset = Tween<Offset>(
      begin: const Offset(-2, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _photoController, curve: Curves.easeOut));

    _boyOffset = Tween<Offset>(
      begin: const Offset(2, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _photoController, curve: Curves.easeOut));

    _photoController.forward().whenComplete(() {
      _pulseController.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _photoController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

void _moveButton() {
  final rand = Random();
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  const double buttonWidth = 100;
  const double buttonHeight = 50;

  // Geração de deslocamento entre 20 e 40 (em módulo), com sinal aleatório
  double dx = (40 + rand.nextDouble() * 40) * (rand.nextBool() ? 1 : -1);
  double dy = (40 + rand.nextDouble() * 40) * (rand.nextBool() ? 1 : -1);

  double newX = _x + dx;
  double newY = _y + dy;

  newX = newX.clamp(-screenWidth / 2 + buttonWidth / 2, screenWidth / 2 - buttonWidth * 1.5);
  newY = newY.clamp(-screenHeight / 2 + buttonHeight / 2, screenHeight / 2 - buttonHeight * 2);

  setState(() {
    _x = newX;
    _y = newY;
  });
}

  void _resetAnimation() {
    _photoController.reset();
    _photoController.forward();
    _pulseController.reset();
    _pulseController.repeat(reverse: true);
    setState(() {
      _x = 0;
      _y = 0;
      _showText = false;
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() => _showText = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // 🖼️ Fundo com imagem
          Positioned.fill(
            child: Image.asset(
              'assets/Sample1.jpg',
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            child: Stack(
              children: [
                // Texto animado
                if (_showText)
                  Positioned(
                    top: 75,
                    left: 20,
                    right: 20,
                    child: Center(
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            'Meu bemm, animaria passar o Dia dos Namorados comigo?',
                            textStyle: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                            speed: const Duration(milliseconds: 80),
                          ),
                        ],
                        totalRepeatCount: 1,
                        isRepeatingAnimation: false,
                      ),
                    ),
                  ),

                // Imagens com sombra e pulsar
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                      SlideTransition(
                        position: _boyOffset,
                        child: ScaleTransition(
                          scale: _pulseAnimation,
                          child: Container(
                            margin: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.red.withOpacity(0.3),
                                  blurRadius: 20,
                                  spreadRadius: 2,
                                  offset: const Offset(-4, 4),
                                ),
                              ],
                            ),
                            child: ClipPath(
                              clipper: HeartClipper(),
                              child: Image.asset(
                                'assets/Sample2.jpeg',
                                width: size.width * 0.4,
                                height: size.height * 0.2,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),SlideTransition(
                        position: _girlOffset,
                        child: ScaleTransition(
                          scale: _pulseAnimation,
                          child: Container(
                            margin: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.deepPurple.withOpacity(0.3),
                                  blurRadius: 20,
                                  spreadRadius: 2,
                                  offset: const Offset(4, 4),
                                ),
                              ],
                            ),
                            child: ClipPath(
                              clipper: HeartClipper(),
                              child: Image.asset(
                                'assets/Sample3.png',
                                width: size.width * 0.4,
                                height: size.height * 0.2,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Coração animado
                Positioned(
                  top: size.height * 0.45,
                  left: size.width / 2 - 75,
                  child: Lottie.asset(
                    'assets/heart.json',
                    width: 150,
                    repeat: true,
                  ),
                ),

                // Botão "Não" que foge (dentro da Stack ainda)
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  left: size.width / 1.8  + _x,
                  bottom: 100 + _y,
                  child:ElevatedButton(
  onPressed: _moveButton,
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.grey[300],
    padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
  ),
  child: const Text(
    'Não 😢',
    style: TextStyle(
      color: Colors.black,
      fontSize: 18,
    ),
  ),
),

                ),
              ],
            ),
          ),

          // Botões "Sim" e Reset fora da Stack principal
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Linha com os dois botões
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              title: const Text('❤️ Sim!'),
                              content: const Text(
                                textAlign: TextAlign.center,
                                  'Já estou preparando algo especial para nós... ✨'),
                              actions: [
                                TextButton(
                                  child: const Text('Fechar'),
                                  onPressed: () => Navigator.pop(context),
                                )
                              ],
                            ),
                          );
                        },
                      style: ElevatedButton.styleFrom(
  backgroundColor: const Color(0xFF932F6D),
  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30),
  ),
),
child: const Text('Sim ❤️',
  style: TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                      const SizedBox(width: 16),
                      // Botão "Não" aqui só de placeholder — o real está na Stack
                      const SizedBox(width: 100), // espaço para não sobrepor
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Reset
                  TextButton.icon(
                    onPressed: _resetAnimation,
                    icon: const Icon(Icons.refresh),
                    label: const Text("Resetar"),
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF932F6D),
                    ),
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
class HeartClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    final double w = size.width;
    final double h = size.height;
    path.moveTo(w / 2, h / 4);
    path.cubicTo(5 * w / 14, 0, 0, h / 15, w / 28, 2 * h / 5);
    path.cubicTo(w / 14, 2 * h / 3, 3 * w / 7, 5 * h / 6, w / 2, h);
    path.cubicTo(4 * w / 7, 5 * h / 6, 13 * w / 14, 2 * h / 3, 27 * w / 28, 2 * h / 5);
    path.cubicTo(w, h / 15, 9 * w / 14, 0, w / 2, h / 4);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
