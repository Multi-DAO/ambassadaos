set -e
MASTER_ACC=cron.testnet
DAO_ROOT_ACC=sputnikv2.testnet
DAO_NAME=ambassadaos
DAO_ACCOUNT=$DAO_NAME.$DAO_ROOT_ACC
CROSS_DAO_ACCOUNT=cheddar_catz_v4.$DAO_ROOT_ACC

export NEAR_ENV=testnet

# # The payout proposal for the ephemeral DAO
# SUB_ADD_PROPOSAL=`echo "{\"proposal\": { \"description\": \"cross-dao test\", \"kind\": { \"Transfer\": { \"token_id\": \"\", \"receiver_id\": \"$MASTER_ACC\", \"amount\": \"1000000000000000000000000\" } } } }" | base64`
# FIXED_SUB_ARGS=`echo $SUB_ADD_PROPOSAL | tr -d '\r' | tr -d ' '`

# ## Dao can create a payout proposal on another DAO
# near call $DAO_ACCOUNT add_proposal '{
#   "proposal": {
#     "description": "demo croncat cross-dao proposal",
#     "kind": {
#       "FunctionCall": {
#         "receiver_id": "'$CROSS_DAO_ACCOUNT'",
#         "actions": [
#           {
#             "method_name": "add_proposal",
#             "args": "'$FIXED_SUB_ARGS'",
#             "deposit": "1000000000000000000000000",
#             "gas": "30000000000000"
#           }
#         ]
#       }
#     }
#   }
# }' --accountId $MASTER_ACC --amount 0.1

# # The approval proposal for the ephemeral DAO
# SUB_ACT_PROPOSAL=`echo "{\"id\": 0, \"action\" :\"VoteApprove\"}" | base64`
# FIXED_SUB_ARGS=`echo $SUB_ACT_PROPOSAL | tr -d '\r' | tr -d ' '`

# ## Dao can create a payout proposal on another DAO
# near call $DAO_ACCOUNT add_proposal '{
#   "proposal": {
#     "description": "demo croncat cross-dao proposal",
#     "kind": {
#       "FunctionCall": {
#         "receiver_id": "'$CROSS_DAO_ACCOUNT'",
#         "actions": [
#           {
#             "method_name": "act_proposal",
#             "args": "'$FIXED_SUB_ARGS'",
#             "deposit": "0",
#             "gas": "30000000000000"
#           }
#         ]
#       }
#     }
#   }
# }' --accountId $MASTER_ACC --amount 0.1

## NOTE: Examples setup as needed, adjust variables for use cases.
# TODO: Create a way for a dao vote on a proposal on another DAO
# near view $DAO_ACCOUNT get_policy
near call $DAO_ACCOUNT act_proposal '{"id": 4, "action" :"VoteApprove"}' --accountId $MASTER_ACC  --gas 300000000000000
# near call $DAO_ACCOUNT act_proposal '{"id": 0, "action" :"VoteReject"}' --accountId $MASTER_ACC  --gas 300000000000000
# near call $DAO_ACCOUNT act_proposal '{"id": 0, "action" :"VoteRemove"}' --accountId $MASTER_ACC  --gas 300000000000000