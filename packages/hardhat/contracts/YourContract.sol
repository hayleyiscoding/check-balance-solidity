pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";

// import "@openzeppelin/contracts/access/Ownable.sol";
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol

contract YourContract {
    address public owner = 0x623bb5f303cb3285F24c2f16d5E456699DA28489;
    uint256 public totalAmount;
    uint256 public constant FEE = 12;
    error AmountTooSmall(uint256 _amount);

    constructor() {
        owner = msg.sender;
    }

    struct User {
        string name;
        uint256 age;
    }

    mapping(address => User) public users;

    // push user details into struct - this function accepts 2 arguments that represent the details of the user calling the smart contract and it saves them into a defined struct
    function setUserDetails(string calldata _name, uint256 _age) public {
        users[msg.sender] = (User(_name, _age));
    }

    // this function retrieves and returns the details saved for the user calling the contract.
    // I am not sure how to create this function without passing the address as a parameter? It seems I cannot use 'msg.sender' in a view function? Please advise. Thank you.
    function getUserDetails(address _addr) public view returns (User memory) {
        return users[_addr];
    }

    // getBalance (same function as getBalance below)
    mapping(address => uint256) public balance;

    // setBalance - is this correct? I edited it based on the feedback from the last task.
    function deposit(uint256 _amount) public {
        uint256 prevUserBal = balance[msg.sender];
        balance[msg.sender] = prevUserBal + _amount;
        totalAmount += _amount;
    }

    // getBalance - I am not sure how to create this function without passing the address as a parameter? It seems I cannot use 'msg.sender' in a view function? Please advise. Thank you.
    function checkBalance(address _addr) public view returns (uint256) {
        return balance[_addr];
    }

    // deleteBalance
    // function deleteBalance() public {
    //     delete balance[msg.sender];
    // }

    modifier onlyOwner() {
        require(msg.sender == owner, "NOT AUTHORISED");
        _;
    }

    modifier hasDeposited(address user) {
        uint256 userBalance = balance[user];
        require(userBalance > 0, "not deposited");
        _;
    }

    modifier isEnough(uint256 _amount) {
        if (_amount < FEE) {
            revert AmountTooSmall(_amount);
        }
        _;
    }

    // withdraw function
    function withdraw() public onlyOwner {
        //  Withdraw funds
    }

    // addFunds
    function addFund(uint256 _amount)
        public
        hasDeposited(msg.sender)
        isEnough(_amount)
    {
        balance[msg.sender] += _amount;
        totalAmount += _amount;
    }
}
