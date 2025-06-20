import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart' as lottie;

void main() {
  runApp(const PresentationApp());
}

class PresentationApp extends StatelessWidget {
  const PresentationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: GoogleFonts.poppinsTextTheme(),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const PresentationHomePage(),
    );
  }
}

class PresentationHomePage extends StatefulWidget {
  const PresentationHomePage({super.key});

  @override
  State<PresentationHomePage> createState() => _PresentationHomePageState();
}

class _PresentationHomePageState extends State<PresentationHomePage> {
  final PageController _pageController = PageController();

  final List<String> learningPoints = [
    '💡 Pensar em soluções eficientes',
    '🎨 Criar interfaces modernas e acessíveis',
    '🔄 Trabalhar com versionamento e metodologias ágeis',
    '🤝 Comunicar com times multidisciplinares',
  ];

  Widget _item(String text) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text(text, style: GoogleFonts.poppins(fontSize: 16)),
      );

  Widget _ufmgLogo() => Positioned(
        top: 20,
        left: 20,
        child: Image.asset(
          'assets/Sample3.png',
          width: 50,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          // Tela 1: Introdução
          Stack(
            children: [
              Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      lottie.Lottie.asset('assets/intro.json', width: 200),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          textAlign: TextAlign.center,
                          'Minha Jornada no Estágio',
                          style: GoogleFonts.poppins(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Criando apps em Flutter',
                        style: GoogleFonts.poppins(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
              _ufmgLogo(),
            ],
          ),

          // Tela 2: O que faço
          Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        lottie.Lottie.asset('assets/settings.json', width: 180),
                        Text('O que eu faço',
                            style: GoogleFonts.poppins(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                        Column(
                          children: [
                            const SizedBox(height: 16),
                            _item("💻 Desenvolvo interfaces com Flutter"),
                            _item("🎨 Trabalho com animações e design responsivo"),
                            _item("📡 Integro APIs e banco de dados"),
                            _item("🔧 Corrijo bugs e otimizo o app"),
                            const SizedBox(height: 16),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              _ufmgLogo(),
            ],
          ),

          // Tela 3: Relação com Engenharia de Sistemas
          Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Engenharia de Sistemas na prática',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple)),
                        Column(
                          children: [
                            const SizedBox(height: 16),
                            lottie.Lottie.asset('assets/systems.json', height: 350),
                            const SizedBox(height: 12),
                            _item("📐 Modelagem de sistemas (ex: estrutura do app, estados, rotas)"),
                            _item("🧠 Programação orientada a objetos (com Widgets e States)"),
                            _item("🎯 UX e requisitos (foco em usabilidade e interação)"),
                            _item("📊 Gestão ágil (uso de Git, Jira, Sprints)"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              _ufmgLogo(),
            ],
          ),

          // Tela 4: O que aprendi
          Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('O que eu aprendi',
                            style: GoogleFonts.poppins(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        for (var point in learningPoints)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                const Icon(Icons.check_circle, color: Colors.deepPurple),
                                const SizedBox(width: 8),
                                Expanded(
                                    child: Text(point,
                                        style: GoogleFonts.poppins(fontSize: 16))),
                              ],
                            ),
                          ),
                        const SizedBox(height: 20),
                        lottie.Lottie.asset('assets/learning.json', width: 180),
                      ],
                    ),
                  ),
                ),
              ),
              _ufmgLogo(),
            ],
          ),

          // Tela 5: Encerramento
          Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText(
                              'Fazer apps é transformar problemas em soluções.',
                              textStyle: GoogleFonts.poppins(
                                  fontSize: 22, fontWeight: FontWeight.w600),
                              speed: const Duration(milliseconds: 80),
                            ),
                            TypewriterAnimatedText(
                              'Isso é Engenharia de Sistemas aplicada.',
                              textStyle: GoogleFonts.poppins(
                                  fontSize: 22, fontWeight: FontWeight.w600),
                              speed: const Duration(milliseconds: 80),
                            ),
                          ],
                          totalRepeatCount: 1,
                        ),
                        const SizedBox(height: 40),
                        lottie.Lottie.asset('assets/questions.json', width: 160),
                        const SizedBox(height: 16),
                        Text('Dúvidas? Pode perguntar! 🧐',
                            style: GoogleFonts.poppins(fontSize: 18)),
                      ],
                    ),
                  ),
                ),
              ),
              _ufmgLogo(),
            ],
          ),
        ],
      ),
    );
  }
}
