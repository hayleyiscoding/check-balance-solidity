pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
// import "@openzeppelin/contracts/access/Ownable.sol"; 
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol

contract YourContract {

  struct User {
    string name;
    uint256 age;
  }

  mapping(address=>User) public users;

  // push user details into struct - this function accepts 2 arguments that represent the details of the user calling the smart contract and it saves them into a defined struct
  function setUserDetails (string calldata _name, uint256 _age) public {
    users[msg.sender] = (User(_name, _age));
  }


  // this function retrieves and returns the details saved for the user calling the contract.
  // I am not sure how to create this function without passing the address as a parameter? It seems I cannot use 'msg.sender' in a view function? Please advise. Thank you.
  function getUserDetails(address _addr) public view returns (User memory){
    return users[_addr];
  }
 
  // getBalance (same function as getBalance below)
  mapping(address=>uint256) public balance;

  // setBalance - is this correct? I edited it based on the feedback from the last task.
  function deposit(uint256 _amount) public {
    uint256 prevUserBal = balance[msg.sender];
    balance[msg.sender] = prevUserBal + _amount;
  }

  // getBalance - I am not sure how to create this function without passing the address as a parameter? It seems I cannot use 'msg.sender' in a view function? Please advise. Thank you.
  function checkBalance(address _addr) public view returns (uint256) {
    return balance[_addr];
  } 


  // deleteBalance 
  function deleteBalance() public {
    delete balance[msg.sender];
  }

}
