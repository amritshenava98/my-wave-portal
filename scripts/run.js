const main = async () => {
    //const [owner, randomPerson] = await hre.ethers.getSigners();
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    const waveContract = await waveContractFactory.deploy();
    await waveContract.deployed();

    //console.log("Contract deployed to:", waveContract.address);
    //console.log("Contract deployed by:", owner.address);

    console.log("Contract addy: ", waveContract.adrress);

    let waveCount;
    waveCount = await waveContract.getTotalWaves();
    console.log(waveCount.toNumber());

    let waveTxn = await waveContract.wave("a message!");
    await waveTxn.wait();

    const [_, randomPerson] = await hre.ethers.getSigners();
    waveTxn - await waveContract.connect(randomPerson).wave("Another message!");
    await waveTxn.wait();

    let AllWaves = await waveContract.getAllWaves();
    console.log(AllWaves);

    let waveCheck = await waveContract.waveCheck();
    console.log(waveCheck)

  };
  
  const runMain = async () => {
    try {
      await main();
      process.exit(0); // exit Node process without error
    } catch (error) {
      console.log(error);
      process.exit(1); // exit Node process while indicating 'Uncaught Fatal Exception' error
    }
    // Read more about Node exit ('process.exit(num)') status codes here: https://stackoverflow.com/a/47163396/7974948
  };
  
  runMain();