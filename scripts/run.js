const main = async () => {
  const [owner] = await hre.ethers.getSigners();
  const xPost = await hre.ethers.deployContract("XPost", {
    value: hre.ethers.parseEther("0.1"),
  });
  await xPost.waitForDeployment();

  const postTxn = await xPost.createPost("Submitting post #1");
  await postTxn.wait();

  await xPost.getTotalPosts();
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
