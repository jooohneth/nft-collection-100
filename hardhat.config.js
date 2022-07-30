require("@nomicfoundation/hardhat-toolbox");
require('dotenv').config(); 

module.exports = {
  solidity: "0.8.9",
  networks: {
    rinkeby: {
      url: process.env.ALCHEMY_URL,
      accounts: [process.env.PRIVATE_KEY]
    }
  },
  etherscan: {
    apiKey: "GSKVPPXJEB5R2DEAGGHDXJ9NCFCJDK4QTJ"
  }
};
