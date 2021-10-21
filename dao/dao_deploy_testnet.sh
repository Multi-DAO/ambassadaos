MASTER_ACC=ion.testnet
DAO_ROOT_ACC=sputnikv2.testnet
DAO_NAME=ambassadaos
DAO_ACCOUNT=$DAO_NAME.$DAO_ROOT_ACC

export NEAR_ENV=testnet

# COUNCIL='["croncat.'$DAO_ROOT_ACC'", "codame.'$DAO_ROOT_ACC'", "ref-finance.'$DAO_ROOT_ACC'", "marmaj.'$DAO_ROOT_ACC'", "cheddar.'$DAO_ROOT_ACC'", "data.'$DAO_ROOT_ACC'", "shrm.'$DAO_ROOT_ACC'"]'
COUNCIL='["croncat.'$DAO_ROOT_ACC'", "cheddar.'$DAO_ROOT_ACC'"]'

#Args for creating DAO in sputnik-factory2
ARGS=`echo "{\"config\":  {\"name\": \"$DAO_NAME\", \"purpose\": \"An interdaomentional space station connecting Governauts reaching for the stars with Astro\", \"metadata\":\"\"}, \"policy\": $COUNCIL}" | base64`
FIXED_ARGS=`echo $ARGS | tr -d '\r' | tr -d ' '`

# Call sputnik factory for deploying new dao with custom policy
near call $DAO_ROOT_ACC create "{\"name\": \"$DAO_NAME\", \"args\": \"$FIXED_ARGS\"}" --accountId $MASTER_ACC --amount 5 --gas 150000000000000
near view $DAO_ACCOUNT get_policy
echo "'$NEAR_ENV' Deploy Complete!"