pragma solidity ^0.6.0;

library AnimalLib {
  struct AnimalData {
    bool isSet;
    string name;
    uint256 value;
    uint256 lastUpdate;
    uint256 lastTaxUpdate;
  }
}
