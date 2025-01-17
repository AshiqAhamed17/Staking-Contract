// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract AshCoin is ERC20, Ownable {
    
    address public stakingAddress;

    constructor(address _stakingAddress) ERC20("AshCoin", "ASH") Ownable(msg.sender) {
        stakingAddress = _stakingAddress;
    }

    modifier onlyContract() {
        require(msg.sender == stakingAddress, "Only contract");
        _;
    }

    function mint(address _to, uint _amount) public  onlyContract {
        _mint(_to, _amount);
    }

    function updateContract(address newContract) public onlyContract {
        stakingAddress = newContract;
    }
}