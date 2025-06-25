import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async'; // For Future.delayed

void main() => runApp(const SAPSimulatorApp());

class SAPSimulatorApp extends StatelessWidget {
  const SAPSimulatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SAP Microcontroller Simulator',
      theme: ThemeData(
        // Using a distinct seed color for a fresh look
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal.shade700),
        // Applying a monospace font for code readability
        textTheme: GoogleFonts.sourceCodeProTextTheme(Theme.of(context).textTheme).apply(
          bodyColor: Colors.deepPurple.shade900, // Darker text for better contrast
          displayColor: Colors.deepPurple.shade900,
        ),
        scaffoldBackgroundColor: Colors.grey.shade50, // Light grey background
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.teal.shade700, // AppBar color
          foregroundColor: Colors.white, // AppBar title/icon color
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple.shade600, // Button background
            foregroundColor: Colors.white, // Button text/icon color
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), // Rounded buttons
            elevation: 5, // Shadow effect
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.deepPurple.shade600,
            side: BorderSide(color: Colors.deepPurple.shade600, width: 2),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        cardTheme: CardTheme(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.teal.shade700, width: 2),
          ),
          labelStyle: TextStyle(color: Colors.deepPurple.shade700),
          hintStyle: TextStyle(color: Colors.grey.shade500),
          fillColor: Colors.white,
          filled: true,
        ),
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
  // --- SAP Microcontroller State Variables ---
  int _pc = 0; // Program Counter
  int _acc = 0; // Accumulator
  int _mar=0; // Memory Address Register
  String _currentInstruction='';
  int _mdr=0; // Memory Data Register
  int _out=0; // Output Register
  final List<int> _memory = List.generate(16, (index) => 0); // 16 memory locations, 0-15
  bool _carryFlag = false; // Carry Flag
  bool _zeroFlag = false; // Zero Flag
  bool _isRunning = false; // Controls continuous execution
  final List<String> _logMessages = []; // For output console

  // --- UI State Variables ---
  final TextEditingController _editorController = TextEditingController(
    text: "// Exemplo de Código Assembly SAP\n"
          "LDA 14   // Carrega o conteúdo da posição de memória 14 para o ACC\n"
          "ADD 15   // Adiciona o conteúdo da posição de memória 15 ao ACC\n"
          "STA 0    // Armazena o conteúdo do ACC na posição de memória 0\n"
          "OUT      // Exibe o valor do ACC\n"
          "JMP 0    // Salta para o endereço 0 (loop infinito para demonstração)\n"
          "HLT      // Interrompe a execução\n"
          "// Dados na memória (endereços 14 e 15)\n"
          "0\n" // Memória 6 (não usado no exemplo)
          "0\n" // Memória 7 (não usado no exemplo)
          "0\n" // Memória 8
          "0\n" // Memória 9
          "0\n" // Memória 10
          "0\n" // Memória 11
          "0\n" // Memória 12
          "0\n" // Memória 13
          "5\n" // Memória 14 (valor inicial)
          "3\n" // Memória 15 (valor inicial)
  );

  final List<ParsedInstruction> _compiledInstructions = [];
  int _highlightedInstructionIndex = -1; // -1 means no instruction highlighted
  String? _highlightedBlock; // To animate active functional blocks
  int? _highlightedMemoryAddress; // To animate active memory locations
  bool _isHalted = false; // To indicate if the processor is halted

  @override
  void initState() {
    super.initState();
    // Initialize memory with some default values for the example
    _memory[14] = 5;
    _memory[15] = 3;
    _compileCode(); // Compile initial code
  }

  @override
  void dispose() {
    _editorController.dispose();
    super.dispose();
  }


  // --- Simulation Control Functions ---

  // Compiles the assembly code from the editor
  void _compileCode() {
    setState(() {
      _isRunning = false; // Stop any ongoing execution
      _compiledInstructions.clear();
      _logMessages.clear();
      _pc = 0;
      _acc = 0;
      _mar = 0;
      _mdr = 0;
      _out = 0;
      _isHalted = false;
      _highlightedInstructionIndex = -1;
      _highlightedBlock = null;
      _highlightedMemoryAddress = null;
      _carryFlag = false;
      _zeroFlag = false;

      // Reset memory to initial example values or 0
      for (int i = 0; i < _memory.length; i++) {
        _memory[i] = 0;
      }
      _memory[14] = 5;
      _memory[15] = 3;

      final List<String> lines = _editorController.text.split('\n');
      int instructionCount = 0;

      for (int i = 0; i < lines.length; i++) {
        String line = lines[i].trim();
        if (line.isEmpty || line.startsWith('//')) {
          continue; // Skip empty lines and comments
        }

        // Split by comment marker if present
        if (line.contains('//')) {
          line = line.substring(0, line.indexOf('//')).trim();
        }

        List<String> parts = line.split(RegExp(r'\s+')).where((s) => s.isNotEmpty).toList();

        if (parts.isEmpty) continue; // Skip if only comments or empty after stripping

        String opcode = parts[0].toUpperCase();
        int? operand;

        if (parts.length > 1) {
          try {
            operand = int.parse(parts[1]);
          } catch (e) {
            _showErrorDialog("Erro de compilação na linha ${i + 1}: Operando inválido '$parts[1]'.");
            _reset();
            return;
          }
          if (operand < 0 || operand >= _memory.length) {
            _showErrorDialog("Erro de compilação na linha ${i + 1}: Endereço de memória '$operand' fora do intervalo (0-${_memory.length - 1}).");
            _reset();
            return;
          }
        }

        // Validate opcode
        switch (opcode) {
          case 'LDA':
          case 'ADD':
          case 'SUB':
          case 'STA':
          case 'JMP':
            if (operand == null) {
              _showErrorDialog("Erro de compilação na linha ${i + 1}: Instrução '$opcode' requer um operando de endereço.");
              _reset();
              return;
            }
            break;
          case 'OUT':
          case 'HLT':
            if (operand != null) {
              _showErrorDialog("Erro de compilação na linha ${i + 1}: Instrução '$opcode' não deve ter um operando.");
              _reset();
              return;
            }
            break;
          default:
            // If it's not a known instruction, it might be data for memory
            // We assume instructions come first, then data.
            // If instructionCount is 0, it means we are parsing memory values from the start
            // Otherwise, we consider it an instruction error if it's unexpected
            if (instructionCount < lines.length) { // Try to assign to memory if it's a number
              try {
                int dataValue = int.parse(line);
                if (instructionCount < _memory.length) {
                  _memory[instructionCount] = dataValue;
                } else {
                  _showErrorDialog("Erro de compilação na linha ${i + 1}: Excesso de dados para a memória ou instrução desconhecida '$line'.");
                  _reset();
                  return;
                }
              } catch (e) {
                _showErrorDialog("Erro de compilação na linha ${i + 1}: Instrução ou dado desconhecido '$line'.");
                _reset();
                return;
              }
            }
            instructionCount++; // Increment count even if it's an error, to avoid infinite loop
            continue; // Skip to next line if it's data
        }
        _compiledInstructions.add(ParsedInstruction(opcode, operand));
        instructionCount++;
      }

      if (_compiledInstructions.isEmpty) {
        _showErrorDialog("Por favor, insira pelo menos uma instrução válida no código.");
        _reset();
        return;
      }
    });
  }

  // Executes one step of the simulation
  Future<void> _executeStep() async {
    if (_isHalted) {
      _log("Processador HLT (Parado). Clique em Resetar para reiniciar.");
      return;
    }
    if (_pc >= _compiledInstructions.length) {
      _log("Fim das instruções. Clique em Resetar para reiniciar.");
      _isHalted = true;
      return;
    }

    setState(() {
      _highlightedInstructionIndex = _pc; // Highlight current instruction
      _highlightedBlock = 'PC'; // Highlight PC as it provides the address
    });
    await Future.delayed(const Duration(milliseconds: 300)); // Animation delay

    final ParsedInstruction currentInstruction = _compiledInstructions[_pc];
    setState(() {
      _currentInstruction = currentInstruction.toString(); // Update IR display
      _highlightedBlock = 'IR'; // Highlight IR as instruction is loaded
    });
    await Future.delayed(const Duration(milliseconds: 300)); // Animation delay

    // Reset highlights before executing instruction specifics
    setState(() {
      _highlightedBlock = null;
      _highlightedMemoryAddress = null;
    });
    await Future.delayed(const Duration(milliseconds: 100)); // Small pause

    int nextPc = _pc + 1; // Default next PC

    _log("Executando: ${currentInstruction.toString()} (PC: $_pc)");

    switch (currentInstruction.opcode) {
      case 'LDA':
        setState(() {
          _mar = currentInstruction.operand??0;
          _highlightedBlock = 'MAR';
          _highlightedMemoryAddress = currentInstruction.operand;
        });
        await Future.delayed(const Duration(milliseconds: 500));
        setState(() {
          _mdr = _memory[currentInstruction.operand!];
          _highlightedBlock = 'MDR';
        });
        await Future.delayed(const Duration(milliseconds: 500));
        setState(() {
          _acc = _mdr;
          _highlightedBlock = 'ACC';
          _zeroFlag = (_acc == 0);
          _carryFlag = false; // LDA doesn't produce carry
        });
        break;
      case 'ADD':
        setState(() {
          _mar = currentInstruction.operand??0;
          _highlightedBlock = 'MAR';
          _highlightedMemoryAddress = currentInstruction.operand;
        });
        await Future.delayed(const Duration(milliseconds: 500));
        setState(() {
          _mdr = _memory[currentInstruction.operand!];
          _highlightedBlock = 'MDR';
        });
        await Future.delayed(const Duration(milliseconds: 500));
        setState(() {
          _highlightedBlock = 'ULA'; // Highlight ALU for operation
          // Simulate carry for positive numbers adding
          int sum = _acc + _mdr;
          _carryFlag = (sum > 255); // Simple overflow for 8-bit, just for demonstration
          _acc = sum & 0xFF; // Keep within 8-bit range for demo
          _zeroFlag = (_acc == 0);
        });
        break;
      case 'SUB':
        setState(() {
          _mar = currentInstruction.operand??0;
          _highlightedBlock = 'MAR';
          _highlightedMemoryAddress = currentInstruction.operand;
        });
        await Future.delayed(const Duration(milliseconds: 500));
        setState(() {
          _mdr = _memory[currentInstruction.operand!];
          _highlightedBlock = 'MDR';
        });
        await Future.delayed(const Duration(milliseconds: 500));
        setState(() {
          _highlightedBlock = 'ULA'; // Highlight ALU for operation
          // Simulate borrow/carry for subtraction (simplified)
          int diff = _acc - _mdr;
          _carryFlag = (diff < 0); // Indicates borrow
          _acc = diff;
          _zeroFlag = (_acc == 0);
        });
        break;
      case 'STA':
        setState(() {
          _mar = currentInstruction.operand??0;
          _highlightedBlock = 'MAR';
          _highlightedMemoryAddress = currentInstruction.operand;
        });
        await Future.delayed(const Duration(milliseconds: 500));
        setState(() {
          _mdr = _acc;
          _highlightedBlock = 'MDR';
        });
        await Future.delayed(const Duration(milliseconds: 500));
        setState(() {
          _memory[currentInstruction.operand!] = _mdr;
          _highlightedBlock = null; // Memory write doesn't have a specific block
          _highlightedMemoryAddress = currentInstruction.operand;
        });
        break;
      case 'JMP':
        nextPc = currentInstruction.operand!;
        setState(() {
          _highlightedBlock = 'PC'; // Highlight PC as it changes directly
        });
        break;
      case 'OUT':
        setState(() {
          _out = _acc;
          _highlightedBlock = 'OUT';
        });
        _log("OUTPUT: $_acc");
        break;
      case 'HLT':
        _isHalted = true;
        _isRunning = false;
        _log("Processador HLT (Parado).");
        setState(() {
          _highlightedBlock = null;
        });
        break;
      default:
        _showErrorDialog("Instrução inválida encontrada: ${currentInstruction.opcode}");
        _isHalted = true;
        _isRunning = false;
        break;
    }

    if (!_isHalted) {
      setState(() {
        _pc = nextPc;
        _mar = 0; // Clear MAR/MDR after use
        _mdr = 0;
        _highlightedBlock = 'PC'; // PC updates for next cycle
      });
      await Future.delayed(const Duration(milliseconds: 300));
      setState(() {
        _highlightedBlock = null;
        _highlightedMemoryAddress = null;
      });
    }

    if (_isRunning && !_isHalted) {
      await Future.delayed(const Duration(milliseconds: 800)); // Delay between steps in run mode
      _executeStep(); // Continue if still running
    } else {
      setState(() {
        _highlightedInstructionIndex = -1; // Remove highlight if stopped or halted
        _highlightedBlock = null;
      });
    }
  }

  // Resets the simulation to its initial state
  void _reset() {
    setState(() {
      _isRunning = false;
      _pc = 0;
      _acc = 0;
      _mar = 0;
      _mdr = 0;
      _out = 0;
      _logMessages.clear();
      _isHalted = false;
      _highlightedInstructionIndex = -1;
      _highlightedBlock = null;
      _highlightedMemoryAddress = null;
      _carryFlag = false;
      _zeroFlag = false;

      // Reset memory to initial example values or 0
      for (int i = 0; i < _memory.length; i++) {
        _memory[i] = 0;
      }
      _memory[14] = 5;
      _memory[15] = 3;
    });
    _log("Simulação Resetada.");
  }

  // Toggles the continuous run mode
  void _toggleRun() {
    setState(() {
      _isRunning = !_isRunning;
    });
    if (_isRunning) {
      _log("Iniciando execução automática...");
      _executeStep();
    } else {
      _log("Execução automática pausada.");
    }
  }

  // Adds a message to the log console
  void _log(String message) {
    setState(() {
      _logMessages.add("[${DateTime.now().second.toString().padLeft(2, '0')}] $message");
      if (_logMessages.length > 10) { // Keep log concise
        _logMessages.removeAt(0);
      }
    });
  }

  // --- UI Helper Widgets ---

  // Shows an error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Erro de Simulação', style: TextStyle(color: Colors.red)),
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
 // Shows information about the simulator
  void _showInfoDialo2() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sobre o Blocos funcionais'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
          
              Text(
                'Blocos Funcionais:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              Text(
                '- PC (Program Counter): Endereço da próxima instrução.\n'
                '- IR (Instruction Register): Instrução sendo executada.\n'
                '- MAR (Memory Address Register): Endereço de memória a ser acessado.\n'
                '- MDR (Memory Data Register): Dado lido/escrito da memória.\n'
                '- ACC (Accumulator): Registrador para operações aritméticas/lógicas.\n'
                '- ULA (ALU - Arithmetic Logic Unit): Realiza operações matemáticas.\n'
                '- OUT (Output Register): Exibe o valor final.\n'
                '- Flags (C/Z): Indicam Carry (transbordo) e Zero (resultado zero).',
                style: TextStyle(fontSize: 14),
              ),
            
              
            ],
          ),
        ),
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
  // Shows information about the simulator
  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sobre o SAP Microcontroller Simulator'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                'Este simulador emula o funcionamento básico de um microcontrolador SAP (Simple As Possible). '
                'Você pode escrever código assembly, compilá-lo e observar a execução passo a passo ou automaticamente.',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 10),
            
             
              Text(
                'Instruções Suportadas:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              Text(
                'LDA <addr>: Carrega da memória para ACC.\n'
                'ADD <addr>: Adiciona da memória ao ACC.\n'
                'SUB <addr>: Subtrai da memória do ACC.\n'
                'STA <addr>: Armazena ACC na memória.\n'
                'JMP <addr>: Salta incondicionalmente para <addr>.\n'
                'OUT: Exibe ACC no console.\n'
                'HLT: Interrompe a execução.',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
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

  // Widget to display an individual instruction line
  Widget _buildInstructionLine(ParsedInstruction instruction, int index) {
    final isCurrent = index == _highlightedInstructionIndex;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: isCurrent ? Colors.teal.shade100 : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isCurrent ? Colors.teal.shade400 : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: Text(
        "${index.toString().padLeft(2, '0')}: ${instruction.toString()}",
        style: TextStyle(
          fontSize: 16,
          fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
          color: isCurrent ? Colors.teal.shade800 : Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),
    );
  }

  // Widget for a single functional block (PC, IR, ACC, etc.)
  Widget _sAPBlock(String name, {String? value, String? imagePath, String? blockId}) {
    final isActive = _highlightedBlock == blockId;
    return Card(
      color: isActive ? Colors.amber.shade100 : Colors.white,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: isActive ? Colors.amber.shade700 : Colors.grey.shade300,
            width: isActive ? 2.5 : 1,
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: isActive
              ? [BoxShadow(color: Colors.amber.shade200, blurRadius: 10, spreadRadius: 2)]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.deepPurple.shade700,
              ),
            ),
            const SizedBox(height: 8),
            if (imagePath != null)
              AnimatedOpacity(
                opacity: isActive ? 1.0 : 0.7,
                duration: const Duration(milliseconds: 300),
                child: SizedBox(
                  height: 60,
                  width: 60,
                  child: Image.asset(imagePath, fit: BoxFit.contain),
                ),
              )
            else
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: Text(
                  value ?? "-",
                  key: ValueKey(value), // Key helps AnimatedSwitcher identify changes
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isActive ? Colors.amber.shade900 : Colors.blue.shade700,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Widget for the main datapath view
  Widget _datapathView() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    "Registradores e Unidade Lógica Aritmética (ULA)",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.teal.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                  IconButton(
            onPressed: _showInfoDialo2,
            icon:  Icon(Icons.info_outline,color: Colors.teal.shade400 ,),
            tooltip: 'Sobre o Simulador',
          ),
              ],
            ),
            const SizedBox(height: 20),
            // Row for PC, IR, MAR, MDR
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(child: _sAPBlock("PC", value: _pc.toString(), imagePath: 'assets/pc.png', blockId: 'PC')),
                Expanded(child: _sAPBlock("IR", value: _currentInstruction, imagePath: 'assets/ir.png', blockId: 'IR')),
                Expanded(child: _sAPBlock("MAR", value: _mar.toString() =='0'?  "-":_mar.toString(), blockId: 'MAR')),
                Expanded(child: _sAPBlock("MDR", value: _mdr.toString() =='0'? "-":_mdr.toString(), blockId: 'MDR')),
              ],
            ),
            const SizedBox(height: 20),
            // Row for ACC, ULA, OUT, Flags
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(child: _sAPBlock("ACC", value: _acc.toString(), imagePath: 'assets/ac.png', blockId: 'ACC')),
                Expanded(child: _sAPBlock("ULA", imagePath: 'assets/ula.png', blockId: 'ULA')),
                Expanded(child: _sAPBlock("OUT", value: _out.toString()=='0'?  "-": _out.toString(), blockId: 'OUT')),
                Expanded(
                  child: Card(
                    color: Colors.white,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _carryFlag || _zeroFlag ? Colors.blue.shade700 : Colors.grey.shade300,
                          width: _carryFlag || _zeroFlag ? 2.5 : 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: _carryFlag || _zeroFlag
                            ? [BoxShadow(color: Colors.blue.shade200, blurRadius: 10, spreadRadius: 2)]
                            : [],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "FLAGS",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.deepPurple.shade700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Flexible(
                                child: Text("C: ${_carryFlag ? '1' : '0'}", style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: _carryFlag ? Colors.red.shade700 : Colors.grey.shade600,
                                )),
                              ),
                            Flexible(
                                child:  Text("Z: ${_zeroFlag ? '1' : '0'}", style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: _zeroFlag ? Colors.red.shade700 : Colors.grey.shade600,
                              ))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget for the memory view
  Widget _memoryView() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Memória RAM",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.teal.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(), // Disable scrolling
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // 4 columns for memory cells
                childAspectRatio: 2.0,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: _memory.length,
              itemBuilder: (context, index) {
                final isHighlighted = _highlightedMemoryAddress == index;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  decoration: BoxDecoration(
                    color: isHighlighted ? Colors.blue.shade100 : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isHighlighted ? Colors.blue.shade700 : Colors.grey.shade300,
                      width: isHighlighted ? 2 : 1,
                    ),
                    boxShadow: isHighlighted
                        ? [BoxShadow(color: Colors.blue.shade200, blurRadius: 8, spreadRadius: 1)]
                        : [],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          "Addr: ${index.toString().padLeft(2, '0')}",
                          style: TextStyle(
                            fontSize: 12,
                            color: isHighlighted ? Colors.blue.shade900 : Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                       Flexible(
                        child:Text(
                        "Val: ${_memory[index].toString()}",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: isHighlighted ? Colors.blue.shade900 : Colors.deepPurple.shade800,
                        ),
                      ),),
                      SizedBox(height: 4,)
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Widget for the output console
  Widget _outputConsole() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Console de Saída",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.teal.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 120, // Fixed height for the console
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade700),
              ),
              child: ListView.builder(
                reverse: true, // Show latest messages at the bottom
                itemCount: _logMessages.length,
                itemBuilder: (context, index) {
                  return Text(
                    _logMessages[_logMessages.length - 1 - index], // Display in reverse order
                    style: const TextStyle(
                      fontFamily: 'SourceCodePro',
                      color: Colors.lightGreenAccent,
                      fontSize: 13,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Main Build Method ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('SAP Microcontroller'),
        actions: [
          IconButton(
            onPressed: _showInfoDialog,
            icon: const Icon(Icons.info_outline),
            tooltip: 'Sobre o Simulador',
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Adjust layout based on screen width
          if (constraints.maxWidth > 800) {
            // Desktop/Tablet view (two columns)
            return Row(
              children: [
                Expanded(
                  flex: 2,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Card(
                          margin: EdgeInsets.zero,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Editor de Código Assembly",
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: Colors.teal.shade700,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextField(
                                  controller: _editorController,
                                  maxLines: 15,
                                  minLines: 10,
                                  decoration: const InputDecoration(
                                    labelText: 'Assembly Code',
                                    hintText: 'Digite seu código Assembly aqui...',
                                  ),
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontFamily: 'SourceCodePro',
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Flexible(
                                      child: ElevatedButton.icon(
                                        onPressed: _compileCode,
                                        icon: const Icon(Icons.code),
                                        label: const Text('Compilar', style: TextStyle(fontSize: 16)),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Flexible(
                                      child: ElevatedButton.icon(
                                        onPressed: _isHalted || _pc >= _compiledInstructions.length
                                            ? null
                                            : _executeStep,
                                        icon: const Icon(Icons.skip_next),
                                        label: const Text('Próximo Passo', style: TextStyle(fontSize: 16)),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Flexible(
                                      child: OutlinedButton.icon(
                                        onPressed: _reset,
                                        icon: const Icon(Icons.refresh),
                                        label: const Text('Resetar', style: TextStyle(fontSize: 16)),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Flexible(
                                      child: ElevatedButton.icon(
                                        onPressed: _isHalted || _pc >= _compiledInstructions.length
                                            ? null
                                            : _toggleRun,
                                        icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow),
                                        label: Text(_isRunning ? 'Pausar' : 'Executar', style: TextStyle(fontSize: 16)),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Instruções Compiladas",
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: Colors.teal.shade700,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.4),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: _compiledInstructions.length,
                                    itemBuilder: (context, index) => _buildInstructionLine(_compiledInstructions[index], index),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        _outputConsole(),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _datapathView(),
                        _memoryView(),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            // Mobile view (single column)
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Editor de Código Assembly",
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.teal.shade700,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _editorController,
                            maxLines: 10,
                            minLines: 6,
                            decoration: const InputDecoration(
                              labelText: 'Assembly Code',
                              hintText: 'Digite seu código Assembly aqui...',
                            ),
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontFamily: 'SourceCodePro',
                            ),
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            alignment: WrapAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                onPressed: _compileCode,
                                icon: const Icon(Icons.code),
                                label: const Text('Compilar', style: TextStyle(fontSize: 14)),
                              ),
                              ElevatedButton.icon(
                                onPressed: _isHalted || _pc >= _compiledInstructions.length
                                    ? null
                                    : _executeStep,
                                icon: const Icon(Icons.skip_next),
                                label: const Text('Próximo Passo', style: TextStyle(fontSize: 14)),
                              ),
                              OutlinedButton.icon(
                                onPressed: _reset,
                                icon: const Icon(Icons.refresh),
                                label: const Text('Resetar', style: TextStyle(fontSize: 14)),
                              ),
                              ElevatedButton.icon(
                                onPressed: _isHalted || _pc >= _compiledInstructions.length
                                    ? null
                                    : _toggleRun,
                                icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow),
                                label: Text(_isRunning ? 'Pausar' : 'Executar', style: TextStyle(fontSize: 14)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Instruções Compiladas",
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.teal.shade700,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.3),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: _compiledInstructions.length,
                              itemBuilder: (context, index) => _buildInstructionLine(_compiledInstructions[index], index),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _datapathView(),
                  _memoryView(),
                  _outputConsole(),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
  // Represents a parsed assembly instruction
  class ParsedInstruction {
    final String opcode;
    final int? operand; // Can be null for instructions like OUT, HLT

    ParsedInstruction(this.opcode, this.operand);

    @override
    String toString() {
      return operand != null ? "$opcode $operand" : opcode;
    }
  }
