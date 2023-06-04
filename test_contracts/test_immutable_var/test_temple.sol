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