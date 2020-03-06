import "./PotatoLibrary.sol";

contract PotatoTesting {
  PotatoLibrary.Data potatoLibraryData;
  mapping(address => MyNumber) public mStore;
  struct MyNumber {
    int num;
  }
  MyNumber myNumber;
  // this won't work sadly
  //function setSomeNumber(MyNumber storage myNum, int newNum) {
  //  myNum.num = newNum;
  //}
  function store(int num) public payable {
    // test storage stuff
    MyNumber storage storeNum = mStore[msg.sender];
    storeNum.num = num;

    // test more storage stuff
    //setSomeNumber(myNumber, num);
    MyNumber storage myNum = myNumber;
    myNum.num = num;

    // test library stuff
    PotatoLibrary.setValue(potatoLibraryData, num);
    PotatoLibrary.setBalance(potatoLibraryData);
  }
  function retrieve() public view returns (int,int,int,uint) {
    int r0 = myNumber.num;
    int r1 = mStore[msg.sender].num;
    int r2 = PotatoLibrary.getValue(potatoLibraryData);
    uint r3 = PotatoLibrary.getBalance(potatoLibraryData);
    return (r0, r1, r2, r3);
  }

  function getSender() public view returns (address) {
    return msg.sender;
  }
  function getSenderFromPotatoLibrary() public view returns (address) {
    return PotatoLibrary.getSender();
  }

}