const HDWalletProvider = require('@truffle/hdwallet-provider'); 
const Web3 = require('web3');
const { interface, bytecode} = require('./compile');

const provider = new HDWalletProvider(
    'legend judge organ gospel load scan panic lava large hedgehog print hidden',
    'https://goerli.infura.io/v3/edc8a92e9bb0490aaac8ab218641ca55'
);

const web3 = new Web3(provider);

const deploy = async () => {
    const accounts = await web3.eth.getAccounts();

    console.log('Attempting to deploy from account', accounts[0]);

    try {
        const result = await new web3.eth.Contract(JSON.parse(interface))
        .deploy({ data: bytecode, arguments: ['Hi there!'] })
        .send({ gas: '1000000', from: accounts[0] });
    console.log('Contract deployed to', result.options.address);    
    } catch (error) {
        console.log('Error -> ', error);    
    }
    
    provider.engine.stop();
};
deploy();