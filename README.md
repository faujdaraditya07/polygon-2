# polygon-2

# zkSNARK Circuit Deployment 

Welcome to the zkSNARK Circuit Deployment Project README. This document outlines the task set by Polygon to design a new zkSNARK circuit that implements logical operations, generate a proof using specific inputs, and deploy a verifier on-chain to verify these proofs. This guide will take you through the process of implementing the circuit using Circom, compiling it, generating proofs, and deploying a Solidity verifier on a testnet such as Sepolia or Mumbai.

## Project Overview

- Design a zkSNARK circuit in Circom that performs logical operations.
- Compile the circuit to generate the necessary intermediaries.
- Generate a zkSNARK proof for given inputs (A=0, B=1).
- Deploy a Solidity verifier smart contract to Sepolia or Mumbai Testnet.
- Call the `verifyProof()` method on the deployed verifier contract and assert that the output is true.

## Getting Started

### Prerequisites

Ensure you have the following installed before proceeding:
- Node.js (v14.x or later)
- npm or yarn
- Circom 2.0 (for circuit compilation)
- SnarkJS (for zkSNARK proof generation)
- Hardhat (for deploying Solidity contracts)
- An Ethereum wallet with testnet ETH for deployment

### Installation

Clone this repository and install the required Node.js dependencies:

```bash
git clone https://github.com/your-username/zksnark-circuit-project.git
cd zksnark-circuit-project
npm install
```

## Project Steps

### Step 1: Write the Circuit in Circom

Create a circuit `circuit.circom` that performs the specified logical operations:

### Step 2: Compile the Circuit

Compile the circuit to generate the necessary circuit artifacts:

```bash
circom circuit.circom --r1cs --wasm --sym
snarkjs r1cs info circuit.r1cs
```

### Step 3: Setup and Generate a zkSNARK Proof

Set up the initial zkSNARK parameters and generate a proof with inputs `A=0` and `B=1`:

```bash
snarkjs groth16 setup circuit.r1cs pot12_final.ptau circuit_final.zkey
snarkjs zkey contribute circuit_final.zkey circuit_final.zkey --name="1st Contributor Name" -v
snarkjs zkey export verificationkey circuit_final.zkey verification_key.json

snarkjs groth16 prove circuit_final.zkey circuit.wasm input.json proof.json public.json
```

### Step 4: Deploy the Solidity Verifier

Compile and deploy the verifier contract using Hardhat:

```bash
npx hardhat run scripts/deploy.js 
```

### Step 5: Verify the Proof on-chain

Use the deployed verifier contract to verify the proof:

```bash
npx hardhat run scripts/verify.js 
```

Make sure the `verifyProof()` function returns `true`, confirming the proof is valid.

## Folder Structure

- **contracts/**: Contains Solidity verifier contract.
- **scripts/**: Contains Hardhat scripts for deploying and verifying proofs.
- **circuits/**: Contains the Circom circuit definitions.
- **build/**: Contains compiled circuits and proofs.
- **test/**: Contains test scripts for the verifier contract.

## Usage

Modify the circuit and scripts as required, run the deployment and proof generation scripts, and test the verifier on the blockchain.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

By following these instructions, you should be able to successfully design, compile, and deploy a zkSNARK circuit and its verifier, as well as verify a proof on-chain as requested by Polygon.
