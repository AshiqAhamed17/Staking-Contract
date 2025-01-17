// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import { Staking } from "../src/Staking.sol";

contract StakingTest is Test {
    Staking public s;

    function setUp() public {
        s = new Staking();
    }
    
    function testStake() public {
        s.stake{value: 100}();
        assertEq(s.balances(address(this)), 100);
    }

    function testUnstake() public {
        s.stake{value: 200}();
        s.unStake(100);
        assertEq(s.balances(address(this)), 100);
    }

}