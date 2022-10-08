pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
// import "@openzeppelin/contracts/access/Ownable.sol"; 
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol

contract YourContract {

  // getBalance (same function as getBalance below)
  mapping(address=>uint) public balance;

  // setBalance
  function deposit(address _addr, uint _total) public {
    balance[_addr] = _total;
  }

  // getBalance 
  function checkBalance(address _addr) public view returns (uint) {
    return balance[_addr];
  }

  // deleteBalance
  function deleteBalance(address _addr) public {
    delete balance[_addr];
  }

}
