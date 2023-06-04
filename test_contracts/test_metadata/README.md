## Question 3
How `Etherscan` flags `metadata code`, and whether it can handle multiple pieces of `metadata code` in `M4`;
## Answer 3
### Method
In order to test `Etherscan`'s solution for identifying `metadata`, we took advantage of `factory` contracts to test `Etherscan`'s source code verification.
Specifically, we constructed a source code file which contains 3 non-adjacent `metadata` in its bytecode as shown below.
```solidity
contract C { }
contract B { }
contract A {
    function a() public{
        B b = new B();
        C c = new C();
    }
} 
```
Based on this source code, we deployed and verified the contract in different solidity versions. 
### Conclusion

Eventually, we found that `Etherscan` could not pass the source code verification of this factory contract in `0.4` solidity version, and accordingly, we came up with two speculative conclusions.

1. Etherscan adopts different `metadata` handling strategies in version `0.4` and other solidity versions.

2. Etherscan still uses pattern matching to identify `metadata` in version `0.4`, and adds the restriction of identifying the `metadata` only at the end of `bytecode`.