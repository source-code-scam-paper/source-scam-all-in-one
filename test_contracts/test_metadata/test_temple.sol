contract C { }
contract B { }
contract A {
    function a() public{
        B b = new B();
        C c = new C();
    }
} 