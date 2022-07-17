// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

library Utils {
    function stringsEquals(string memory s1, string memory s2)
        public
        pure
        returns (bool)
    {
        bytes memory b1 = bytes(s1);
        bytes memory b2 = bytes(s2);
        uint256 l1 = b1.length;
        if (l1 != b2.length) return false;
        for (uint256 i = 0; i < l1; i++) {
            if (b1[i] != b2[i]) return false;
        }
        return true;
    }
}
