// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

///
/// ███████╗██╗  ██╗ ██████╗██╗  ██╗ █████╗ ███╗   ██╗ ██████╗ ███████╗
/// ██╔════╝╚██╗██╔╝██╔════╝██║  ██║██╔══██╗████╗  ██║██╔════╝ ██╔════╝
/// █████╗   ╚███╔╝ ██║     ███████║███████║██╔██╗ ██║██║  ███╗█████╗  
/// ██╔══╝   ██╔██╗ ██║     ██╔══██║██╔══██║██║╚██╗██║██║   ██║██╔══╝  
/// ███████╗██╔╝ ██╗╚██████╗██║  ██║██║  ██║██║ ╚████║╚██████╔╝███████╗
/// ╚══════╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝
///
/// @title EVM INTRO - Exchange
/// @author https://github.com/owieth/ (Olivier Winkler)
/// @notice EVM Intro Demo
/// @custom:security-contact abc@gmail.com
contract Exchange {

    /*//////////////////////////////////////////////////////////////
                                ERRORS
    //////////////////////////////////////////////////////////////*/

    error Exchange_InvalidAmount(uint256 _amount);
    error Exchange_InvalidBalance(IERC20 _asset);

    /*//////////////////////////////////////////////////////////////
                                 STORAGE
    //////////////////////////////////////////////////////////////*/

    mapping(IERC20 _token => mapping(address _holder => uint256 _amount)) s_balances;

    /*//////////////////////////////////////////////////////////////
                                EVENTS
    //////////////////////////////////////////////////////////////*/

    event Deposit(address _sender, address _receiver, IERC20 _token, uint256 _amount);

    event Withdraw(address _sender, address _receiver, IERC20 _token, uint256 _amount);

    /*//////////////////////////////////////////////////////////////
                              CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor() {}

    /*//////////////////////////////////////////////////////////////
                                EXTERNAL
    //////////////////////////////////////////////////////////////*/

    function depositToken(IERC20 _asset, uint256 _amount) external {
        uint256 balanceUser = _asset.balanceOf(msg.sender);

        if (balanceUser <= 0) {
            revert Exchange_InvalidBalance(_asset);
        }

        if (_amount <= 0 || _amount > balanceUser) {
            revert Exchange_InvalidAmount(_amount);
        }

        _asset.transferFrom(msg.sender, address(this), _amount);

        s_balances[_asset][msg.sender] += _amount; 

        emit Deposit(msg.sender, address(this), _asset, _amount);
    }

    function withdrawToken(IERC20 _asset, uint256 _amount) external {
        uint256 balanceExchange = _asset.balanceOf(address(this));

        if (balanceExchange <= 0) {
            revert Exchange_InvalidBalance(_asset);
        }

        if (_amount <= 0 || _amount > balanceExchange) {
            revert Exchange_InvalidAmount(_amount);
        }

        _asset.approve(address(this), _amount);

        _asset.transferFrom(address(this), msg.sender, _amount);

        s_balances[_asset][msg.sender] -= _amount; 

        emit Withdraw(msg.sender, address(this), _asset, _amount);
    }

    /*//////////////////////////////////////////////////////////////
                                PUBLIC
    //////////////////////////////////////////////////////////////*/

    function getUserBalance(IERC20 _asset) public view returns (uint256) {
        return s_balances[_asset][msg.sender];
    }

    /*//////////////////////////////////////////////////////////////
                                INTERNAL
    //////////////////////////////////////////////////////////////*/

    function _getInternalFunction() internal {}

    /*//////////////////////////////////////////////////////////////
                                PRIVATE
    //////////////////////////////////////////////////////////////*/

    function _getPrivateFunction() private {}
}
