import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const SAPSimulatorApp());

class SAPSimulatorApp extends StatelessWidget {
  const SAPSimulatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SAP Microcontroller Simulator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: GoogleFonts.sourceCodeProTextTheme(),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const SAPHomePage(),
    );
  }
}

class SAPHomePage extends StatefulWidget {
  const SAPHomePage({super.key});

  @override
  State<SAPHomePage> createState() => _SAPHomePageState();
}

class _SAPHomePageState extends State<SAPHomePage> {
  final TextEditingController _controller = TextEditingController(text: "LDA 14\nADD 15\nOUT\nHLT");
  int _step = 0;
  final List<String> _instructions = [];

  void _executeStep() {
    if (_step < _instructions.length) {
      setState(() => _step++);
    }
  }

  void _reset() {
    setState(() => _step = 0);
  }

  void _compileCode() {
    final lines = _controller.text.split('\n');
    if (lines.isEmpty || lines.every((e) => e.trim().isEmpty)) {
      _showErrorDialog("Por favor, insira pelo menos uma instrução válida no código.");
      return;
    }
    setState(() {
      _instructions.clear();
      _instructions.addAll(lines.map((e) => e.trim()).where((e) => e.isNotEmpty));
      _step = 0;
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Erro'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  Widget _buildInstruction(String text, int index) {
    final isCurrent = index == _step;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: isCurrent ? Colors.deepPurple.shade100 : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(text, style: TextStyle(fontSize: 16, fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal)),
    );
  }

  Widget _block(String name, {String value = "0", required double size, String? imagePath}) {
    final isActive = value == (_step < _instructions.length ? _instructions[_step] : "HLT");
    return Column(
      children: [
        Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        AnimatedOpacity(
          opacity: isActive ? 1.0 : 0.6,
          duration: const Duration(milliseconds: 300),
          child: imagePath != null
              ? SizedBox(height: size, width: size, child: Image.asset(imagePath))
              : Text(value, style: const TextStyle(fontSize: 18)),
        ),
      ],
    );
  }

  Widget _datapathView() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _block("PC", imagePath: 'assets/pc.png', size: 80),
            _block("IR", value: _step < _instructions.length ? _instructions[_step] : "HLT", imagePath: 'assets/ir.png', size: 110),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _block("ACC", imagePath: 'assets/ac.png', size: 80),
            _block("ULA", imagePath: 'assets/ula.png', size: 110),
          ],
        ),
      ],
    );
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sobre o SAP Microcontroller Simulator'),
        content: const Text(
          'Este simulador permite emular a execução de um código assembly no microcontrolador SAP. '
          'Você pode escrever instruções no editor de código, compilar o código e executar as instruções passo a passo. '
          'A interface mostra os blocos funcionais do microcontrolador, como PC, IR, ACC e ULA, e simula seu comportamento à medida que o código é executado.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();  // Fecha a caixa de diálogo
            },
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('SAP Microcontroller', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: _showInfoDialog,
            icon: const Icon(Icons.info, color: Colors.white),
          ),
        ],
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _controller,
                maxLines: 6,
                decoration: const InputDecoration(
                  labelText: 'Assembly Code',
                  hintText: 'Digite seu código Assembly aqui...',
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(fontFamily: 'SourceCodePro'),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: _compileCode,
                    icon: const Icon(Icons.code),
                    label: const Text('Compilar'),
                  ),
                  ElevatedButton.icon(
                    onPressed: _executeStep,
                    icon: const Icon(Icons.skip_next),
                    label: const Text('Próximo Passo'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: _reset,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Resetar'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text("Instruções Compiladas:", style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(_instructions.length, (i) => _buildInstruction(_instructions[i], i)),
                ),
              ),
              const SizedBox(height: 24),
              _datapathView(),
            ],
          ),
        ),
      ),
    );
  }
}
