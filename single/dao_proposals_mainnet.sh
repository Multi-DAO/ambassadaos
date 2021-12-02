#!/bin/bash
set -e
MASTER_ACC=YOU.near
DAO_ROOT_ACC=sputnik-dao.near
DAO_NAME=cool_dao_name
DAO_ACCOUNT=$DAO_NAME.$DAO_ROOT_ACC

CRON_ACCOUNT=manager_v1.croncat.near
METAPOOL_ACCT=meta-pool.near
PARAS_ACCT=x.paras.near

export NEAR_ENV=mainnet

## payout proposal
# PAYOUT_AMT=1000000000000000000000000
# PAYOUT_ACCT=YOU.near
# near call $DAO_ACCOUNT add_proposal '{"proposal": { "description": "Payout", "kind": { "Transfer": { "token_id": "", "receiver_id": "'$PAYOUT_ACCT'", "amount": "'$PAYOUT_AMT'" } } } }' --accountId $MASTER_ACC --amount 0.1

## add member to one of our roles
# ROLE=founders
# ROLE=applications
# ROLE=agents
# ROLE=commanders
# NEW_MEMBER=prod.near
# near call $DAO_ACCOUNT add_proposal '{ "proposal": { "description": "Welcome '$NEW_MEMBER' to the '$ROLE' team", "kind": { "AddMemberToRole": { "member_id": "'$NEW_MEMBER'", "role": "'$ROLE'" } } } }' --accountId $MASTER_ACC --amount 0.1
# near call $DAO_ACCOUNT add_proposal '{ "proposal": { "description": "Remove '$NEW_MEMBER' from '$ROLE'", "kind": { "RemoveMemberFromRole": { "member_id": "'$NEW_MEMBER'", "role": "'$ROLE'" } } } }' --accountId $MASTER_ACC --amount 0.1

## CRONCAT Task proposal: TICK 
# ARGS=`echo "{\"contract_id\": \"$CRON_ACCOUNT\",\"function_id\": \"tick\",\"cadence\": \"0 0 * * * *\",\"recurring\": true,\"deposit\": \"0\",\"gas\": 2400000000000}" | base64`
# FIXED_ARGS=`echo $ARGS | tr -d '\r' | tr -d ' '`
# near call $DAO_ACCOUNT add_proposal '{"proposal": {"description": "Create cron task to manage TICK method to handle agents every hour for 1 year", "kind": {"FunctionCall": {"receiver_id": "'$CRON_ACCOUNT'", "actions": [{"method_name": "create_task", "args": "'$FIXED_ARGS'", "deposit": "7000000000000000000000000", "gas": "50000000000000"}]}}}}' --accountId $MASTER_ACC --amount 0.1


## --------------------------------
## METAPOOL STAKING
## --------------------------------
# Stake
# 10 NEAR
# STAKE_AMOUNT_NEAR=10000000000000000000000000
# near call $DAO_ACCOUNT add_proposal '{"proposal": {"description": "Stake funds from dao to metapool", "kind": {"FunctionCall": {"receiver_id": "'$METAPOOL_ACCT'", "actions": [{"method_name": "deposit_and_stake", "args": "e30=", "deposit": "'$STAKE_AMOUNT_NEAR'", "gas": "20000000000000"}]}}}}' --accountId $MASTER_ACC --amount 0.1

# # Unstake all (example: 9xVyewMkzxHfRGtx3EyG82mXX8CfPXLJeW4Xo2y6PpXX)
# ARGS=`echo "{ \"amount\": \"10000000000000000000000000\" }" | base64`
# FIXED_ARGS=`echo $ARGS | tr -d '\r' | tr -d ' '`
# near call $DAO_ACCOUNT add_proposal '{"proposal": {"description": "Unstake funds from metapool to dao", "kind": {"FunctionCall": {"receiver_id": "'$METAPOOL_ACCT'", "actions": [{"method_name": "unstake", "args": "'$FIXED_ARGS'", "deposit": "0", "gas": "20000000000000"}]}}}}' --accountId $MASTER_ACC --amount 0.1

# # Withdraw balance back (example: EKZqArNzsjq9hpYuYt37Y59qU1kmZoxguLwRH2RnDELd)
# near call $DAO_ACCOUNT add_proposal '{"proposal": {"description": "Withdraw unstaked funds from metapool to dao", "kind": {"FunctionCall": {"receiver_id": "'$METAPOOL_ACCT'", "actions": [{"method_name": "withdraw_unstaked", "args": "e30=", "deposit": "0", "gas": "20000000000000"}]}}}}' --accountId $MASTER_ACC --amount 0.1

## --------------------------------
## PARAS.ID NFTs
## --------------------------------
##
## NOTE: To mint a series, first upload artwork via secret account and get the ipfs hash, as there is no way to upload via DAO

# [img, reference]
# https://cdn.paras.id/tr:w-0.8/bafybei...u6tme4zj4gvnha
# Asset: {"status":1,"data":["ipfs://bafybe...gvnha","ipfs://bafybeidy77p...5m2afbq"]}

# Create the Series!
# nft_create_series
# {
#   "creator_id": "YOUR.sputnik-dao.near",
#   "token_metadata": {
#     "title": "Asset Title",
#     "media": "bafybeid7ytiw7yea...",
#     "reference": "bafybeih7jhlqs7g65...",
#     "copies": 10
#   },
#   "price": null,
#   "royalty": {
#     "YOUR.sputnik-dao.near": 700
#   }
# }
# ARGS=`echo "{ \"creator_id\": \"$DAO_ACCOUNT\", \"token_metadata\": { \"title\": \"Asset Title\", \"media\": \"bafybeibz...kpnjtraeu\", \"reference\": \"bafybeie5...k7yq722xf3nq\", \"copies\": 37 }, \"price\": null, \"royalty\": { \"$DAO_ACCOUNT\": 700 } }" | base64`
# FIXED_ARGS=`echo $ARGS | tr -d '\r' | tr -d ' '`
# near call $DAO_ACCOUNT add_proposal '{"proposal": {"description": "Create NFT series for DAO", "kind": {"FunctionCall": {"receiver_id": "'$PARAS_ACCT'", "actions": [{"method_name": "nft_create_series", "args": "'$FIXED_ARGS'", "deposit": "4500000000000000000000", "gas": "20000000000000"}]}}}}' --accountId $MASTER_ACC --amount 1


# Mint an NFT to a user
# Get the token_series_id from the above create series result
# 
# nft_mint
# {
#   "token_series_id": "12345",
#   "receiver_id": "account.near"
# }

# SERIES_ID=12345
# RECEIVER=account.near
# ARGS=`echo "{ \"token_series_id\": \"$SERIES_ID\", \"receiver_id\":  \"$RECEIVER\" }" | base64`
# FIXED_ARGS=`echo $ARGS | tr -d '\r' | tr -d ' '`
# near call $DAO_ACCOUNT add_proposal '{"proposal": {"description": "Mint NFT for '$RECEIVER'", "kind": {"FunctionCall": {"receiver_id": "'$PARAS_ACCT'", "actions": [{"method_name": "nft_mint", "args": "'$FIXED_ARGS'", "deposit": "7400000000000000000000", "gas": "90000000000000"}]}}}}' --accountId $MASTER_ACC --amount 0.1

## --------------------------------
## Vote
## --------------------------------
## NOTE: Examples setup as needed, adjust variables for use cases.
# near view $DAO_ACCOUNT get_policy
# near call $DAO_ACCOUNT act_proposal '{"id": 0, "action" :"VoteApprove"}' --accountId $MASTER_ACC  --gas 300000000000000
# near call $DAO_ACCOUNT act_proposal '{"id": 0, "action" :"VoteReject"}' --accountId $MASTER_ACC  --gas 300000000000000
# near call $DAO_ACCOUNT act_proposal '{"id": 0, "action" :"VoteRemove"}' --accountId $MASTER_ACC  --gas 300000000000000

# # Loop All Action IDs and submit action
# vote_actions=(0 1 2 3 4 5)
# for (( e=0; e<=${#vote_actions[@]} - 1; e++ ))
# do
#   # action="VoteApprove"
#   # action="VoteReject"
#   action="VoteRemove"
#   SUB_ACT_PROPOSAL=`echo "{\"id\": ${vote_actions[e]}, \"action\" :\"${action}\"}"`
#   echo "Payload ${SUB_ACT_PROPOSAL}"

#   near call $DAO_ACCOUNT act_proposal '{"id": '${vote_actions[e]}', "action" :"'${action}'"}' --accountId $MASTER_ACC  --gas 300000000000000
# done