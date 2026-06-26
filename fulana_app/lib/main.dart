import 'dart:math';
import 'dart:ui';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProximoRoleApp());
}

class AppConfig {
  const AppConfig._();

  static const appTitle = 'Próximo Rolê com a gatinha';

  // Troque pelo seu número com DDI + DDD + número, sem +, espaço ou traço.
  // Exemplo: 5531999999999
  static const whatsappRecipientNumber = '5531989183607';
}

class AppImages {
  const AppImages._();

  static const her = 'assets/photos/ela.jpeg';
  static const me = 'assets/photos/eu.jpeg';
  static const mila = 'assets/photos/mila.jpeg';
  static const us = 'assets/photos/nos.png';

  // Roleta 1 — rolê
  static const bar = 'assets/photos/bar.jpeg';
  static const terror = 'assets/photos/terror.jpeg';
  static const sunset = 'assets/photos/fim_tarde.jpeg';
  static const music = 'assets/photos/musica.jpeg';
  static const food = 'assets/photos/comida.jpeg';

  // Roleta 2 — detalhe
  // Adicione essas imagens na pasta assets/photos para não repetir
  // as mesmas imagens da primeira roleta.
  static const photoTogether = 'assets/photos/nos.png';
  static const note = 'assets/photos/bilhete.jpeg';
  static const playlist = 'assets/photos/playlist.jpeg';
  static const dessert = 'assets/photos/sobremesa.jpeg';
  static const surprise = 'assets/photos/surpresa.jpeg';
  static const walk = 'assets/photos/caminhada.jpeg';
}

class AppColors {
  const AppColors._();

  static const background = Color(0xFFFFF8F4);
  static const background2 = Color(0xFFF7E3E8);
  static const surface = Color(0xFFFFFCF9);
  static const ink = Color(0xFF26171D);
  static const muted = Color(0xFF7B666C);
  static const muted2 = Color(0xFFA58F96);

  static const wine = Color(0xFF7B294D);
  static const wineDark = Color(0xFF3A1325);
  static const wineSoft = Color(0xFFB96686);
  static const rose = Color(0xFFFFA7BE);
  static const blush = Color(0xFFFFD5CD);
  static const lavender = Color(0xFFE8DFFF);
  static const cream = Color(0xFFFFE8B7);
  static const green = Color(0xFFDCEEDB);
  static const blue = Color(0xFFDCEBFA);
  static const peach = Color(0xFFFFC8B5);
}

class AppGradients {
  const AppGradients._();

  static const background = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.background,
      AppColors.background2,
      Color(0xFFFFFCF7),
    ],
  );

  static const primary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.wineDark,
      AppColors.wine,
      AppColors.wineSoft,
    ],
  );

  static const card = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xF6FFFFFF),
      Color(0xB8FFFFFF),
    ],
  );

  static const cover = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFFFFF),
      Color(0xFFFFE3DC),
      Color(0xFFE9E1FF),
    ],
  );

  static const heart = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFF8CAC),
      AppColors.wine,
      AppColors.wineDark,
    ],
  );
}

class ProximoRoleApp extends StatelessWidget {
  const ProximoRoleApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.interTextTheme();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConfig.appTitle,
      builder: (context, child) {
        final media = MediaQuery.of(context);

        return MediaQuery(
          data: media.copyWith(
            textScaler: media.textScaler.clamp(
              minScaleFactor: .92,
              maxScaleFactor: 1.10,
            ),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.wine,
          brightness: Brightness.light,
        ),
        textTheme: textTheme.copyWith(
          displayLarge: GoogleFonts.playfairDisplay(
            fontSize: 54,
            height: .90,
            fontWeight: FontWeight.w900,
            color: AppColors.ink,
          ),
          headlineMedium: GoogleFonts.playfairDisplay(
            fontSize: 32,
            height: .96,
            fontWeight: FontWeight.w900,
            color: AppColors.ink,
          ),
          titleLarge: GoogleFonts.inter(
            fontSize: 21,
            height: 1.08,
            fontWeight: FontWeight.w900,
            color: AppColors.ink,
          ),
          titleMedium: GoogleFonts.inter(
            fontSize: 15,
            height: 1.12,
            fontWeight: FontWeight.w900,
            color: AppColors.ink,
          ),
          bodyLarge: GoogleFonts.inter(
            fontSize: 15.5,
            height: 1.30,
            fontWeight: FontWeight.w600,
            color: AppColors.muted,
          ),
          bodyMedium: GoogleFonts.inter(
            fontSize: 13,
            height: 1.25,
            fontWeight: FontWeight.w600,
            color: AppColors.muted,
          ),
          labelLarge: GoogleFonts.inter(
            fontSize: 14.5,
            height: 1,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
      ),
      home: const StartPage(),
    );
  }
}

class WheelOption {
  const WheelOption({
    required this.title,
    required this.shortTitle,
    required this.subtitle,
    required this.assetPath,
    required this.icon,
    required this.tint,
  });

  final String title;
  final String shortTitle;
  final String subtitle;
  final String assetPath;
  final IconData icon;
  final Color tint;
}

const dateOptions = <WheelOption>[
  WheelOption(
    title: 'Balada / bar',
    shortTitle: 'bar',
    subtitle: 'um rolê animado e leve',
    assetPath: AppImages.bar,
    icon: Icons.local_bar_rounded,
    tint: AppColors.cream,
  ),
  WheelOption(
    title: 'Terror juntinhas',
    shortTitle: 'terror',
    subtitle: 'filme, susto e risada',
    assetPath: AppImages.terror,
    icon: Icons.movie_filter_rounded,
    tint: AppColors.green,
  ),
  WheelOption(
    title: 'Passeio com a Mila',
    shortTitle: 'Mila',
    subtitle: 'com participação especial',
    assetPath: AppImages.mila,
    icon: Icons.pets_rounded,
    tint: AppColors.peach,
  ),
  WheelOption(
    title: 'Fim de tarde',
    shortTitle: 'fim tarde',
    subtitle: 'bonito, simples e perto',
    assetPath: AppImages.sunset,
    icon: Icons.wb_twilight_rounded,
    tint: AppColors.blue,
  ),
  WheelOption(
    title: 'Música e caminhada',
    shortTitle: 'música',
    subtitle: 'playlist e conversa boa',
    assetPath: AppImages.music,
    icon: Icons.queue_music_rounded,
    tint: AppColors.lavender,
  ),
  WheelOption(
    title: 'Comida boa',
    shortTitle: 'comida',
    subtitle: 'algo gostoso sem complicar',
    assetPath: AppImages.food,
    icon: Icons.restaurant_rounded,
    tint: AppColors.blush,
  ),
];

const gestureOptions = <WheelOption>[
  WheelOption(
    title: 'Foto juntas',
    shortTitle: 'foto',
    subtitle: 'uma foto bonita para guardar o dia',
    assetPath: AppImages.photoTogether,
    icon: Icons.photo_camera_rounded,
    tint: AppColors.blue,
  ),
  WheelOption(
    title: 'Bilhetinho',
    shortTitle: 'bilhete',
    subtitle: 'duas linhas sinceras, sem exagero',
    assetPath: AppImages.note,
    icon: Icons.edit_note_rounded,
    tint: AppColors.cream,
  ),
  WheelOption(
    title: 'Playlist',
    shortTitle: 'playlist',
    subtitle: 'uma música escolhida para o rolê',
    assetPath: AppImages.playlist,
    icon: Icons.library_music_rounded,
    tint: AppColors.lavender,
  ),
  WheelOption(
    title: 'Sobremesa',
    shortTitle: 'doce',
    subtitle: 'um docinho no final',
    assetPath: AppImages.dessert,
    icon: Icons.icecream_rounded,
    tint: AppColors.blush,
  ),
  WheelOption(
    title: 'Mini surpresa',
    shortTitle: 'surpresa',
    subtitle: 'um detalhe pequeno e bonito',
    assetPath: AppImages.surprise,
    icon: Icons.auto_awesome_rounded,
    tint: AppColors.rose,
  ),
  WheelOption(
    title: 'Caminhada curta',
    shortTitle: 'andar',
    subtitle: 'só para esticar o rolê e conversar',
    assetPath: AppImages.walk,
    icon: Icons.directions_walk_rounded,
    tint: AppColors.green,
  ),
];

enum GameStage { date, gesture }

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  void _openGame(BuildContext context) {
    HapticFeedback.lightImpact();

    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, animation, __) => const GamePage(),
        transitionsBuilder: (_, animation, __, child) {
          final curved = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          );

          return FadeTransition(
            opacity: curved,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, .04),
                end: Offset.zero,
              ).animate(curved),
              child: child,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final compact = constraints.maxHeight < 720;

              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: compact ? 10 : 16),
                    Text(
                      'Próximo\nRolê',
                      maxLines: 2,
                      overflow: TextOverflow.visible,
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            fontSize: compact ? 47 : 56,
                          ),
                    ),
                    SizedBox(height: compact ? 8 : 10),
                    Text(
                      'Gira, combina e chama.',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(height: compact ? 14 : 20),
                    const Expanded(child: CoverShowcase()),
                    SizedBox(height: compact ? 14 : 18),
                    PrimaryButton(
                      text: 'Começar',
                      icon: Icons.casino_rounded,
                      onTap: () => _openGame(context),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class CoverShowcase extends StatefulWidget {
  const CoverShowcase({super.key});

  @override
  State<CoverShowcase> createState() => _CoverShowcaseState();
}

class _CoverShowcaseState extends State<CoverShowcase>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1150),
    )..repeat(reverse: true);

    _pulse = Tween<double>(begin: .96, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SoftCard(
      padding: EdgeInsets.zero,
      radius: 38,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;
          final compact = height < 360;
          final mainPhotoHeight =
              (height * (compact ? .54 : .58)).clamp(172.0, 270.0).toDouble();
          final mainPhotoWidth = (width * .78).clamp(230.0, 360.0).toDouble();
          final smallSize = (width * .21).clamp(64.0, 86.0).toDouble();

          return ClipRRect(
            borderRadius: BorderRadius.circular(38),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(gradient: AppGradients.cover),
                  ),
                ),
                const Positioned(
                  top: -72,
                  right: -62,
                  child: SoftCircle(size: 190, color: AppColors.rose),
                ),
                const Positioned(
                  bottom: -88,
                  left: -72,
                  child: SoftCircle(size: 220, color: AppColors.lavender),
                ),
                Positioned(
                  top: 20,
                  left: 18,
                  right: 18,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'um plano em dois giros',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontSize: compact ? 18 : 21,
                                  ),
                        ),
                      ),
                      const AppIconBubble(
                        icon: Icons.auto_awesome_rounded,
                        color: Colors.white,
                        iconColor: AppColors.wine,
                        size: 48,
                        radius: 17,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: compact ? 66 : 82,
                  child: Transform.rotate(
                    angle: -.035,
                    child: CoverMainPhoto(
                      width: mainPhotoWidth,
                      height: mainPhotoHeight,
                    ),
                  ),
                ),
                Positioned(
                  left: 18,
                  bottom: compact ? 18 : 30,
                  child: FloatingMiniPhoto(
                    assetPath: AppImages.her,
                    fallbackIcon: Icons.person_rounded,
                    size: smallSize,
                    label: 'ela',
                    angle: -.10,
                  ),
                ),
                Positioned(
                  right: 22,
                  bottom: compact ? 24 : 44,
                  child: FloatingMiniPhoto(
                    assetPath: AppImages.mila,
                    fallbackIcon: Icons.pets_rounded,
                    size: smallSize,
                    label: 'Mila',
                    angle: .12,
                  ),
                ),
                Positioned(
                  bottom: compact ? 18 : 28,
                  child: AnimatedBuilder(
                    animation: _pulse,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _pulse.value,
                        child: child,
                      );
                    },
                    child: Container(
                      width: compact ? 76 : 88,
                      height: compact ? 76 : 88,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: AppGradients.primary,
                        border: Border.all(color: Colors.white, width: 6),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.wine.withOpacity(.22),
                            blurRadius: 28,
                            offset: const Offset(0, 14),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.casino_rounded,
                        color: Colors.white,
                        size: compact ? 34 : 40,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CoverMainPhoto extends StatelessWidget {
  const CoverMainPhoto({
    required this.width,
    required this.height,
    super.key,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.95),
        borderRadius: BorderRadius.circular(34),
        boxShadow: [
          BoxShadow(
            color: AppColors.wine.withOpacity(.14),
            blurRadius: 24,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(27),
        child: Image.asset(
          AppImages.us,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) {
            return Container(
              color: AppColors.blush.withOpacity(.75),
              alignment: Alignment.center,
              child: const Icon(
                Icons.favorite_rounded,
                color: AppColors.wine,
                size: 54,
              ),
            );
          },
        ),
      ),
    );
  }
}

class FloatingMiniPhoto extends StatelessWidget {
  const FloatingMiniPhoto({
    required this.assetPath,
    required this.fallbackIcon,
    required this.size,
    required this.label,
    required this.angle,
    super.key,
  });

  final String assetPath;
  final IconData fallbackIcon;
  final double size;
  final String label;
  final double angle;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PhotoAvatar(
            assetPath: assetPath,
            fallbackIcon: fallbackIcon,
            size: size,
            borderWidth: 4,
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.88),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: Colors.white.withOpacity(.94)),
            ),
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.wineDark,
                    fontSize: 11,
                    height: 1,
                    fontWeight: FontWeight.w900,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final _random = Random();
  final _confettiController = ConfettiController(
    duration: const Duration(seconds: 2),
  );

  GameStage _stage = GameStage.date;
  WheelOption? _selectedDate;
  WheelOption? _selectedGesture;
  double _rotation = 0;
  bool _spinning = false;

  List<WheelOption> get _activeOptions {
    return _stage == GameStage.date ? dateOptions : gestureOptions;
  }

  WheelOption? get _activeSelected {
    return _stage == GameStage.date ? _selectedDate : _selectedGesture;
  }

  String get _stageTitle => _stage == GameStage.date ? 'Rolê' : 'Detalhe';

  String get _buttonText {
    if (_spinning) return 'Girando...';
    if (_activeSelected == null) {
      return _stage == GameStage.date ? 'Girar rolê' : 'Girar detalhe';
    }
    return _stage == GameStage.date ? 'Continuar' : 'Ver convite';
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  Future<void> _spin() async {
    if (_spinning) return;

    HapticFeedback.mediumImpact();

    final options = _activeOptions;
    final selectedIndex = _random.nextInt(options.length);
    final segment = 2 * pi / options.length;
    final desiredAngle = -segment * selectedIndex;
    final currentCycle = (_rotation / (2 * pi)).ceil();
    var targetAngle = ((currentCycle + 5) * 2 * pi) + desiredAngle;

    if (targetAngle <= _rotation) {
      targetAngle += 4 * pi;
    }

    setState(() {
      _spinning = true;
      _rotation = targetAngle;
      if (_stage == GameStage.date) {
        _selectedDate = null;
      } else {
        _selectedGesture = null;
      }
    });

    await Future<void>.delayed(const Duration(milliseconds: 2100));

    if (!mounted) return;

    setState(() {
      if (_stage == GameStage.date) {
        _selectedDate = options[selectedIndex];
      } else {
        _selectedGesture = options[selectedIndex];
      }
      _spinning = false;
    });

    if (_stage == GameStage.gesture) {
      _confettiController.play();
    }

    HapticFeedback.lightImpact();
  }

  void _handlePrimaryAction() {
    if (_spinning) return;

    final selected = _activeSelected;

    if (selected == null) {
      _spin();
      return;
    }

    if (_stage == GameStage.date) {
      setState(() {
        _stage = GameStage.gesture;
        _rotation = 0;
        _selectedGesture = null;
      });
      HapticFeedback.selectionClick();
      return;
    }

    final date = _selectedDate;
    final gesture = _selectedGesture;
    if (date == null || gesture == null) return;

    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, animation, __) => FinalPage(
          date: date,
          gesture: gesture,
        ),
        transitionsBuilder: (_, animation, __, child) {
          final curved = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          );

          return FadeTransition(
            opacity: curved,
            child: ScaleTransition(
              scale: Tween<double>(begin: .985, end: 1).animate(curved),
              child: child,
            ),
          );
        },
      ),
    );
  }

  void _backToDateStage() {
    if (_stage == GameStage.date || _spinning) return;

    HapticFeedback.selectionClick();
    setState(() {
      _stage = GameStage.date;
      _rotation = 0;
      _selectedGesture = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final selected = _activeSelected;

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 10, 18, 18),
                child: Column(
                  children: [
                    GameTopBar(
                      title: _stageTitle,
                      stage: _stage,
                      onBackHome: () => Navigator.of(context).pop(),
                      onBackToDate: _backToDateStage,
                    ),
                    const SizedBox(height: 12),
                    StageStepsBar(stage: _stage),
                    const SizedBox(height: 10),
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final size = min(
                            constraints.maxWidth,
                            constraints.maxHeight - 34,
                          ).clamp(270.0, 390.0).toDouble();

                          return Center(
                            child: ModernWheel(
                              options: _activeOptions,
                              selected: selected,
                              rotation: _rotation,
                              spinning: _spinning,
                              size: size,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    SelectedResultCard(
                      stage: _stage,
                      selected: selected,
                      spinning: _spinning,
                    ),
                    const SizedBox(height: 12),
                    if (selected == null)
                      PrimaryButton(
                        text: _buttonText,
                        icon: Icons.casino_rounded,
                        onTap: _handlePrimaryAction,
                      )
                    else
                      ResponsiveActions(
                        first: GhostButton(
                          text: 'Trocar',
                          icon: Icons.refresh_rounded,
                          onTap: _spin,
                        ),
                        second: PrimaryButton(
                          text: _buttonText,
                          icon: _stage == GameStage.date
                              ? Icons.arrow_forward_rounded
                              : Icons.auto_awesome_rounded,
                          onTap: _handlePrimaryAction,
                        ),
                      ),
                  ],
                ),
              ),
              ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                emissionFrequency: .018,
                numberOfParticles: 16,
                gravity: .22,
                shouldLoop: false,
                colors: const [
                  AppColors.wine,
                  AppColors.rose,
                  AppColors.lavender,
                  AppColors.cream,
                  AppColors.blue,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GameTopBar extends StatelessWidget {
  const GameTopBar({
    required this.title,
    required this.stage,
    required this.onBackHome,
    required this.onBackToDate,
    super.key,
  });

  final String title;
  final GameStage stage;
  final VoidCallback onBackHome;
  final VoidCallback onBackToDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RoundIconButton(
          icon: Icons.arrow_back_rounded,
          onTap: onBackHome,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 30,
                ),
          ),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          child: stage == GameStage.gesture
              ? MiniTopButton(
                  key: const ValueKey('back-date'),
                  text: 'rolê',
                  icon: Icons.undo_rounded,
                  onTap: onBackToDate,
                )
              : const SizedBox(
                  key: ValueKey('empty'),
                  width: 52,
                  height: 44,
                ),
        ),
      ],
    );
  }
}

class StageStepsBar extends StatelessWidget {
  const StageStepsBar({
    required this.stage,
    super.key,
  });

  final GameStage stage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: StepChip(
            text: '1 rolê',
            active: true,
            done: stage == GameStage.gesture,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: StepChip(
            text: '2 detalhe',
            active: stage == GameStage.gesture,
            done: false,
          ),
        ),
      ],
    );
  }
}

class StepChip extends StatelessWidget {
  const StepChip({
    required this.text,
    required this.active,
    required this.done,
    super.key,
  });

  final String text;
  final bool active;
  final bool done;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: active ? AppColors.wineDark : Colors.white.withOpacity(.58),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: active ? AppColors.wineDark : Colors.white.withOpacity(.84),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            done ? Icons.check_circle_rounded : Icons.circle_rounded,
            size: done ? 17 : 9,
            color: active ? Colors.white : AppColors.muted2,
          ),
          const SizedBox(width: 7),
          Flexible(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: active ? Colors.white : AppColors.wineDark,
                    fontSize: 12,
                    height: 1,
                    fontWeight: FontWeight.w900,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class MiniTopButton extends StatelessWidget {
  const MiniTopButton({
    required this.text,
    required this.icon,
    required this.onTap,
    super.key,
  });

  final String text;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      onTap: onTap,
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.74),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: Colors.white.withOpacity(.90)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 17, color: AppColors.wineDark),
            const SizedBox(width: 5),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.wineDark,
                    fontSize: 12,
                    height: 1,
                    fontWeight: FontWeight.w900,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class ModernWheel extends StatelessWidget {
  const ModernWheel({
    required this.options,
    required this.selected,
    required this.rotation,
    required this.spinning,
    required this.size,
    super.key,
  });

  final List<WheelOption> options;
  final WheelOption? selected;
  final double rotation;
  final bool spinning;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size + 34,
      width: size,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 0,
            child: WheelPointer(spinning: spinning),
          ),
          Positioned(
            top: 25,
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(end: rotation),
              duration: const Duration(milliseconds: 2100),
              curve: Curves.easeOutCubic,
              builder: (context, animatedRotation, _) {
                return Transform.rotate(
                  angle: animatedRotation,
                  child: WheelBody(
                    options: options,
                    selected: selected,
                    size: size,
                    counterRotation: -animatedRotation,
                    spinning: spinning,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class WheelPointer extends StatelessWidget {
  const WheelPointer({
    required this.spinning,
    super.key,
  });

  final bool spinning;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 220),
      scale: spinning ? 1.07 : 1,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
            decoration: BoxDecoration(
              color: AppColors.wineDark,
              borderRadius: BorderRadius.circular(999),
              boxShadow: [
                BoxShadow(
                  color: AppColors.wine.withOpacity(.20),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Text(
              'sorteio',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontSize: 11,
                    height: 1,
                    fontWeight: FontWeight.w900,
                  ),
            ),
          ),
          CustomPaint(
            size: const Size(30, 17),
            painter: TrianglePainter(),
          ),
        ],
      ),
    );
  }
}

class WheelBody extends StatelessWidget {
  const WheelBody({
    required this.options,
    required this.selected,
    required this.size,
    required this.counterRotation,
    required this.spinning,
    super.key,
  });

  final List<WheelOption> options;
  final WheelOption? selected;
  final double size;
  final double counterRotation;
  final bool spinning;

  @override
  Widget build(BuildContext context) {
    final center = size / 2;
    final segment = 2 * pi / options.length;
    final radius = size * .335;
    final itemSize = (size * .235).clamp(78.0, 94.0).toDouble();

    return SizedBox.square(
      dimension: size,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          CustomPaint(
            size: Size.square(size),
            painter: WheelPainter(options: options),
          ),
          CenterWheelButton(size: size, spinning: spinning),
          for (var i = 0; i < options.length; i++)
            Positioned(
              left: center + cos(-pi / 2 + segment * i) * radius - itemSize / 2,
              top: center + sin(-pi / 2 + segment * i) * radius - itemSize / 2,
              child: Transform.rotate(
                angle: counterRotation,
                child: WheelItemBubble(
                  option: options[i],
                  size: itemSize,
                  active: selected?.title == options[i].title,
                  muted: spinning,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class CenterWheelButton extends StatelessWidget {
  const CenterWheelButton({
    required this.size,
    required this.spinning,
    super.key,
  });

  final double size;
  final bool spinning;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 220),
      scale: spinning ? .94 : 1,
      child: Container(
        width: size * .225,
        height: size * .225,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppGradients.primary,
          border: Border.all(
            color: Colors.white.withOpacity(.96),
            width: 6,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.wine.withOpacity(.18),
              blurRadius: 18,
              offset: const Offset(0, 9),
            ),
          ],
        ),
        child: Icon(
          spinning ? Icons.sync_rounded : Icons.casino_rounded,
          color: Colors.white,
          size: size * .086,
        ),
      ),
    );
  }
}

void _showWheelOptionPreview(BuildContext context, WheelOption option) {
  HapticFeedback.selectionClick();

  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: AppColors.wineDark.withOpacity(.32),
    builder: (context) => WheelOptionPreviewSheet(option: option),
  );
}

class WheelItemBubble extends StatelessWidget {
  const WheelItemBubble({
    required this.option,
    required this.size,
    required this.active,
    required this.muted,
    super.key,
  });

  final WheelOption option;
  final double size;
  final bool active;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    final avatarSize = active ? size * .94 : size * .82;
    final labelWidth = active ? 126.0 : size + 30;
    final labelText = active ? option.title : option.shortTitle;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => _showWheelOptionPreview(context, option),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 160),
        opacity: muted ? .92 : 1,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 190),
          curve: Curves.easeOutCubic,
          scale: active ? 1.10 : 1,
          child: SizedBox(
            width: active ? 138 : size + 38,
            height: active ? 112 : 100,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  bottom: 0,
                  child: PhotoAvatar(
                    assetPath: option.assetPath,
                    fallbackIcon: option.icon,
                    size: avatarSize,
                    borderWidth: active ? 4 : 3,
                  ),
                ),
                Positioned(
                  top: 0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 190),
                    curve: Curves.easeOutCubic,
                    width: labelWidth,
                    padding: EdgeInsets.symmetric(
                      horizontal: active ? 10 : 8,
                      vertical: active ? 7 : 6,
                    ),
                    decoration: BoxDecoration(
                      color: active
                          ? AppColors.wineDark
                          : Colors.white.withOpacity(.93),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: Colors.white.withOpacity(.94)),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.wine.withOpacity(.12),
                          blurRadius: 12,
                          offset: const Offset(0, 7),
                        ),
                      ],
                    ),
                    child: Text(
                      labelText,
                      maxLines: active ? 2 : 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: active ? Colors.white : AppColors.wineDark,
                            fontSize: active ? 12 : 10.6,
                            height: 1.05,
                            fontWeight: FontWeight.w900,
                          ),
                    ),
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

class WheelOptionPreviewSheet extends StatelessWidget {
  const WheelOptionPreviewSheet({
    required this.option,
    super.key,
  });

  final WheelOption option;

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).padding.bottom;

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 0, 16, 16 + bottom),
        child: SoftCard(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
          radius: 34,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 46,
                height: 5,
                decoration: BoxDecoration(
                  color: AppColors.wineDark.withOpacity(.18),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                height: 250,
                width: double.infinity,
                child: FullPhotoFrame(
                  assetPath: option.assetPath,
                  fallbackIcon: option.icon,
                  radius: 30,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppIconBubble(
                    icon: option.icon,
                    color: option.tint.withOpacity(.88),
                    iconColor: AppColors.wineDark,
                    size: 52,
                    radius: 18,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          option.title,
                          maxLines: 3,
                          overflow: TextOverflow.visible,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          option.subtitle,
                          maxLines: 4,
                          overflow: TextOverflow.visible,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              GhostButton(
                text: 'Fechar',
                icon: Icons.close_rounded,
                onTap: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WheelPainter extends CustomPainter {
  const WheelPainter({required this.options});

  final List<WheelOption> options;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final center = rect.center;
    final radius = size.width / 2;
    final segment = 2 * pi / options.length;

    final shadowPaint = Paint()
      ..color = AppColors.wine.withOpacity(.10)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 18);

    canvas.drawCircle(
      center.translate(0, 10),
      radius - 12,
      shadowPaint,
    );

    for (var i = 0; i < options.length; i++) {
      final start = -pi / 2 - segment / 2 + segment * i;
      final paint = Paint()
        ..shader = RadialGradient(
          colors: [
            options[i].tint.withOpacity(.98),
            Colors.white.withOpacity(.96),
          ],
        ).createShader(rect)
        ..style = PaintingStyle.fill;

      canvas.drawArc(
        rect.deflate(8),
        start,
        segment,
        true,
        paint,
      );

      final linePaint = Paint()
        ..color = Colors.white.withOpacity(.72)
        ..strokeWidth = 2.2;

      canvas.drawLine(
        center,
        Offset(
          center.dx + cos(start) * (radius - 8),
          center.dy + sin(start) * (radius - 8),
        ),
        linePaint,
      );
    }

    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 9
      ..color = Colors.white.withOpacity(.94);

    canvas.drawCircle(center, radius - 12, borderPaint);

    final innerPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..color = AppColors.wine.withOpacity(.10);

    canvas.drawCircle(center, radius - 20, innerPaint);
  }

  @override
  bool shouldRepaint(covariant WheelPainter oldDelegate) {
    return oldDelegate.options != options;
  }
}

class TrianglePainter extends CustomPainter {
  const TrianglePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.wineDark
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, size.height)
      ..lineTo(0, 0)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant TrianglePainter oldDelegate) => false;
}

class SelectedResultCard extends StatelessWidget {
  const SelectedResultCard({
    required this.stage,
    required this.selected,
    required this.spinning,
    super.key,
  });

  final GameStage stage;
  final WheelOption? selected;
  final bool spinning;

  @override
  Widget build(BuildContext context) {
    final hasSelection = selected != null;
    final title = spinning
        ? 'sorteando...'
        : hasSelection
            ? selected!.title
            : stage == GameStage.date
                ? 'Pronta para girar'
                : 'Agora o detalhe';
    final subtitle = spinning
        ? 'quase lá'
        : hasSelection
            ? selected!.subtitle
            : stage == GameStage.date
                ? 'um toque e começa'
                : 'mais um giro e fechou';

    return SoftCard(
      padding: const EdgeInsets.all(12),
      radius: 28,
      child: Row(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            child: hasSelection
                ? PhotoAvatar(
                    key: ValueKey(selected!.title),
                    assetPath: selected!.assetPath,
                    fallbackIcon: selected!.icon,
                    size: 72,
                    borderWidth: 4,
                  )
                : AppIconBubble(
                    key: ValueKey('$stage-$spinning'),
                    icon:
                        spinning ? Icons.sync_rounded : Icons.touch_app_rounded,
                    color: AppColors.blush.withOpacity(.62),
                    iconColor: AppColors.wine,
                    size: 66,
                    radius: 23,
                  ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              child: Column(
                key: ValueKey(title),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 18,
                        ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
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

class FinalPage extends StatefulWidget {
  const FinalPage({
    required this.date,
    required this.gesture,
    super.key,
  });

  final WheelOption date;
  final WheelOption gesture;

  @override
  State<FinalPage> createState() => _FinalPageState();
}

class _FinalPageState extends State<FinalPage> {
  final _confettiController = ConfettiController(
    duration: const Duration(seconds: 2),
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _confettiController.play();
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  Future<void> _sendWhatsApp() async {
    HapticFeedback.lightImpact();

    final phone = AppConfig.whatsappRecipientNumber.trim();

    if (phone.isEmpty || phone == '5531999999999') {
      _showSnack(
        'Troque o número em AppConfig.whatsappRecipientNumber antes de gerar o APK.',
      );
      return;
    }

    String cleanDescription(String? value) {
      return (value ?? '').trim();
    }

    final dateDescription = cleanDescription(widget.date.subtitle);
    final gestureDescription = cleanDescription(widget.gesture.subtitle);

    final message = [
      '🎡 A roleta decidiu nosso rolê!',
      '',
      '📍 Plano escolhido: ${widget.date.title}',
      if (dateDescription.isNotEmpty) '   $dateDescription',
      '',
      '✨ Detalhe especial: ${widget.gesture.title}',
      if (gestureDescription.isNotEmpty) '   $gestureDescription',
      '',
      '💌 Veredito: esse combo ficou com a nossa cara.',
      'Topa fazer acontecer?'
    ].join('\n');
    final encodedMessage = Uri.encodeComponent(message);

    final appUri = Uri.parse(
      'whatsapp://send?phone=$phone&text=$encodedMessage',
    );
    final webUri = Uri.parse(
      'https://wa.me/$phone?text=$encodedMessage',
    );

    final opened = await _tryLaunch(appUri) || await _tryLaunch(webUri);

    if (!opened && mounted) {
      _showSnack('Não consegui abrir o WhatsApp agora.');
    }
  }

  Future<bool> _tryLaunch(Uri uri) async {
    try {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      return false;
    }
  }

  void _showSnack(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.wineDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 10, 18, 18),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final compact = constraints.maxHeight < 700;
                    final actionsHeight =
                        constraints.maxWidth < 350 ? 126.0 : 58.0;

                    final availableCardHeight = constraints.maxHeight -
                        44 -
                        actionsHeight -
                        (compact ? 44 : 54);

                    final cardHeight = min(
                      availableCardHeight,
                      compact ? 440.0 : 520.0,
                    );

                    return Column(
                      children: [
                        FinalTopBar(onBack: () => Navigator.of(context).pop()),
                        SizedBox(height: compact ? 10 : 14),
                        Expanded(
                          child: Center(
                            child: SizedBox(
                              width: double.infinity,
                              height: cardHeight,
                              child: FinalCompactCard(
                                date: widget.date,
                                gesture: widget.gesture,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: compact ? 10 : 14),
                        ResponsiveActions(
                          first: GhostButton(
                            text: 'Trocar',
                            icon: Icons.refresh_rounded,
                            onTap: () => Navigator.of(context).pop(),
                          ),
                          second: PrimaryButton(
                            text: 'Mandar convite',
                            icon: Icons.send_rounded,
                            onTap: _sendWhatsApp,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                emissionFrequency: .018,
                numberOfParticles: 16,
                gravity: .22,
                shouldLoop: false,
                colors: const [
                  AppColors.wine,
                  AppColors.rose,
                  AppColors.lavender,
                  AppColors.cream,
                  AppColors.blue,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FinalTopBar extends StatelessWidget {
  const FinalTopBar({
    required this.onBack,
    super.key,
  });

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RoundIconButton(
          icon: Icons.arrow_back_rounded,
          onTap: onBack,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            'Rolê pronto',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 30,
                ),
          ),
        ),
        const AppPill(text: 'convite'),
      ],
    );
  }
}

class FinalCompactCard extends StatefulWidget {
  const FinalCompactCard({
    required this.date,
    required this.gesture,
    super.key,
  });

  final WheelOption date;
  final WheelOption gesture;

  @override
  State<FinalCompactCard> createState() => _FinalCompactCardState();
}

class _FinalCompactCardState extends State<FinalCompactCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _turn;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 980),
    )..repeat(reverse: true);

    _scale = Tween<double>(begin: .94, end: 1.06).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _turn = Tween<double>(begin: -.03, end: .03).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SoftCard(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      radius: 36,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxHeight < 500;

          final availablePhotoWidth = (constraints.maxWidth - 10) / 2;
          final idealPhotoHeight = availablePhotoWidth * 1.28;

          final photoHeight = idealPhotoHeight
              .clamp(
                compact ? 150.0 : 175.0,
                constraints.maxHeight * (compact ? .44 : .50),
              )
              .toDouble();

          return Center(
            child: Column(
              children: [
                SizedBox(
                  height: photoHeight,
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Transform.rotate(
                              angle: -.025,
                              child: FinalHeroPhoto(
                                assetPath: AppImages.her,
                                fallbackIcon: Icons.person_rounded,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Transform.rotate(
                              angle: .025,
                              child: FinalHeroPhoto(
                                assetPath: AppImages.me,
                                fallbackIcon: Icons.favorite_rounded,
                              ),
                            ),
                          ),
                        ],
                      ),
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: _turn.value,
                            child: Transform.scale(
                              scale: _scale.value,
                              child: child,
                            ),
                          );
                        },
                        child: Container(
                          width: compact ? 76 : 90,
                          height: compact ? 76 : 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: AppGradients.heart,
                            border: Border.all(color: Colors.white, width: 6),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.wine.withOpacity(.22),
                                blurRadius: 28,
                                offset: const Offset(0, 14),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.favorite_rounded,
                            color: Colors.white,
                            size: compact ? 36 : 44,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: compact ? 10 : 14),
                FinalPlanMiniTile(
                  label: 'rolê',
                  option: widget.date,
                  compact: compact,
                ),
                SizedBox(height: compact ? 8 : 10),
                FinalPlanMiniTile(
                  label: 'detalhe',
                  option: widget.gesture,
                  compact: compact,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class FinalHeroPhoto extends StatelessWidget {
  const FinalHeroPhoto({
    required this.assetPath,
    required this.fallbackIcon,
    super.key,
  });

  final String assetPath;
  final IconData fallbackIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.96),
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: AppColors.wine.withOpacity(.14),
              blurRadius: 24,
              offset: const Offset(0, 14),
            ),
          ],
        ),
        child: FullPhotoFrame(
          assetPath: assetPath,
          fallbackIcon: fallbackIcon,
          radius: 26,
        ),
      ),
    );
  }
}

class FullPhotoFrame extends StatelessWidget {
  const FullPhotoFrame({
    required this.assetPath,
    required this.fallbackIcon,
    this.radius = 26,
    super.key,
  });

  final String assetPath;
  final IconData fallbackIcon;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            assetPath,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => _PhotoFallback(
              icon: fallbackIcon,
              radius: radius,
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
              child: Container(color: Colors.white.withOpacity(.18)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(max(radius - 5, 16)),
              child: Image.asset(
                assetPath,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => _PhotoFallback(
                  icon: fallbackIcon,
                  radius: max(radius - 5, 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PhotoFallback extends StatelessWidget {
  const _PhotoFallback({
    required this.icon,
    required this.radius,
  });

  final IconData icon;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Icon(
        icon,
        color: AppColors.wine,
        size: 54,
      ),
    );
  }
}

class FinalPlanMiniTile extends StatelessWidget {
  const FinalPlanMiniTile({
    required this.label,
    required this.option,
    required this.compact,
    super.key,
  });

  final String label;
  final WheelOption option;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(compact ? 10 : 12),
      decoration: BoxDecoration(
        color: option.tint.withOpacity(.78),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: Colors.white.withOpacity(.82)),
      ),
      child: Row(
        children: [
          PhotoAvatar(
            assetPath: option.assetPath,
            fallbackIcon: option.icon,
            size: compact ? 54 : 64,
            borderWidth: 3,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.wine,
                        fontSize: 10,
                        letterSpacing: 1.1,
                        height: 1,
                        fontWeight: FontWeight.w900,
                      ),
                ),
                const SizedBox(height: 5),
                Text(
                  option.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: compact ? 15.5 : 18,
                        height: 1.05,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  option.subtitle,
                  maxLines: compact ? 1 : 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.ink.withOpacity(.58),
                        fontSize: compact ? 11.5 : 12.5,
                        height: 1.12,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AppBackground extends StatelessWidget {
  const AppBackground({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(gradient: AppGradients.background),
      child: Stack(
        fit: StackFit.expand,
        children: [
          const Positioned(
            top: -90,
            right: -86,
            child: SoftCircle(size: 250, color: AppColors.rose),
          ),
          const Positioned(
            bottom: 10,
            left: -118,
            child: SoftCircle(size: 270, color: AppColors.lavender),
          ),
          const Positioned(
            top: 310,
            left: -82,
            child: SoftCircle(size: 160, color: AppColors.blue),
          ),
          const Positioned.fill(
            child: CustomPaint(painter: SparklePainter()),
          ),
          Positioned.fill(child: child),
        ],
      ),
    );
  }
}

class SoftCard extends StatelessWidget {
  const SoftCard({
    required this.child,
    this.padding = const EdgeInsets.all(14),
    this.radius = 30,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppGradients.card,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: Colors.white.withOpacity(.86),
          width: 1.1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.wine.withOpacity(.08),
            blurRadius: 22,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 11, sigmaY: 11),
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}

class AppPill extends StatelessWidget {
  const AppPill({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 150),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.68),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withOpacity(.88)),
      ),
      child: Text(
        text.toUpperCase(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.wine,
              fontSize: 10,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w900,
            ),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.text,
    required this.onTap,
    this.icon,
    super.key,
  });

  final String text;
  final IconData? icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 58,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
          gradient: AppGradients.primary,
          borderRadius: BorderRadius.circular(23),
          boxShadow: [
            BoxShadow(
              color: AppColors.wine.withOpacity(.23),
              blurRadius: 22,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.white, size: 21),
              const SizedBox(width: 8),
            ],
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  text,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GhostButton extends StatelessWidget {
  const GhostButton({
    required this.text,
    required this.onTap,
    this.icon,
    super.key,
  });

  final String text;
  final IconData? icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 58,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.66),
          borderRadius: BorderRadius.circular(23),
          border: Border.all(color: Colors.white.withOpacity(.86)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: AppColors.wineDark, size: 19),
              const SizedBox(width: 7),
            ],
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  text,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.wineDark,
                        fontSize: 14,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResponsiveActions extends StatelessWidget {
  const ResponsiveActions({
    required this.first,
    required this.second,
    super.key,
  });

  final Widget first;
  final Widget second;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 350) {
          return Column(
            children: [
              first,
              const SizedBox(height: 10),
              second,
            ],
          );
        }

        return Row(
          children: [
            Expanded(child: first),
            const SizedBox(width: 10),
            Expanded(child: second),
          ],
        );
      },
    );
  }
}

class RoundIconButton extends StatelessWidget {
  const RoundIconButton({
    required this.icon,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.72),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(.90)),
        ),
        child: Icon(icon, color: AppColors.wineDark, size: 22),
      ),
    );
  }
}

class PressableScale extends StatefulWidget {
  const PressableScale({
    required this.child,
    required this.onTap,
    super.key,
  });

  final Widget child;
  final VoidCallback onTap;

  @override
  State<PressableScale> createState() => _PressableScaleState();
}

class _PressableScaleState extends State<PressableScale> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (_pressed == value) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => _setPressed(true),
      onTapCancel: () => _setPressed(false),
      onTapUp: (_) => _setPressed(false),
      behavior: HitTestBehavior.opaque,
      child: AnimatedScale(
        scale: _pressed ? .975 : 1,
        duration: const Duration(milliseconds: 110),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}

class PhotoAvatar extends StatelessWidget {
  const PhotoAvatar({
    required this.assetPath,
    required this.fallbackIcon,
    this.size = 56,
    this.borderWidth = 3,
    super.key,
  });

  final String assetPath;
  final IconData fallbackIcon;
  final double size;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(borderWidth),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(.94),
        boxShadow: [
          BoxShadow(
            color: AppColors.wine.withOpacity(.13),
            blurRadius: 14,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          assetPath,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) {
            return Container(
              color: AppColors.surface,
              child: Icon(
                fallbackIcon,
                color: AppColors.wine,
                size: size * .42,
              ),
            );
          },
        ),
      ),
    );
  }
}

class AppIconBubble extends StatelessWidget {
  const AppIconBubble({
    required this.icon,
    required this.color,
    this.iconColor = AppColors.wineDark,
    this.size = 52,
    this.radius = 18,
    super.key,
  });

  final IconData icon;
  final Color color;
  final Color iconColor;
  final double size;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: Colors.white.withOpacity(.68)),
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: size * .48,
      ),
    );
  }
}

class SoftCircle extends StatelessWidget {
  const SoftCircle({
    required this.size,
    required this.color,
    super.key,
  });

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withOpacity(.18),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(.23),
              blurRadius: 78,
              spreadRadius: 24,
            ),
          ],
        ),
      ),
    );
  }
}

class SparklePainter extends CustomPainter {
  const SparklePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final random = Random(11);

    final dotPaint = Paint()
      ..color = AppColors.rose.withOpacity(.15)
      ..style = PaintingStyle.fill;

    final linePaint = Paint()
      ..color = AppColors.wine.withOpacity(.08)
      ..strokeWidth = 1.1
      ..strokeCap = StrokeCap.round;

    for (var i = 0; i < 22; i++) {
      final dx = random.nextDouble() * size.width;
      final dy = random.nextDouble() * size.height;
      final radius = random.nextDouble() * 1.6 + .7;
      canvas.drawCircle(Offset(dx, dy), radius, dotPaint);
    }

    for (var i = 0; i < 7; i++) {
      final dx = random.nextDouble() * size.width;
      final dy = random.nextDouble() * size.height;
      final length = random.nextDouble() * 5 + 4;

      canvas.drawLine(
        Offset(dx - length / 2, dy),
        Offset(dx + length / 2, dy),
        linePaint,
      );
      canvas.drawLine(
        Offset(dx, dy - length / 2),
        Offset(dx, dy + length / 2),
        linePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant SparklePainter oldDelegate) => false;
}
