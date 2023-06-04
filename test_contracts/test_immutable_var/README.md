## Question 2
How `Etherscan` handles `immutable` variables in `M3`;
## Answer 2

In `Q1`, we already know that `Etherscan` needs to perform `runtime code` comparisons, which means that the handling of `immutable` variables is an unavoidable challenge for `Etherscan` to accomplish source code verification.

In order to further define `Etherscan`'s solution, we performed two types of verification to test our two conjectures.

### **Conjecture 1.** 
 Whether simulated execution is used by `Etherscan` to obtain full runtime code in the source code of contracts with immutable variables, just like `sourcifyV1`.

#### Method
In fact, in our answer to `Q1`, we can already confirm by the verification result of the [**EARLY RETURN**](../test_runtime_bytecode/test_temple.sol) that the normal contract's local `runtime code` is not obtained by simulated execution, but is taken from the compiler's runtime code result.

However, we need further confirmation that the same is true in contracts with `immutable` variables.

Here, we still have to rely on the **EARLY RETURN** contract, but since the compiler checks that all `immutable` variables are actually assigned values in the `constructor`, we cannot directly construct an **EARLY RETURN** contract with `immutable` variables that can be compiled correctly.

So here we take advantage of a small flaw in the compiler, which is to trick the compiler by using a permanent truth judgment statement.

Eventually we constructed the following contract, which has at least one `immutable` variables and we also implemented an **EARLY RETURN** in it.
```solidity
contract A{
    uint immutable public a;
    //This part is to bypass the compiler checking 
    //because the compiler does not allow the constructor's EARLY RETURN 
    //when there is an immutable, 
    //using this trick you can bypass the compiler checking.
    modifier trick {
        if(true){
            _;
        }
    }
    constructor() public payable trick {
        bytes memory bytecode = hex'60806040';
        assembly {
            return (add(bytecode, 0x20), mload(bytecode))
        }
        a = 123456789;
    }
}
```
#### Conclusion
In the end, `Etherscan` also gives a same error that the `runtime code` does not match the `eth_getcode`. This means that `Etherscan` does not use `simulation` to get the full `runtime code` in the presence of an `immutable` variables.

Based on this we confirmed that `Etherscan` uses the `runtime code` provided by the `compiler` and does not get them based on `simulated execution`. And it is very likely that `Etherscan` replaces the `immutable values` in the compiler's result for source code verification.


### **Conjecture 2.** 
Will the uninitialized `immutable` variables in the compilation result runtime code be replaced based on the `simulation` result?

#### Method
Although `Etherscan` doesn't use simulation to get the full `runtime code`, we're still curious if it uses `simulation` to get the replacement value for replacing the `immutable` values.

To do this, we designed the following contract, in which we assign `immutable` variables to a part of `metadata`, which means that it is almost impossible for `Etherscan` and our `compilations`  to keep the `immutable` value the same rely on `simulated execution`.  and because we only take a part of the `metadata` as the `immutable` variables , it means that the `immutable` variables also don't have the possibility to be labeled as a `metadata` either.

```solidity
contract B {}
contract A {
    bytes1 public immutable flag;
    constructor() public {
        bytes memory code = type(B).creationCode;
        flag = code[code.length-20];
    }
}

```
#### Conclusion

Eventually, such a contract still passes `Etherscan`'s source code verification, which means that `Etherscan` doesn't use `simulated execution` to get the replacement value in the `immutable` handling.

## Final Conclusion
We actually let the `immutable` have the same randomness as the `metadata` in the above example. However, `Etherscan` still passes the verification, which leads us to presume that Etherscan applies the same solution to `immutable` as well as `metadata`, i.e., it ignores the verification of `immutable` and defaults to the on chain code as the true value of `immutable`. 
This scheme can be viewed simply as replacing `immutable` variables with chained values.
