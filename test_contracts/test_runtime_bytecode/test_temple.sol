contract A{
    constructor() public payable{
        bytes memory bytecode = hex'60806040';
        assembly {
            return (add(bytecode, 0x20), mload(bytecode))
        }
    }
}