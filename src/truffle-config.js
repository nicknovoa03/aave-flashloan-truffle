const path = require("path");
var HDWalletProvider = require("truffle-hdwallet-provider");
var mnemonic2 = "speak foster humble photo snake actress miss rebuild helmet glance dilemma fruit"
const mainnetUrl = "https://mainnet.infura.io/v3/bad8cc770bef49dc88683bf2290205c8";

module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
  contracts_build_directory: path.join(__dirname, "app/src/contracts"),
  networks: {
    live: {
      provider: () => new HDWalletProvider(mnemonic2, mainnetUrl),
      network_id: 1
    },
    develop: { // default with truffle unbox is 7545, but we can use develop to test changes, ex. truffle migrate --network develop
      host: "127.0.0.1",
      port: 7545,
      network_id: "*"
    },
    rinkeby: {
      provider: function () {
        return new HDWalletProvider(mnemonic2, "https://rinkeby.infura.io/v3/bad8cc770bef49dc88683bf2290205c8");
      },
      network_id: 4,
      gas: 15000000,
      gasPrice: 10000000000,
    }
  },

  compilers: {
    solc: {
      version: "^0.8.0"
    }
  },
  api_keys: {
    etherscan: "R99G1N1CWINQ5U93MT3TVJH7XT5QGWERSN",
  },
  plugins: [
    'truffle-plugin-verify'
  ]
};
