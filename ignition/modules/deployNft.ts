import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";


const NFTGatedFactoryModule = buildModule("NFTGatedFactoryModule", (m) => {
  
  const nFTGatedFactory = m.contract("NFTGatedFactory");

  return { nFTGatedFactory };
});

export default NFTGatedFactoryModule;
