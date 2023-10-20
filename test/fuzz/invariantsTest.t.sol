// SPDX-License-Identifier: MIT License
pragma solidity ^0.8.18;

// 1. Total supply of DSC should be less than total value of collateral

// 2. Getter view functions should never revert

import {Test} from "forge-std/Test.sol";
import {StdInvariant} from "forge-std/StdInvariant.sol";
import {DSCEngine} from "../../src/DSCEngine.sol";
import {DecentralizedStableCoin} from "../../src/DecentralizedStableCoin.sol";
import {DeployDsc} from "../../script/DeployDsc.s.sol";
import {HelperConfig} from "../../script/HelperConfig.s.sol";

contract InvariantsTest is StdInvariant, Test {
    DeployDsc deployer;
    DSCEngine dsce;
    DecentralizedStableCoin dsc;
    HelperConfig config;

    function setUp() external {
        deployer = new DeployDsc();
        (dsc, dsce, config) = deployer.run();
        targetContract(address(dsce));
    }
}
