//SPDX-License-Identifier: MIT

pragma solidity 0.8.7;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "../.deps/github/OpenZeppelin/openzeppelin-contracts/contracts/access/Ownable.sol";

contract Allowance is Ownable {
    event AllowanceChanged(address indexed _forWho, address indexed _fromWhom, uint _oldAmount, uint _newAmount);
    mapping(address => uint) public allowance;

    function addAllowance(address _who, uint _amount) public onlyOwner {
        emit AllowanceChanged(_who, msg.sender, _allowance[_who], _amount);
        allowance[_who] = _amount;
    }

    modifier ownerOrAllowed(uint _amount) {
        require(isOwner() || allowance[msg.sender] >= _amount, "You are not allowed");
        _;
    }

    function reduceAllowance(address _who, uint amount) internal {
        emit AllowanceChanged(_who, msg.sender, _allowance[_who], _allowance[_who] - _amount);
        allowance[_who] -= _amount;
    }
}

contract SharedWallet is Allowance {

    function withdrawMoney(address payable _to, uint _amount) public ownerOrAllowed(_amount) {
        require (_amount <= address(this).balance, "There are not enough funds stored in the smart contract");
        if(!isOwner()) {
            reduceAllowance(msg.sender, _amount);
        }
        _to.transfer(_amount);
    }

    receive() external payable {

    }
}
