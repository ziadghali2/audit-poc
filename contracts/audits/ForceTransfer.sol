// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract Balance
{
    function getBalance() public view returns (uint){
        return address(this).balance;
    }
    
    fallback() external payable {
        revert();
    }

    receive() external payable {
        // Handle incoming Ether here
    }
}

contract ForceTransfer{
    address payable toTransfer;

    function getBalance() public view returns (uint){
        return address(this).balance;
    }
    
    function payToContract() public payable{
    }
    
    constructor(address _address) {
        toTransfer = payable(_address);
    }
    
    function kill() public {
        selfdestruct(toTransfer);
    }

    fallback() external payable {
        revert();
    }

    receive() external payable {
        // Handle incoming Ether here
        revert();
    }
}

