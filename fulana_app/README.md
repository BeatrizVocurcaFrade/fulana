# 💻 SAP Microcontroller Simulator

Um simulador interativo construído em Flutter que emula o funcionamento básico de um microcontrolador SAP (Simple As Possible). Este aplicativo permite aos usuários escrever código assembly simples, compilá-lo e observar a execução passo a passo ou automaticamente, visualizando as mudanças nos registradores, memória e flags.

---

## ✨ Visão Geral

Este projeto oferece uma ferramenta educacional para entender a arquitetura de computadores e o ciclo de instrução de uma CPU de forma prática e visual. Com uma interface de usuário intuitiva e animada, o simulador torna o aprendizado sobre o processamento de instruções e o fluxo de dados em um microcontrolador muito mais acessível.

---

## 🚀 Funcionalidades Principais

- **Editor de Código Assembly**: Escreva seu próprio código assembly SAP diretamente no aplicativo.
- **Compilador Integrado**: Converte o código assembly em instruções executáveis, com validação básica de sintaxe e operandos.
- **Execução Passo a Passo**: Avance uma instrução por vez para observar detalhadamente o impacto em cada componente do microcontrolador.
- **Modo de Execução Contínua**: Execute o programa automaticamente para ver o resultado final mais rapidamente.
- **Visualização de Registradores**:
  - PC (Program Counter)
  - IR (Instruction Register)
  - MAR (Memory Address Register)
  - MDR (Memory Data Register)
  - ACC (Accumulator)
  - OUT (Output Register)
- **Unidade Lógica Aritmética (ULA/ALU)**: Destaque visual da ULA durante operações como ADD e SUB.
- **Memória RAM**: Visualize o conteúdo de 16 posições de memória, com destaque para endereços acessados.
- **Flags de Estado**: Observe o Carry Flag e o Zero Flag que indicam o resultado de operações aritméticas.
- **Console de Log**: Um console integrado exibe mensagens de simulação e a saída da instrução `OUT`.
- **Animações e Destaques Visuais**: Elementos da interface se acendem para indicar qual bloco funcional ou posição de memória está ativo durante a execução.
- **Tela de Boas-Vindas (Splash Screen)**: Uma tela inicial estilosa com gradiente e um botão para iniciar a simulação.
- **Design Responsivo**: Interface otimizada para diferentes tamanhos de tela (desktop, tablet, mobile).

---

## 🖥️ Instruções Suportadas (Assembly SAP)

| Instrução    | Descrição                                                                 | Exemplo  |
|--------------|---------------------------------------------------------------------------|----------|
| `LDA <addr>` | Load Accumulator: Carrega o valor da posição de memória `<addr>` no ACC. | `LDA 14` |
| `ADD <addr>` | Add: Soma o valor da memória ao ACC.                                      | `ADD 15` |
| `SUB <addr>` | Subtract: Subtrai o valor da memória do ACC.                              | `SUB 10` |
| `STA <addr>` | Store: Armazena o valor do ACC na memória.                                | `STA 0`  |
| `JMP <addr>` | Jump: Salta para uma nova posição de memória.                             | `JMP 0`  |
| `OUT`        | Output: Exibe o valor do ACC no console.                                  | `OUT`    |
| `HLT`        | Halt: Finaliza a execução.                                                | `HLT`    |

- **Comentários**: Linhas iniciadas por `//` são ignoradas.
- **Dados**: Números sem instrução são carregados sequencialmente na memória.

---

## ⚙️ Como o Código Funciona

O aplicativo é desenvolvido em Flutter com Dart, seguindo boas práticas de arquitetura e componentização.

### 🗂 Estrutura do Projeto

- **`main.dart`**: Ponto de entrada da aplicação.
- **`lib/`**: Código-fonte principal.
  - `SAPSimulatorApp`: Widget raiz.
  - `SplashScreen`: Tela inicial com botão para iniciar.
  - `SAPHomePage`: Tela principal com a lógica do simulador.
  - `ParsedInstruction`: Classe que representa instruções compiladas.

### 🔧 Componentes Chave

#### `SAPSimulatorApp`
- Define o tema (teal + deepPurple).
- Usa Source Code Pro como fonte principal.

#### `SplashScreen`
- Fundo com gradiente estilizado.
- Botão "Iniciar" com transição para a `SAPHomePage`.

#### `SAPHomePage`
- Gerencia estados como registradores, memória, flags.
- Possui editor de texto, visualização dos blocos, memória e console.

#### Lógica de Execução

- `_compileCode()`: Compila o código digitado, valida e converte para instruções.
- `_executeStep()`: Executa uma instrução por vez, simulando operações e atualizando registradores.
- `_reset()`: Reinicia os estados do simulador.
- `_toggleRun()`: Alterna entre execução contínua e pausa.
- `_sapBlock()`: Mostra cada bloco do datapath com animações.
- `_buildInstructionLine()`: Renderiza cada instrução com destaque para a atual.

---

## 🎨 Estilização e Design

- **Paleta de Cores**: Teal + Deep Purple.
- **Fonte**: S
