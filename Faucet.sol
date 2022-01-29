pragma solidity ^0.4.19;

// 测试币的发放

contract Faucet {
    function withdraw(uint withdraw_amount) public {
        require(withdraw_amount <= 100000000000000000);
        msg.sender.transfer(withdraw_amount); 
    }
    // funtion() public payable {}
}