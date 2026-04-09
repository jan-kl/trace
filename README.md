# TRACE: A Flexible SCA Engine

TRACE is a tool for SCA evaluation and verification of arithmetic circuits.

## Usage

### Direct Binary Execution

You can run the `trace` binary directly from your terminal. It is built static and should run on any Linux distribution. If this is not the case, please use the Docker execution method.

#### Command Syntax
```bash
./trace <input> [mode] [option] [method] [no-steps] [debug]
```

#### Arguments
- **input**: Path to the input circuit file (AAG/AIG format).
- **mode**:
  - `-add`: Adder circuit verification
  - `-mul`: Multiplier circuit verification
  - `-mac`: Multiply-accumulate (mac) circuit verification
  - `-dot=<nr terms>`: Dot Product (DP) circuit verification
  - `-gen`: Generate Specification Polynomial (SP) for the given circuit
- **option**:
  - `-u`: [default] Unsigned circuit
  - `-s`: Signed circuit
- **method**:
  - `-idx`: [default] Traverse using gate index search
  - `-igs`: Independent group search (LSB to MSB)
  - `-igsm`: Independent group search (MSB to LSB)
  - `-dfs`: Depth first search
  - `-bfs`: Breadth first search
  - `-dyn`: Dynamic priority based search
  - `-out`: Output distance based search
- **optimization**:
  - `-p`: Enable phase optimization
  - `-c`: Enable conflict detection
- **misc**:
  - `-no-steps`: Suppress printing of progress steps
  - `-debug=[topics]`: Enable specific debug topics (e.g., `all`, `conflict-calculation`, `phase`)

#### Example
```bash
./trace multiplier.aag -mul -p -c
```

**Running an Example Circuit:**
```bash
./trace example_circuits/multipliers/16_16_U_SP_AR_RC.aig -mul -p -c
```

---

### Docker Execution

A Docker container is provided for running `trace` in an isolated environment without local dependencies.

#### 1. Build the Image
```bash
docker build -t trace .
```

#### 2. Run the Tool
To process files from your host machine, you must mount the current directory into the container.

```bash
docker run --rm -v $(pwd):/data trace /data/<your_circuit>.aag [options]
```

```bash
docker run --rm -v $(pwd):/data trace /data/circuit.aag -add -p
```

**Running an Example Circuit:**
```bash
docker run --rm -v $(pwd):/data trace /data/example_circuits/multipliers/16_16_U_SP_AR_RC.aig -mul -p -c
```

---

## Example Circuits

The repository includes a variety of arithmetic circuits in the `example_circuits/` directory to help you get started.

### Directory Structure
- **`adders/`**: Various adder implementation (8-bit to 128-bit) using architectures like Ripple-Carry (RC), Kogge-Stone (KS), and Carry-Lookahead (CL).
- **`multipliers/`**: Multiplier circuits with different architectures (Array, Dadda Tree, Wallace Tree) and final stage adders. Includes **behavioral models** (e.g., `behavioral_MUL_16.aig`) for reference.
- **`macs/`**: Multiply-Accumulate circuits following similar architecture patterns as the multipliers. Includes **behavioral models** (e.g., `behavioral_mac_16.aig`).

### Naming Convention
Most files follow a structured naming convention:
`[Prefix]_[BitsA]_[BitsB]_[Type]_[Spec]_[Arch]_[FinalAdder].aig`

- **Prefix**: `ADD`, `NMAC`, or bit-widths (for multipliers).
- **BitsA / BitsB**: Input bit-widths (e.g., `16_16`).
- **Type**: `U` (Unsigned) or `S` (Signed).
- **Spec**: `SP` (Simple Partial products).
- **Arch**: `AR` (Array), `DT` (Dadda Tree), `WT` (Wallace Tree).
- **FinalAdder**: `RC` (Ripple-Carry), `KS` (Kogge-Stone), `CL` (Carry-Lookahead).

**Example:** `8_8_U_SP_AR_RC.aig` refers to an 8-bit unsigned array multiplier with a ripple-carry final adder.
