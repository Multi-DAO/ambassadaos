MASTER_ACC=tjtc.near
DAO_ROOT_ACC=sputnik-dao.near
DAO_NAME=ambassadaos
DAO_ACCOUNT=$DAO_NAME.$DAO_ROOT_ACC

##Change NEAR_ENV between mainnet, testnet and betanet
# export NEAR_ENV=testnet
export NEAR_ENV=mainnet

# COUNCIL='["croncat.'$DAO_ROOT_ACC'", "dev.'$DAO_ROOT_ACC'", "community.'$DAO_ROOT_ACC'", "cheddar.'$DAO_ROOT_ACC'", "codame.'$DAO_ROOT_ACC'", "ref-finance.'$DAO_ROOT_ACC'", "marmaj.'$DAO_ROOT_ACC'", "openshards.'$DAO_ROOT_ACC'", "collabs.'$DAO_ROOT_ACC'", "auroradao.'$DAO_ROOT_ACC'", "move.'$DAO_ROOT_ACC'", "creatives.'$DAO_ROOT_ACC'", "growth-guild.'$DAO_ROOT_ACC'", "pixeltoken.'$DAO_ROOT_ACC'"]'
COUNCIL='["croncat.'$DAO_ROOT_ACC'", "dev.'$DAO_ROOT_ACC'", "community.'$DAO_ROOT_ACC'"]'

#Args for creating DAO in sputnik-factory
ARGS=`echo "{\"config\":  {\"name\": \"$DAO_NAME\", \"purpose\": \"An interdaomentional space station connecting Governauts reaching for the stars with Astro\", \"metadata\":\"\"}, \"policy\": $COUNCIL}" | base64`
FIXED_ARGS=`echo $ARGS | tr -d '\r' | tr -d ' '`

# Call sputnik factory for deploying new dao with custom policy
near call $DAO_ROOT_ACC create "{\"name\": \"$DAO_NAME\", \"args\": \"$FIXED_ARGS\"}" --accountId $MASTER_ACC --amount 5 --gas 150000000000000
near view $DAO_ACCOUNT get_policy
echo "'$NEAR_ENV' Deploy Complete!"