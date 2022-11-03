const Web3 = require("web3");

// connnect to RPC node (eg. Ganache)
let provider = new Web3(
    new Web3.providers.HttpProvider("http://127.0.0.1:7545")
);

const USER1 = "0x4648124A7e4c3b2C4dFF4F8c5C45FE365CDc46cD";
const USER2 = "0xC5eEfb36C4E83F99739e1DBA9e1c0c22C9A370b4";
// output the balance of address
provider.eth
    .getBalance(USER1)
    .then(console.log);

// convert and output the balance of address
provider.eth
    .getBalance(USER1)
    .then(function(result) {
        console.log(Web3.utils
            .fromWei(result, "ether")
        );
    });
provider.eth
    .getBalance(USER2)
    .then(function(result) {
        console.log(Web3.utils
            .fromWei(result, "ether")
        );
    });

// send transaction with 1 eth
provider.eth
    .sendTransaction({
        from: USER1,
        to: USER2,
        value: provider.utils.toWei("1", "ether")
    })
    .then(tx => {

        // see transaction
        console.log(tx);


        // check balance for user1
        provider.eth
            .getBalance(USER1)
            .then(function(result) {
                console.log(Web3.utils
                    .fromWei(result, "ether")
                );
            });

        // check balance for user2
        provider.eth
            .getBalance(USER2)
            .then(function(result) {
                console.log(Web3.utils
                    .fromWei(result, "ether")
                );
            });
        }
    );


