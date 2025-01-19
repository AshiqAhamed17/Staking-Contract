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

    function testStakeUser() public {
        address ad = vm.addr(1);
        vm.prank(ad);
        vm.deal(ad, 4 ether);
        s.stake{value: 2 ether}();
        assertEq(ad.balance, 2 ether, "Incorrect Balance");
    }

    function testUnstake() public {
        address user = vm.addr(1);
        vm.deal(user, 1 ether);

        vm.startPrank(user);
        s.stake{value: 200}();
        s.unStake(100);
        vm.stopPrank();

        assert(s.balances(user) == 100);
    }


    function testFailUnstake() public {
        s.stake{value: 200}();
        s.unStake(300);
    }

}