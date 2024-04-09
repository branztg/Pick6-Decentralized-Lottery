// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {DeployPick3} from "../script/DeployPick3.s.sol";
import {Pick3} from "../src/Pick3.sol";

contract Pick3Test is Test {

    DeployPick3 deployer;
    Pick3 pick3;

    function setUp() external {
        deployer = new DeployPick3();
        pick3 = deployer.run();
    }

    function test_constructorInitializesCorrectValues() public view{
        assert(pick3.getEntranceFee1() == 1 ether);
        assert(pick3.getEntranceFee2() == 2 ether);
        assert(pick3.getEntranceFee3() == 3 ether);
    }
}