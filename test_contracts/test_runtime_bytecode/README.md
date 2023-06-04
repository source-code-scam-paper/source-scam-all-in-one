## Question 1
Whether Etherscan performs source code verification based on `runtime code`, `bytecode`, or even both of them;
## Answer 1

### Method

To test this, we deployed and verified the **EARLY RETURN** contract in the `constructor` under different solidity versions. As shown the **EARLY RETURN** contract below, the contract will return a completely different `runtime code` in the `constructor` from its `runtime code` in compile result, which means that the `runtime code` in the compile result of the contract will not be the same as its `deployed runtime code`.
```solidity
contract A{
    constructor() public payable{
        bytes memory bytecode = hex'60806040';
        assembly {
            return (add(bytecode, 0x20), mload(bytecode))
        }
    }
}
```
### Conclusion
In practice, we found that `Etherscan` gives an error that `eth_getcode` does not match the `runtime code` when verifying the above contract.From this we can confirm that `Etherscan` performs runtime code checking.

For bytecode, it's much easier to test. We just give a mismatched source code to verify and get a bytecode `mismatch error`.

Based on the above error feedback, we can tell that `Etherscan` performs both `bytecode` and `runtime code` checks.
