// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "@aave/core-v3/contracts/flashloan/base/FlashLoanSimpleReceiverBase.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract PrintMoney is FlashLoanSimpleReceiverBase, Ownable {
    constructor(IPoolAddressesProvider _lendingPool)
        FlashLoanSimpleReceiverBase(_lendingPool)
    {}

    function executeOperation(
        address asset,
        uint256 amount,
        uint256 premium,
        address initiator,
        bytes calldata params
    ) external override returns (bool) {
        //
        // This contract now has the funds requested.
        // Your logic goes here.
        //

        // At the end of your logic above, this contract owes
        // the flashloaned amounts + premiums.
        // Therefore ensure your contract has enough to repay
        // these amounts.

        // Approve the LendingPool contract allowance to *pull* the owed amount

        uint256 amountOwing = SafeMath.add(amount, premium);
        IERC20(asset).approve(address(ADDRESSES_PROVIDER), amountOwing);

        return true;
    }

    function _flashloan(address assets, uint256 amounts)
        internal
    {
        address recieverAddress = address(this);
        bytes memory params = "";
        uint16 referralCode = 0;

        POOL.flashLoanSimple(
            recieverAddress,
            assets,
            amounts,
            params,
            referralCode
        );
    }

    /*
     *  Flash loan 100000000000000000 wei (0.1 ether) worth of `_asset`
     */
    function brrr(address _asset) public onlyOwner {
        uint256 amount = 0.1 ether;

        _flashloan(_asset, amount);
    }
}
