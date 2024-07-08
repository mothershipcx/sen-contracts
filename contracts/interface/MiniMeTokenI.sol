pragma solidity ^0.4.18;

import "./ERC20Token.sol";
import "./Burnable.sol";


/// @dev MiniMeToken interface. Using this interface instead of whole contracts
///  will reduce contract size and gas cost
contract MiniMeTokenI is ERC20Token, Burnable {

  string public name;                //The Token's name: e.g. DigixDAO Tokens
  uint8 public decimals;             //Number of decimals of the smallest unit
  string public symbol;              //An identifier: e.g. REP
  string public version = "MMT_0.1"; //An arbitrary versioning scheme

///////////////////
// ERC20 Methods
///////////////////

  /// @notice `msg.sender` approves `_spender` to send `_amount` tokens on
  ///  its behalf, and then a function is triggered in the contract that is
  ///  being approved, `_spender`. This allows users to use their tokens to
  ///  interact with contracts in one function call instead of two
  /// @param _spender The address of the contract able to transfer the tokens
  /// @param _amount The amount of tokens to be approved for transfer
  /// @return True if the function call was successful
  function approveAndCall(
    address _spender,
    uint256 _amount,
    bytes _extraData) public returns (bool success);

////////////////
// Query balance and totalSupply in History
////////////////

  /// @dev Queries the balance of `_owner` at a specific `_blockNumber`
  /// @param _owner The address from which the balance will be retrieved
  /// @param _blockNumber The block number when the balance is queried
  /// @return The balance at `_blockNumber`
  function balanceOfAt(
    address _owner,
    uint _blockNumber) public constant returns (uint);

  /// @notice Total amount of tokens at a specific `_blockNumber`.
  /// @param _blockNumber The block number when the totalSupply is queried
  /// @return The total amount of tokens at `_blockNumber`
  function totalSupplyAt(uint _blockNumber) public constant returns(uint);

////////////////
// Generate and destroy tokens
////////////////

  /// @notice Generates `_amount` tokens that are assigned to `_owner`
  /// @param _owner The address that will be assigned the new tokens
  /// @param _amount The quantity of tokens generated
  /// @return True if the tokens are generated correctly
  function mintTokens(address _owner, uint _amount) public returns (bool);


  /// @notice Burns `_amount` tokens from `_owner`
  /// @param _owner The address that will lose the tokens
  /// @param _amount The quantity of tokens to burn
  /// @return True if the tokens are burned correctly
  function destroyTokens(address _owner, uint _amount) public returns (bool);

/////////////////
// Finalize 
////////////////
  function finalize() public;

//////////
// Safety Methods
//////////

  /// @notice This method can be used by the controller to extract mistakenly
  ///  sent tokens to this contract.
  /// @param _token The address of the token contract that you want to recover
  ///  set to 0 in case you want to extract ether.
  function claimTokens(address _token) public;

////////////////
// Events
////////////////

  event ClaimedTokens(address indexed _token, address indexed _controller, uint _amount);
}
