// SPDX-License-Identifier: MIT License
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployDsc} from "../../script/DeployDsc.s.sol";
import {DecentralizedStableCoin} from "../../src/DecentralizedStableCoin.sol";
import {DSCEngine} from "../../src/DSCEngine.sol";
import {HelperConfig} from "../../script/HelperConfig.s.sol";
import {ERC20Mock} from "@openzeppelin/contracts/mocks/ERC20Mock.sol";

contract DSCEngineTest is Test {
    DeployDsc deployer;
    DecentralizedStableCoin dsc;
    DSCEngine dsce;
    HelperConfig config;
    address ethUsdPricefeed;
    address weth;

    address public USER = makeAddr("user");
    uint256 public constant AMOUNT_COLLATERAL = 10 ether;

    function setUp() public {
        deployer = new DeployDsc();

        (dsc, dsce, config) = deployer.run();
        (ethUsdPricefeed,, weth,,) = config.activeNetworkConfig();
    }

    /**
     * ------------------- Price Tests ----------------------
     */
    function testGetUsdValue() public {
        uint256 ethAmount = 15e18;
        uint256 expectedUsdVal = 30000e18;

        uint256 actualUsdVal = dsce.getUsdValue(weth, ethAmount);
        assertEq(actualUsdVal, expectedUsdVal);
    }

    /**
     * ------------------- Deposit Collateral Tests ----------------------
     */
    function testRevertsIfCollateralZero() public {
        vm.startPrank(USER);
        ERC20Mock(weth).approve(address(dsce), AMOUNT_COLLATERAL);
        vm.expectRevert(DSCEngine.DSCEngine__NeedsMoreThanZero.selector);
        dsce.depositCollateral(weth, 0);
    }
}
