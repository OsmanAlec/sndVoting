import { network } from "hardhat";

const { ethers } = await network.getOrCreate("localhost");

async function main() {
    const address = '0x5FbDB2315678afecb367f032d93F642f64180aa3';
    const Counter = await ethers.getContractFactory('Counter');
    const counter = Counter.attach(address);
    await counter.incBy(1000);
    console.log(await counter.x());
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });