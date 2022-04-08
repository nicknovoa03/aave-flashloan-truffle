const PrintMoney = artifacts.require("PrintMoney");

module.exports = function(deployer) {
    deployer.deploy(PrintMoney);
};