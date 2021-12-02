set -e
MASTER_ACC=cron.testnet
DAO_ROOT_ACC=sputnikv2.testnet
DAO_NAME=multidaomo
DAO_ACCOUNT=$DAO_NAME.$DAO_ROOT_ACC
CROSS_DAO_ACCOUNT=multi.$DAO_ROOT_ACC
BOND_AMOUNT=1

export NEAR_ENV=testnet

# near view $DAO_ACCOUNT get_policy

## --------------------------------
## CORE PROPOSALS
## Create proposals from your sub-DAO on the MultiDAO
## --------------------------------

# ## Payout Proposal
# ## --------------------------------
# RECEIVER=cron.testnet
# TRANSFER_AMOUNT=1000000000000000000000000
# # NOTE: Only specify if you are transfer token NOT near
# TOKEN_ID=
# SUB_ADD_PROPOSAL=`echo "{\"proposal\": { \"description\": \"\", \"kind\": { \"Transfer\": { \"token_id\": \"$TOKEN_ID\", \"receiver_id\": \"$RECEIVER\", \"amount\": \"$TRANSFER_AMOUNT\" } } } }" | base64`
# FIXED_SUB_ARGS=`echo $SUB_ADD_PROPOSAL | tr -d '\r' | tr -d ' '`

# ## Create proposal on MultiDAO
# near call $DAO_ACCOUNT add_proposal '{
#   "proposal": {
#     "description": "MultiDAO Payment Proposal",
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
# }' --accountId $MASTER_ACC --amount $BOND_AMOUNT


# ## Membership Proposals (Add/Remove)
# ## --------------------------------
# ROLE=council
# NEW_MEMBER=new_member.testnet

# ## Uncomment the line you want. First is add member, second is remove member
# SUB_ADD_PROPOSAL=`echo "{\"proposal\": { \"description\": \"Welcome '$NEW_MEMBER' to the '$ROLE' team\", \"kind\": { \"AddMemberToRole\": { \"member_id\": \"'$NEW_MEMBER'\", \"role\": \"'$ROLE'\" } } } }" | base64`
# # SUB_ADD_PROPOSAL=`echo "{\"proposal\": { \"description\": \"Remove '$NEW_MEMBER' from '$ROLE' team\", \"kind\": { \"RemoveMemberFromRole\": { \"member_id\": \"'$NEW_MEMBER'\", \"role\": \"'$ROLE'\" } } } }" | base64`
# FIXED_SUB_ARGS=`echo $SUB_ADD_PROPOSAL | tr -d '\r' | tr -d ' '`

# ## Create proposal on MultiDAO
# near call $DAO_ACCOUNT add_proposal '{
#   "proposal": {
#     "description": "MultiDAO Membership Proposal",
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
# }' --accountId $MASTER_ACC --amount $BOND_AMOUNT


# ## Act on Proposals (Approve/Reject/Remove)
# ## --------------------------------
# ## NOTE: You need to specify the proposal ID for this work!
# PROPOSAL_ID=0
# ## Uncomment the line you want. First is approve proposal, second is reject proposal, third is remove proposal
# SUB_ACT_PROPOSAL=`echo "{\"id\": $PROPOSAL_ID, \"action\" :\"VoteApprove\"}" | base64`
# # SUB_ACT_PROPOSAL=`echo "{\"id\": $PROPOSAL_ID, \"action\" :\"VoteReject\"}" | base64`
# # SUB_ACT_PROPOSAL=`echo "{\"id\": $PROPOSAL_ID, \"action\" :\"VoteRemove\"}" | base64`
# FIXED_SUB_ARGS=`echo $SUB_ACT_PROPOSAL | tr -d '\r' | tr -d ' '`

# ## Dao can create a payout proposal on another DAO
# near call $CROSS_DAO_ACCOUNT add_proposal '{
#   "proposal": {
#     "description": "MultiDAO Proposal Vote",
#     "kind": {
#       "FunctionCall": {
#         "receiver_id": "'$DAO_ACCOUNT'",
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
# }' --accountId $MASTER_ACC --amount $BOND_AMOUNT



# ## --------------------------------
# ## Cron.cat
# ## Create proposals that create automation for the MultiDAO
# ## --------------------------------

# CRONCAT=manager_v1.cron.testnet
# TASK_ACCOUNT=counter.cron.testnet
# CRONCAT_ARGS=`echo "{\"contract_id\": \"$TASK_ACCOUNT\",\"function_id\": \"increment\",\"cadence\": \"0 0 * * * *\",\"recurring\": true,\"deposit\": \"0\",\"gas\": 9000000000000}" | base64`
# FIXED_CRONCAT_ARGS=`echo $ARGS | tr -d '\r' | tr -d ' '`
# SUB_ADD_PROPOSAL=`echo "{\"proposal\": { \"description\": \"Create cron.cat task\", \"kind\": { \"FunctionCall\": { \"receiver_id\": \"'$CRONCAT'\", \"actions\": [ { \"method_name\": \"create_task\", \"args\": \"'$FIXED_CRONCAT_ARGS'\", \"deposit\": \"0\", \"gas\": \"30000000000000\" } ] } } } } }" | base64`
# FIXED_SUB_ARGS=`echo $SUB_ADD_PROPOSAL | tr -d '\r' | tr -d ' '`

# ## Dao can create a payout proposal on another DAO
# near call $CROSS_DAO_ACCOUNT add_proposal '{
#   "proposal": {
#     "description": "MultiDAO Proposal Vote",
#     "kind": {
#       "FunctionCall": {
#         "receiver_id": "'$DAO_ACCOUNT'",
#         "actions": [
#           {
#             "method_name": "add_proposal",
#             "args": "'$FIXED_SUB_ARGS'",
#             "deposit": "0",
#             "gas": "30000000000000"
#           }
#         ]
#       }
#     }
#   }
# }' --accountId $MASTER_ACC --amount $BOND



# ## --------------------------------
# ## METAPOOL STAKING
# ## --------------------------------
# METAPOOL_ACCT=meta-pool.near

# ## Step 1. Stake Some NEAR
# Example: 10 NEAR
# STAKE_AMOUNT_NEAR=10000000000000000000000000
# SUB_ADD_PROPOSAL=`echo "{\"proposal\": {\"description\": \"Stake DAO funds to metapool\", \"kind\": {\"FunctionCall\": {\"receiver_id\": \"'$METAPOOL_ACCT'\", \"actions\": [{\"method_name\": \"deposit_and_stake\", \"args\": \"e30=\", \"deposit\": \"'$STAKE_AMOUNT_NEAR'\", \"gas\": \"20000000000000\"}]}}}}" | base64`

# # Step 2. Unstake some amount of NEAR
# UNSTAKE_AMOUNT=10000000000000000000000000
# SUB_POOL_ARGS=`echo "{ \"amount\": \"$UNSTAKE_AMOUNT\" }" | base64`
# FIXED_POOL_ARGS=`echo $SUB_POOL_ARGS | tr -d '\r' | tr -d ' '`
# SUB_ADD_PROPOSAL=`echo "{\"proposal\": {\"description\": \"Unstake all funds from metapool to DAO\", \"kind\": {\"FunctionCall\": {\"receiver_id\": \"'$METAPOOL_ACCT'\", \"actions\": [{\"method_name\": \"unstake\", \"args\": \"'$FIXED_POOL_ARGS'\", \"deposit\": \"0\", \"gas\": \"20000000000000\"}]}}}}" | base64`

# # Step 3. Withdraw balance back to DAO
# SUB_ADD_PROPOSAL=`echo "{\"proposal\": {\"description\": \"Withdraw unstaked funds from metapool to DAO\", \"kind\": {\"FunctionCall\": {\"receiver_id\": \"'$METAPOOL_ACCT'\", \"actions\": [{\"method_name\": \"withdraw_unstaked\", \"args\": \"e30=\", \"deposit\": \"0\", \"gas\": \"20000000000000"\}]}}}}" | base64`

# # Leave this line uncommented
# FIXED_SUB_ARGS=`echo $SUB_ADD_PROPOSAL | tr -d '\r' | tr -d ' '`

# ## Dao can create a payout proposal on another DAO
# near call $CROSS_DAO_ACCOUNT add_proposal '{
#   "proposal": {
#     "description": "MultiDAO Proposal for MetaPool Staking",
#     "kind": {
#       "FunctionCall": {
#         "receiver_id": "'$DAO_ACCOUNT'",
#         "actions": [
#           {
#             "method_name": "add_proposal",
#             "args": "'$FIXED_SUB_ARGS'",
#             "deposit": "0",
#             "gas": "30000000000000"
#           }
#         ]
#       }
#     }
#   }
# }' --accountId $MASTER_ACC --amount $BOND_AMOUNT

