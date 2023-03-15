const HDWalletProvider = require('@truffle/hdwallet-provider'); 
const Web3 = require('web3');
const { interface, bytecode} = require('./compile');

const provider = new HDWalletProvider(
    'bf8584394ea45e43113790324d7d1d1c716cde390bd1f1e86691ef71677d070d',
    'http://127.0.0.1:8545'
);

const web3 = new Web3(provider);

const deploy = async () => {
    const accounts = await web3.eth.getAccounts();

    console.log('Attempting to deploy from account', accounts[0]);

    try {
        const result = await new web3.eth.Contract(JSON.parse(interface))
        .deploy({ data: bytecode })
        .send({ gas: '1000000', from: accounts[0] });

    console.log(interface);
    console.log('Contract deployed to', result.options.address);    
    } catch (error) {
        console.log('Error -> ', error);    
    }
    
    provider.engine.stop();
};
deploy();