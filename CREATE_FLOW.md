# CREATE A MULTIDAO

Multi-DAOs are flexible to enable many types of collaboration between DAOs! You can use the templates in this repo to build the multidao you need.

## Step 0. Clone this Repo

To follow this guide, please clone the repo and adjust files/variable inside the `dao` folder.

## Step 1. Name your DAO

The best way to start a DAO is by creating the name that resonates with its members. Bonus points for DAO pun names ;)
You need to be 100% sure your DAO name will not have collisions before deploying, or your deployment will fail.

You can name the DAO on line 3 of the following files, and the script will take care of the rest:

* [Mainnet DAO](./dao_deploy_mainnet.sh)
* [Testnet DAO](./dao_deploy_testnet.sh)

You can also customize your DAO description (purpose) on line 18.

## Step 2. Define your Council

MultiDAO council members are made up of DAOs holding a seat. You can define your council based on the DAOs that are needed for your multiDAO.

Here's the example of how to define a council:
```bash
COUNCIL='["croncat.sputnik-dao.near", "marmaj.sputnik-dao.near"]'
```

Once you know the council members, you can add them all to the council array.

## Step 3. Deploy your DAO

If you are happy with all the configurations in the deploy script, now is the moment of truth!

Execute the script:

```bash
# Mainnet DAO
./dao_deploy_mainnet.sh

# Testnet DAO
./dao_deploy_testnet.sh
```

If all goes well, you will see the transactions for creating the dao, and a JSON object of the final deployed configuration.

## Next Steps: Proposals

Click [here to configure proposals for each multiDAO](./PROPOSALS_FLOW.md)