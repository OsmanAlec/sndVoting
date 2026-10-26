import { network } from "hardhat";

const { ethers } = await network.getOrCreate("localhost");

async function main(this: any) {
  // We get the contract to deploy
  const Counter = await ethers.getContractFactory('Counter');
  console.log('Deploying counter...');
  const counter = await Counter.deploy();
  await counter.waitForDeployment();
  console.log('counter deployed to:', await counter.getAddress());
}

main()
  .then(() => process.exit(0))
  .catch(error => { 
    console.error(error);
    process.exit(1);
  });