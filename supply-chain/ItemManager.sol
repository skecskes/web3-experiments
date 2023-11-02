pragma solidity ^0.8.7;

contract ItemManager {

    // @param enum represents uint 0,1,2
    enum SupplyChainState{Created, Paid, Delivered}

    struct S_Item {
        string _identifier;
        uint _itemPrice;
        ItemManager.SupplyChainState _state;
    }

    mapping(uint =>  S_Item) public items;
    uint itemIndex;

    event SupplyChainStep(uint _itemIndex, uint _step);

    function createItem(string memory _identifier, uint _itemPrice) public {
        items[itemIndex]._identifier = _identifier;
        items[itemIndex]._itemPrice = _itemPrice;
        items[itemIndex]._state = SupplyChainState.Created;
        emit SupplyChainStep(itemIndex, uint(SupplyChainState.Created));
        itemIndex++;
    }

    function triggerPayment(uint _itemIndex) public payable {
        require(items[_itemIndex]._itemPrice == msg.value, "Only full payments accepted");
        require(items[_itemIndex]._state == SupplyChainState.Created, "Item is further in the chain");
        items[_itemIndex]._state = SupplyChainState.Paid;
        emit SupplyChainStep(_itemIndex, uint(SupplyChainState.Paid));
    }

    function triggerDelivery(uint _itemIndex) public {
        require(items[_itemIndex]._state == SupplyChainState.Paid, "Item is further in the chain");
        items[_itemIndex]._state = SupplyChainState.Delivered;
        emit SupplyChainStep(_itemIndex, uint(SupplyChainState.Delivered));
    }
}