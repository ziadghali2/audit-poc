// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract EtherStore {
    
    uint256 public withdrawLimit = 1 ether;
    mapping (address => uint256) public lastWithdrawTime;
    mapping (address => uint256) public balances;


    function depositFunds() public payable {
        // assign to balance from msg.value
        balances[msg.sender] += msg.value;
    }

    function withdrawFunds(uint256 _weiToWithdraw) public {
        // take from spsfice balance by _weiToWithdraw
        require(balances[msg.sender] >= _weiToWithdraw);
        require(_weiToWithdraw <= withdrawLimit);
        require(block.timestamp >= lastWithdrawTime[msg.sender] + 1 weeks);
        payable(msg.sender);
        balances[msg.sender] -= _weiToWithdraw;
        lastWithdrawTime[msg.sender] = block.timestamp;
    }

}