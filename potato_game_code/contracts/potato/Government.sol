pragma solidity ^0.6.0;

import "@openzeppelin/contracts/math/SafeMath.sol";
import "./PotatoERC20.sol";
import "./PotatoERC721.sol";



/// @title Government
contract Government {
    enum Resources {
      POTATOES,
      CORN,
      CHEESE
    }
    uint public NUMRESOURCES = 3;

    using SafeMath for uint256;

    event Potato();


    // token addresses
    PotatoERC20[] public resourcesC = new PotatoERC20[](NUMRESOURCES);
    PotatoERC20 public potatoC;
    PotatoERC20 public voiceC;
    PotatoERC20 public debtC; // debt is not actually fungible. The collataral situation is also not so clear.
    PotatoERC721 public landC;
    PotatoERC721 public animalC;


    ///////////////////////////////
    // SETUP
    ///////////////////////////////
    constructor() public {
      DELETE_test_ctor();
      //createResourcesAndAssets();
    }

    // TODO add modifiers so it can only be called once with setup account
    // need to set up special permission for deployment transactions (to split out gas cost)
    // creates all token contracts
    function createResourcesAndAssets() public {
      emit Potato();
      // setup resources
      for(uint i = 0; i < NUMRESOURCES; ++i) {
        resourcesC[i] = new PotatoERC20(address(this));
      }
      // setup special resources
      potatoC = resourcesC[0];
      voiceC = new PotatoERC20(address(this));
      debtC = new PotatoERC20(address(this));
      // setup assets
      landC = new PotatoERC721(address(this));
      animalC = new PotatoERC721(address(this));
    }


    ///////////////////////////////
    // ASSET taxation
    ///////////////////////////////


    ///////////////////////////////
    // CALLBACKS for PotatoERC20
    ///////////////////////////////

    /// @param resource - the token address of the resource to be transfered
    /// @param msgSender - the contract attempting to transfer
    /// @return - authorized or not
    function isAuthorizedForTransfer(address resource, address msgSender) public pure returns (bool) {
      return true;
    }

    /// @param resource - the token address of the resource to be transfered
    /// @return - allowed or not
    function allowOutsideResourceTransfer(address resource) public pure returns (bool) {
      return true;
    }

    /// @param asset - the token address of the asset to be transfered
    /// @return - allowed or not
    function allowOutsideAssetTransfer(address asset) public pure returns (bool) {
      return false;
    }

    ///////////////////////////////
    // TESTING FUNCTION BELOW DELETE FOR PRODUCTION
    ///////////////////////////////

    PotatoERC20 public testToken;
    address public testAddress = address(0x12345);
    function DELETE_test_ctor() internal {
      testToken = new PotatoERC20(address(this));
    }

    function DELETE_test_mint() public returns (bool) {
      testToken.govMint(testAddress, 100);
      return true;
    }
}