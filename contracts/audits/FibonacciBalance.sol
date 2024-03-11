// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract FibonacciBalance {

    address public fibonacciLibrary;
    // the current fibonacci number to withdraw
    uint public calculatedFibNumber;
    // the starting fibonacci sequence number
    uint public start = 3;
    uint public withdrawalCounter;
    // the fibonancci function selector
    bytes4 constant fibSig = bytes4(keccak256("setFibonacci(uint256)"));

    // constructor - loads the contract with ether
    constructor(address _fibonacciLibrary) payable {
        fibonacciLibrary = _fibonacciLibrary;
    }

    function withdraw() public {
        withdrawalCounter += 1;
        // calculate the fibonacci number for the current withdrawal user
        (bool success, ) = fibonacciLibrary.delegatecall(abi.encodeWithSignature("setFibonacci(uint256)", withdrawalCounter));
        require(success, "delegate call failed");

        payable(address(msg.sender)).transfer(calculatedFibNumber * 1 ether);
    }

    // allow users to call fibonacci library functions
    fallback() external payable {
        (bool success, ) = fibonacciLibrary.delegatecall(msg.data);
        require(success, "delegate call failed");
    }

    receive() external payable { }
}
