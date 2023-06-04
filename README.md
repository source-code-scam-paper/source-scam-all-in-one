# source-scam-all-in-one
This repository introduces our research in source code verifier, including PoC, related issues implementation code and other content.


## Description of each risk PoC
The following table shows the PoC of the source code fraud attack and the credit.
 **Attack Item**                                                        | **(PoC)Victim or Normal Contract** | **(PoC)Attack Contract** | **Related implementations** | **Fix** | 
:----------------------------------------------------------------------:|:-------------------:|:-------------------:|:---------------------------:|:-------:|
 **(R1)Exploitable Compiler Features**                  |[Victim in Etherscan](https://goerli.etherscan.io/address/0x51745186a4216eb053ba2647b4f33ffdc013c1b1)|[Attack Contract in Etherscan](https://goerli.etherscan.io/address/0xc8931cc5d4814ff570b3672d4149d22caec5af5a)|--|Report via private channel|            |
 **(R2)Unchecked Simulated Execution**            | [Normal Contract in Etherscan](https://eth-goerli.blockscout.com/address/0xF822070D07067D1519490dBf49448a7E30EE9ea5?tab=contract)|[Attacked Contract in Sourcify](https://repo.sourcify.dev/contracts/full_match/5/0xF822070D07067D1519490dBf49448a7E30EE9ea5/sources/contracts/)|[L196-L256](https://github.com/ethereum/sourcify/blob/1ef0e73edf4efec5c4a1baa7276a061d97cafc9e/packages/lib-sourcify/src/lib/verification.ts#L196-L256)|[credit](https://github.com/ethereum/sourcify/releases/tag/v2.1.1)|--|
 **(R3)Incomplete Bytecode Validation**                       |[Normal Contract in Etherscan](https://goerli.etherscan.io/address/0x5ea1e75790b86c4c5db5e7c7a1fa14d683d50cfe/)|[Attacked Contract in Sourcify](https://repo.staging.sourcify.dev/contracts/partial_match/5/0x5ea1E75790b86C4c5Db5e7c7A1fa14d683D50Cfe/sources/contracts/)|[L280-L286](https://github.com/ethereum/sourcify/blob/1ef0e73edf4efec5c4a1baa7276a061d97cafc9e/packages/lib-sourcify/src/lib/verification.ts#L280-L286)|[credit](https://github.com/ethereum/sourcify/releases/tag/v2.2.0)|--|
 **(R4)Unreliable Client Node**                                         |[Etherscan Waring](https://goerli-optimism.etherscan.io/address/0x341577fB771EBFB4FaF74fBcF786d4F7Ce02BBaB#code)|[sourcify PoC](https://repo.sourcify.dev/contracts/partial_match/420/0x341577fB771EBFB4FaF74fBcF786d4F7Ce02BBaB/sources),[Blockscout PoC](https://blockscout.com/optimism/goerli/address/0x341577fB771EBFB4FaF74fBcF786d4F7Ce02BBaB)[Etherscan PoC](https://api-goerli-optimism.etherscan.io/api?module=contract&action=getsourcecode&address=0x341577fB771EBFB4FaF74fBcF786d4F7Ce02BBaB&apikey=YourApiKeyToken)|--|[confirm](https://github.com/blockscout/blockscout-rs/issues/531)|--|
 **(R5)Unverified Linked** |--|[Attack Contract in Etherscan](https://goerli-optimism.etherscan.io/address/0x4fdaCE0cDb4eb9fd102df757808Ae6d83cF8af15)|--|[confirm](https://github.com/blockscout/blockscout-rs/issues/532)|  |
 **(R6 PoC#1) Mislabeled Bytecode**                           |[Normal Contract in Etherscan](https://goerli.etherscan.io/address/0xB3085B77E24798d79D2fAF8495B20d570753d86F)|[Attack Contract in Blockscout](https://archive.is/AXs2z)|[L100-L121](https://github.com/blockscout/blockscout-rs/blob/2cdb3c2c8e532c3d8ac3718cf01a3462d36636c1/smart-contract-verifier/smart-contract-verifier/src/verifier/contract_verifier.rs)|[credit](https://github.com/blockscout/blockscout-rs/issues/416)|--|
  **(R6PoC#2) Mislabeled Bytecode**               |[Normal Contract in Etherscan](https://goerli.etherscan.io/address/0x4AD29c9716569f3c466BB123Efdd0B9B43207dE1)|[Attack Contract in Sourcify](https://repo.staging.sourcify.dev/contracts/partial_match/5/0x4AD29c9716569f3c466BB123Efdd0B9B43207dE1/sources/)|[L383-L411](https://github.com/ethereum/sourcify/blob/v2.0.0/packages/lib-sourcify/src/lib/verification.ts#L383-L411)|[credit](https://github.com/ethereum/sourcify/releases/tag/v2.1.0)|-| 
 **(R7)Path Traversal Risk**                     |[SimToken Contract In Etherscan](https://goerli-optimism.etherscan.io/address/0x107D559924d935a7e56fd41D5ee4fAF36aCc5C7e#contracts)|[Sourcify PoC](https://repo.staging.sourcify.dev/contracts/partial_match/420/0x107D559924d935a7e56fd41D5ee4fAF36aCc5C7e/)|--|[credit](https://github.com/ethereum/sourcify/releases/tag/v2.2.0)|--|
 **(R8)Inadequate Information Disclosure**          |--|[etherscan PoC](https://goerli-optimism.etherscan.io/address/0x3C10387CF5cC4B655d12898C3628AF38C5E792c2#code),[blockscout PoC](https://blockscout.com/optimism/goerli/address/0x3C10387CF5cC4B655d12898C3628AF38C5E792c2/contracts#address-tabs)|--|[confirm](https://github.com/blockscout/blockscout-rs/issues/530)||

 
## Attacks on Downstream Applications
 
[Here](report/Attack_Downstream_APP.md), we demonstrate crytic-compile-based vulnerabilities such as Slither as well as Echidna, which exploit malicious source code verification results to achieve overwriting of locally arbitrary files.
<!--  [SimUniswap Contract Etherscan](https://goerli-optimism.etherscan.io/address/0xa4369e612A00C5677DEE4C7ceCd75D1E36CAd41D#code), -->

## Blackbox Testing in Etherscan

**Q1. Whether Etherscan performs source code verification based on runtime code, bytecode, or even both of them;**

[Blackbox Testing & Answer 1](test_contracts/test_runtime_bytecode/README.md)

**Q2. How Etherscan handles immutable variables in M3;**

[Blackbox Testing & Answer 2](test_contracts/test_immutable_var/README.md)

**Q3. How Etherscan flags metadata code, and whether it can handle multiple pieces of metadata code in M4;**

[Blackbox Testing & Answer 3](test_contracts/test_metadata/README.md)

**Q4. Does Etherscan require users to provide specific values for constructor parameters in M4;**

[Blackbox Testing & Answer 4](test_contracts/test_constructor_parameter/README.md)

**Q5. What database does Etherscan use to store source code verification results in M5;**

We didn't find any indication in the documentation that `Etherscan` uses decentralized storage.

**Q6. Does Etherscan have shortcut**

Based on [0xb1405..](https://testnet.bscscan.com/address/0xb1405fa4b94b294b3762ded285a758af1d0ca89e#code) contract, we confirmed the existence of a shortcut for the same runtime code in Etherscan.




## Acknowledgements
Many thanks to Sourcify and to Blockscout for their fantastic open source work. Without them, we wouldn't have been able to get an open source, trusted source code verification service. We were very very impressed by their responsible and professional technical skills in our interaction with them. We were also blown away by the speed with which they fixed the problem, all within 12 hours of our report. Thanks very very much to the help of related security expert samczsun, who made our research more fulfilling.
