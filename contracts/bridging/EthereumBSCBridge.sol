// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";

contract EthereumBSCBridge { // I can send money from this bridge to specific token address which interface is `IERC20`

    address public owner;
    IERC20 public token;

    event Transfer(address indexed from, address indexed to, uint256 amount);


    constructor(address _tokenAddress) {
        owner = msg.sender;
        token = IERC20(_tokenAddress);
    }

    function deposit(uint256 _amount) external {
        require(token.transferFrom(msg.sender, address(this), _amount), "Transfer failed");
        emit Transfer(msg.sender, address(this), _amount);
    }

    function withdraw(address _to, uint256 _amount) external {
        require(msg.sender == owner, "Only owner can withdraw");
        require(token.transfer(_to, _amount), "Transfer failed");
        emit Transfer(address(this), _to, _amount);
    }

}

// similar contract for another blockchain
contract BSCBridge is EthereumBSCBridge {

     constructor(address _tokenAddress) EthereumBSCBridge (_tokenAddress) { }
}

contract caller {

    // Both bridges should have token with same interface `IERC20` example: (ERC20 and BEP20) 
    // in shared bockchain example: Ethereum Blockchain

    function callConstract() public {
        // just test override is works
        BSCBridge bridge = new BSCBridge(address(this));
        bridge.deposit(100);
    }
}