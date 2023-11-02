//SPDX-License-Identifier: MIT

pragma solidity 0.8.7;

import "./Allowance.sol";

contract SharedWallet is Allowance {

    event MoneySent(address indexed _beneficiary, uint _amount);
    event MoneyReceived(address indexed _from, uint _amount);

    function withdrawMoney(address payable _to, uint _amount) public ownerOrAllowed(_amount) {
        require (_amount <= address(this).balance, "There are not enough funds stored in the smart contract");
        if(owner() != _msgSender()) {
            reduceAllowance(msg.sender, _amount);
        }
        emit MoneySent(_to, _amount);
        _to.transfer(_amount);
    }

    function renounceOwnership() override public virtual onlyOwner {
        revert("Can't renounce ownership here");
    }

    receive() external payable {
        emit MoneyReceived(msg.sender, msg.value);
    }
}
