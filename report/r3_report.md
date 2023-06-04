# The `start_with` flaw causes arbitrary source code validation

## Introduction
The bytecode comparison during the Creation Code comparison is done using start_with, which is intended to support source code verification in the presence of constructor arguments.

However, source code validation by strat_with alone without validation of constructor arguments may lead to risks.

Specifically, we can build a contract source code without compilation results with the help of abstract and interface contracts, which means that such a source code can pass the start_with check of any contract bytecode.
Impact
This vulnerability can lead to arbitrary source code verification, and an attacker only needs to use an abstract contract to verify any contract source code.
## Attack Case
https://github.com/Hellobloc/verify/tree/test_start_with
https://repo.staging.sourcify.dev/contracts/partial_match/5/0x5ea1E75790b86C4c5Db5e7c7A1fa14d683D50Cfe/sources/contracts

## Related issue code
https://github.com/ethereum/sourcify/blob/1ef0e73edf4efec5c4a1baa7276a061d97cafc9e/packages/lib-sourcify/src/lib/verification.ts#L280-L287

## Implementations that can be used for reference
https://github.com/blockscout/blockscout-rs/blob/main/smart-contract-verifier/smart-contract-verifier/src/verifier/all_metadata_extracting_verifier.rs#L321-L340
