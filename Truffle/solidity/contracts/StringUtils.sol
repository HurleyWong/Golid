pragma solidity >=0.5.0;

library StringUtils {

    function concat( string memory str, string memory a) internal pure returns (string memory) {
        return string(abi.encodePacked(str,a));
    }

    function concat( string memory str, address a) internal pure returns (string memory) {
        bytes memory b =abi.encodePacked(str, toString(a));
        return string(b);
    }

    function concat( string memory str, uint a) internal pure returns (string memory) {
        bytes memory b =abi.encodePacked(str, toString(a));
        return string(b);
    }

    function toString(address _addr) pure internal returns (string memory) {
        bytes32 value = bytes32(bytes20(uint160(_addr)));
        return toString(value, 20);
    }

    function toString(bytes32 b) pure internal returns (string memory) {
        return toString(b, 32);
    }

    function toString(bytes32 value, uint nbytes) pure internal returns(string memory) {
        bytes memory alphabet = "0123456789abcdef";

        bytes memory str = new bytes(nbytes*2+2);
        str[0] = '0';
        str[1] = 'x';
        for (uint i = 0; i < nbytes; i++) {
            uint8 chr = uint8(value[i]);
            str[2+i*2] = alphabet[uint(uint8(chr >> 4))];
            str[3+i*2] = alphabet[uint(uint8(chr & 0x0f))];
        }
        return string(str);
    }

    function toString(uint _i) internal pure returns (string memory _uintAsString) {
        if (_i == 0) {
            return "0";
        }
        uint j = _i;
        uint len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint k = len - 1;
        while (_i != 0) {
            bstr[k--] = byte(uint8(48 + _i % 10));
            _i /= 10;
        }
        return string(bstr);
    }

    function equal(string memory a, string memory b) internal pure returns (bool) {
        if (bytes(a).length != bytes(b).length) {
            return false;
        }
        else {
            return keccak256(bytes(a)) == keccak256(bytes(b));
        }
    }
}
