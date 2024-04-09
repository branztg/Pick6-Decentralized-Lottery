// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Script} from "forge-std/Script.sol";
import {Pick3} from "../src/Pick3.sol";

contract DeployPick3 is Script {
    function run() external returns (Pick3) {
        Pick3 pick3 = new Pick3(1 ether,2 ether,3 ether);
        return pick3;
    }
}