const CertLib = artifacts.require('CertLib');
const Certs = artifacts.require('Certs');

module.exports = function (deployer) {
    deployer.deploy(CertLib);
    deployer.link(CertLib, Certs);
    deployer.deploy(Certs);
};
