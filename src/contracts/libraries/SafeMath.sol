// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

library SafeMath {

    // Build functions to perform safe math operations that would
    // otherwise replace intuitive preventative measure

    // Function add r = x + y
    function add(uint x, uint y) internal pure returns(uint) {
        uint r = x + y;
        require(r >= x, "SafeMath: Addition overflow");
        return r;
    }

    // Function subtract r = x - y
    function subtract(uint x, uint y) internal pure returns(uint) {
        uint r = x - y;
        require(y <= x, "SafeMath: Subtraction overflow");
        return r;
    }

    // Function multiply r = x * y
    function multiply(uint x, uint y) internal pure returns(uint) {
        // Gas optimization
        if(x == 0) return 0;
        uint r = x * y;
        require(r / x == y, "SafeMath: Multiplication overflow");
        return r;
    }

    // Function divide r = x / y
    function divide(uint x, uint y) internal pure returns(uint) {
        require(y > 0, "SafeMath: Division by zero");
        uint r = x / y;
        return r;
    }

    // Function modulo r = x % y
    function modulo(uint x, uint y) internal pure returns(uint) {
        require(y != 0, "SafeMath: Modulo by zero");
        uint r = x % y;
        return r;
    }

}