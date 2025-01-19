// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "forge-std/Test.sol";
import "src/AshCoin.sol";

contract Staking {
    mapping(address => uint) public balances;
    mapping(address => uint) public unClaimedRewards;
    mapping(address => uint) public lastUpdated;

    constructor() {}

    receive() external payable {}

    function stake() public  payable {
        require(msg.value > 0);
        balances[msg.sender] += msg.value;
    }

    function unStake(uint _amount) public {
        require(balances[msg.sender] >= _amount);
        payable(msg.sender).transfer(_amount);
        balances[msg.sender] -= _amount;
    }

    function getRewards() public {

    }

    function claimRewards() public {

    }
    
    function balanceOf(address _address) public view returns (uint) {
        return balances[_address];
    }




}
    