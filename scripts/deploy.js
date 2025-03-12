const main = async () => {
  const [owner] = await hre.ethers.getSigners();

  const xPost = await hre.ethers.deployContract("XPost", {
    value: hre.ethers.parseEther("0.1"),
  });
  await xPost.waitForDeployment();
  };

  const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();
