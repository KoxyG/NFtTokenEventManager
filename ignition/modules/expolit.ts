import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const ExploitModule = buildModule("ExploitModule", (m) => {
    // Deploy with the specific challenge address
    const exploit = m.contract("Exploit", ["0x771F8f8FD270eD99db6a3B5B7e1d9f6417394249"]);
    
    return { exploit };
});

export default ExploitModule;