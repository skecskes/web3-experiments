const Web3 = require("web3");
const fs = require("fs");

let provider = new Web3(
    new Web3.providers.HttpProvider("http://localhost:7545")
);

const CONTRACT_ADDR = "0x19eaB09D98fFB315d78659fa320125E14bD60880"; // address of deployed SomeContract.sol
const USER_ADDR = "0x4648124A7e4c3b2C4dFF4F8c5C45FE365CDc46cD"; // wallet from ganache

// first 4 bytes (10 chars) of keccak256(alias sha3) of the function is the function hash
let myUintHash = Web3.utils.sha3("myUint()").substr(0,10);
console.log(myUintHash);

provider.eth.call({
    from: USER_ADDR,
    to: CONTRACT_ADDR,
    data: myUintHash // calling myUnit()
}).then(console.log)

// better way is to use abi of contract
const ABI = JSON.parse(fs.readFileSync("SomeContract.abi").toString());
let contract = new provider.eth.Contract(ABI, CONTRACT_ADDR);

contract.methods.myUint().call().then(console.log);

contract.methods.setUint(42).send({from: USER_ADDR}).then(console.log)
// same as below:
// let setUintHash = Web3.utils.sha3("setUint(uint256)").substr(0,10);
// provider.eth.call({
//     from: USER_ADDR,
//     to: CONTRACT_ADDR, // address of deployed SomeContract.sol
//     data: "0x4ef65c3b000000000000000000000000000000000000000000000000000000000000000a"
// }).then(console.log)


