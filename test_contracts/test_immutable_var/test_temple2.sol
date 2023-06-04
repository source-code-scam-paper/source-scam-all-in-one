contract B {}
contract A {
    bytes1 public immutable flag;
    constructor() public {
        bytes memory code = type(B).creationCode;
        flag = code[code.length-20]&0xaa;
    }
}
