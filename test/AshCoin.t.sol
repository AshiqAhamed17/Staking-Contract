// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import { AshCoin } from "../src/AshCoin.sol";

contract AshCoinTest is Test {
    AshCoin public a;

    function setUp() public {
        a = new AshCoin(address(this));
    }

function testInitialSupply() public view {
    assertEq(a.totalSupply(), 0, "Total supply should be 0");
}

    function testMint() public {
        uint amount = 100;
        a.mint(address(this), amount);
        assertEq(a.balanceOf(address(this)), amount, "Mint failed");
        assertEq(a.totalSupply(), amount, "Total supply should be 100");
    }

    function testFailMint() public {
        address ad = vm.addr(1);
        vm.prank(ad);
        a.mint(ad, 100);
    }

    function testUpdateStakingContract() public {
        address ad = vm.addr(1);
        a.updateContract(ad);
        vm.prank(ad);
        a.mint(ad, 100);
        assertEq(a.balanceOf(ad), 100, "Balance should be 100");
        assertEq(a.totalSupply(), 100, "Total supply should be 100");
    }




}