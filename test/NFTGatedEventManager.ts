import {
    time,
    loadFixture,
  } from "@nomicfoundation/hardhat-toolbox/network-helpers";
  import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
  import { expect } from "chai";
  import hre from "hardhat";
  
  describe("NftEventManger", function () {
    // We define a fixture to reuse the same setup in every test.
    // We use loadFixture to run this setup once, snapshot that state,
    // and reset Hardhat Network to that snapshot in every test.
    async function NftOnchainFactory() {
      const [owner] = await hre.ethers.getSigners();
  
      const nftOnchainFactory = await hre.ethers.getContractFactory("NftOnchainFactory");

      const NftFactory = await nftOnchainFactory.deploy();
  
      return { NftFactory, owner};
    }

    async function NftEventFactory() {
      
      const [owner] = await hre.ethers.getSigners();
  
      const nFTGatedFactory = await hre.ethers.getContractFactory("NFTGatedFactory");
      const NFTGatedFactory = await nFTGatedFactory.deploy();
  
      return { NFTGatedFactory};
    }

    async function deployNewNft() {
      const { NftFactory, owner } = await loadFixture(NftOnchainFactory);
      const [otherAccount, signer1] = await hre.ethers.getSigners();

      const tx = await NftFactory.createNftOnchain();
      await tx.wait();

      await (await tx).wait();
      const newNft = await NftFactory.getNftOnchainClones()
      const newNftAddress = newNft[0];

      return { newNftAddress};
    }
  
    describe("NFT Factory", function () {
      it("Should create new NFT contract", async function () {

        const { NftFactory, owner } = await loadFixture(NftOnchainFactory);
        const [otherAccount, signer1] = await hre.ethers.getSigners();

  
        const tx = await NftFactory.createNftOnchain();
        await tx.wait();

        await (await tx).wait();
        const newNft = NftFactory.getNftOnchainClones()
  
        expect((await newNft).length).to.equal(1);
      });

      it("Should mint new nft with svg to the caller", async function () {
        const newNftAddress = await deployNewNft();

        const nft = await hre.ethers.getContractAt("NftOnchain", newNftAddress.newNftAddress);

        const svg = `<svg xmlns='http://www.w3.org/2000/svg' width='1024' height='1024'>
        <defs><clipPath id='a'><path d='M0 0h1024v1024H0z'/></clipPath></defs>
        <g clip-path='url(#a)'>
          <path d='M0 0h1024v1024H0z'/>
          <path fill='#fff' d='M0 241h1024v20H0zM0 502h1024v20H0zM0 763h1024v20H0z'/>
          <path fill='#fff' d='M241 0h20v1024h-20z'/>
        </g>
      </svg>`;

        const tx = await nft.mint(svg);
        await tx.wait();

        const mintedNft = await nft.tokenURI(0);

        expect(mintedNft).to.equal(svg);


      });
  
      


    });
  

  });
  