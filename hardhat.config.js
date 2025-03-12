require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();
/** @type import('hardhat/config').HardhatUserConfig */

const accounts = process.env.ACCOUNTS.split(',');
module.exports = {
  solidity: "0.8.28",
  networks: {
    staging: {
      url: process.env.URL,
      accounts: accounts,
    },
  }
};
