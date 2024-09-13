import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";


const NFTGatedEventManagerModule = buildModule("NFTGatedEventManagerModule", (m) => {
  
  const nFTGatedEventManager = m.contract("NFTGatedEventManager");

  return { nFTGatedEventManager };
});

export default NFTGatedEventManagerModule;
