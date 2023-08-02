// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

///
///  ██████╗ ██████╗ ██╗███╗   ██╗
/// ██╔════╝██╔═══██╗██║████╗  ██║
/// ██║     ██║   ██║██║██╔██╗ ██║
/// ██║     ██║   ██║██║██║╚██╗██║
/// ╚██████╗╚██████╔╝██║██║ ╚████║
///  ╚═════╝ ╚═════╝ ╚═╝╚═╝  ╚═══╝
///
/// @title EVM INTRO - MyCoin
/// @author https://github.com/owieth/ (Olivier Winkler)
/// @notice EVM Intro Demo
/// @custom:security-contact abc@gmail.com
contract MyCoin is ERC20 {
    /*//////////////////////////////////////////////////////////////
                              CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor() ERC20("MyCoin", "MCK") {}

    /*//////////////////////////////////////////////////////////////
                                PUBLIC
    //////////////////////////////////////////////////////////////*/

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }
}
