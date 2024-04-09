//Layout contract elements in the following order:
//
//Pragma statements
//
//Import statements
//
//Interfaces
//
//Libraries
//
//Contracts
//
//Inside each contract, library or interface, use the following order:
//
//Type declarations
//
//State variables
//
//Events
//
//Errors
//
//Modifiers
//
//Functions


//SPDX-License-Identifier: MIT

pragma solidity 0.8.20;



/**
    * @title Pick3
    * @dev Allows users to pick 3 numbers and win if they match the randomly selected numbers.
    * @author branztg
    * @notice Numbers drawn are done by Chainlink VRF.
*/
contract Pick3 {

    /**
     * ╔═════════════════════════════════╗
     * ║         State Variables         ║
     * ╚═════════════════════════════════╝
     *
     */

    // Entrance fees for each tier from cheap to expensive
    uint256 private immutable entranceFee1;
    uint256 private immutable entranceFee2;
    uint256 private immutable entranceFee3;

    // Mapping of player to their ticket tier and to their lottery picks
    mapping(address player => mapping(uint256 ticket => uint256[] picks)) private s_playerTicketTierAndPicks;

    // Group of Players categorized by tier of ticket purchased
    address[] private s_Tier1Players;
    address[] private s_Tier2Players;
    address[] private s_Tier3Players;

    // Group of Winners categorized by tier of ticket purchased
    address[] private s_Tier1Winners;
    address[] private s_Tier2Winners;
    address[] private s_Tier3Winners;

    /**
     * ╔═════════════════════════════════╗
     * ║         Errors                  ║
     * ╚═════════════════════════════════╝
     *
     */

    error Pick3Lottery__ConstructorPriceError();
    error Pick3Lottery__InvalidEntranceFee(uint256 entranceFee);
    error Pick3Lottery__InvalidPick(uint256[] picks);


    /**
     * ╔═════════════════════════════════╗
     * ║         Constructor             ║
     * ╚═════════════════════════════════╝
     *
     * Overview:
     * This function performs some awesome tasks.
     *
     * @param _entranceFee1 Cheapest ticket price
     * @param _entranceFee2 Middle ticket price
     * @param _entranceFee3 Most expensive ticket price
     */


    constructor(uint256 _entranceFee1, uint256 _entranceFee2, uint256 _entranceFee3) {
        if (_entranceFee1 >= _entranceFee2 || _entranceFee2 >= _entranceFee3) {
            revert Pick3Lottery__ConstructorPriceError();
        }
        entranceFee1 = _entranceFee1;
        entranceFee2 = _entranceFee2;
        entranceFee3 = _entranceFee3;
    }

    /**
     * ╔═════════════════════════════════╗
     * ║         Enter Lottery           ║
     * ╚═════════════════════════════════╝
     * @param _picks 3 numbers chosen by player
     *
     */

    function enterLottery(uint256[] memory _picks) external payable {

        // Validate picks and entrance fee ticket tier of player
        if (_picks.length != 3) {
            revert Pick3Lottery__InvalidPick(_picks);
        } else if (msg.value == entranceFee1) {
            s_Tier1Players.push(msg.sender);
        } else if (msg.value == entranceFee2) {
            s_Tier2Players.push(msg.sender);
        } else if (msg.value == entranceFee3) {
            s_Tier3Players.push(msg.sender);
        } else {
            revert Pick3Lottery__InvalidEntranceFee(msg.value);
        }

        // Store player picks
        s_playerTicketTierAndPicks[msg.sender][msg.value] = _picks;
    }








    /**
     * ╔═════════════════════════════════╗
     * ║         Getter Functions        ║
     * ╚═════════════════════════════════╝
     *
     */

    function getEntranceFee1() external view returns (uint256) {
        return entranceFee1;
    }

    function getEntranceFee2() external view returns (uint256) {
        return entranceFee2;
    }

    function getEntranceFee3() external view returns (uint256) {
        return entranceFee3;
    }

    function getPlayerPicks(address _player, uint256 _ticket) external view returns (uint256[] memory) {
        return s_playerTicketTierAndPicks[_player][_ticket];
    }


}













