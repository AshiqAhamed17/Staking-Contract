// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "forge-std/Test.sol";
import { AshCoin } from "../src/AshCoin.sol";

contract Staking {
    mapping(address => uint) public balances;
    mapping(address => uint) public unClaimedRewards;
    mapping(address => uint) public lastUpdateTime;

    constructor() {}

    receive() external payable {}

    function stake() public  payable {
        require(msg.value > 0);

        if(lastUpdateTime[msg.sender] == 0) {
            lastUpdateTime[msg.sender] = block.timestamp;
        }
        else{
            unClaimedRewards[msg.sender] = (block.timestamp - lastUpdateTime[msg.sender]) * balances[msg.sender];
            lastUpdateTime[msg.sender] = block.timestamp;
        }
        balances[msg.sender] += msg.value;
    }

    function unStake(uint _amount) public {
        require(balances[msg.sender] >= _amount);

        unClaimedRewards[msg.sender] = (block.timestamp - lastUpdateTime[msg.sender]) * balances[msg.sender];
        lastUpdateTime[msg.sender] = block.timestamp;

        payable(msg.sender).transfer(_amount);
        balances[msg.sender] -= _amount;
    }

    function getRewards(address _addr) public view returns(uint) {
        uint currentReward = unClaimedRewards[_addr];
        uint updateTime = lastUpdateTime[_addr];
        uint newReward = (block.timestamp - updateTime) * balances[_addr];
        return (currentReward + newReward);


    }

    function claimRewards() public {
        //uint currentReward = unClaimedRewards[msg.sender];
        //uint updateTime = lastUpdateTime[msg.sender];
       // uint newReward = (block.timestamp - updateTime) * balances[msg.sender];

        // For Miniting Tokens

        unClaimedRewards[msg.sender] = 0;
        lastUpdateTime[msg.sender] = block.timestamp;
    }
    
    function balanceOf(address _address) public view returns (uint) {
        return balances[_address];
    }




}
    