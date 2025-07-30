# bf-hs

A Brainfuck interpreter written in Haskell.

## Overview

bf-hs is a simple and efficient Brainfuck interpreter that can execute Brainfuck programs from files or standard input. Brainfuck is an esoteric programming language with only eight commands, making it a fun challenge to implement and an interesting way to explore language interpreters.

## Features

- Complete Brainfuck language support with all 8 commands
- 30,000-cell memory tape (standard Brainfuck specification)
- Wraparound pointer arithmetic for safe memory access
- Interactive input/output support
- Read programs from files or standard input
- Clean, readable Haskell implementation

## Brainfuck Commands

| Command | Description |
|---------|-------------|
| `>` | Move the data pointer to the right |
| `<` | Move the data pointer to the left |
| `+` | Increment the byte at the data pointer |
| `-` | Decrement the byte at the data pointer |
| `.` | Output the byte at the data pointer as an ASCII character |
| `,` | Input a byte and store it at the data pointer |
| `[` | Jump forward to the command after the matching `]` if the byte at the data pointer is zero |
| `]` | Jump back to the command after the matching `[` if the byte at the data pointer is nonzero |

## Installation

### Prerequisites

- [GHC](https://www.haskell.org/ghc/) (Glasgow Haskell Compiler)
- [Cabal](https://www.haskell.org/cabal/) build system

### Building from Source

1. Clone the repository:
   ```bash
   git clone https://github.com/grapefizz/bf-hs.git
   cd bf-hs
   ```

2. Build the project:
   ```bash
   cabal build
   ```

3. Install the executable:
   ```bash
   cabal install
   ```

## Usage

### Running a Brainfuck Program from a File

```bash
bf-hs program.bf
```

### Running a Brainfuck Program from Standard Input

```bash
echo ">++++++++[<+++++++++>-]<." | bf-hs
```

or

```bash
bf-hs < program.bf
```

### Example

The repository includes a sample "Hello World" program in `hello.bf`:

```bash
bf-hs hello.bf
```

This should output: `Hello World!`

## Example Programs

### Hello World (`hello.bf`)
```brainfuck
>++++++++[<+++++++++>-]<.
>++++[<+++++++>-]<+.
+++++++..
+++.
>>++++++[<+++++++>-]<++.
------------.
>++++++[<+++++++++>-]<+.
<.
+++.
------.
--------.
>>>++++[<++++++++>-]<+.
```

### Simple Addition
```brainfuck
,>,<[->+<]>.
```
This program reads two single-digit numbers and outputs their sum.

## Implementation Details

- **Memory Model**: Uses a 30,000-cell tape implemented with Haskell's `IOUArray`
- **Pointer Wrapping**: Implements wraparound arithmetic to prevent segmentation faults
- **Loop Matching**: Efficient bracket matching algorithm for `[` and `]` commands
- **I/O Handling**: Immediate character output with buffer flushing for responsive interaction

## Development

### Project Structure

```
bf-hs/
├── app/
│   └── Main.hs          # Main interpreter implementation
├── bf-hs.cabal          # Cabal package configuration
├── hello.bf             # Example Brainfuck program
├── LICENSE              # MIT License
├── CHANGELOG.md         # Version history
└── README.md            # This file
```

### Dependencies

- `base`: Core Haskell library
- `array`: For efficient mutable arrays

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Acknowledgments

- Inspired by the original Brainfuck language created by Urban Müller
- Built with the excellent Haskell ecosystem
