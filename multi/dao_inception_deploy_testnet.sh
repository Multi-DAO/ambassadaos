MASTER_ACC=cron.testnet
DAO_ROOT_ACC=sputnikv2.testnet
# DAO_NAME=multidaomo
DAO_NAME=croncat
DAO_ACCOUNT=$DAO_NAME.$DAO_ROOT_ACC
BOND_AMOUNT=1
NEW_DAO_NAME=multidaomoception_v1
NEW_DAO_ACCOUNT=$NEW_DAO_NAME.$DAO_ROOT_ACC

export NEAR_ENV=testnet

## DAO Creation Proposal
## --------------------------------

COUNCIL='["croncat.'$DAO_ROOT_ACC'", "multi.'$DAO_ROOT_ACC'", "marmaj.'$DAO_ROOT_ACC'"]'

#Args for creating DAO in sputnik-factory2
ARGS=`echo "{\"config\":  {\"name\": \"$NEW_DAO_NAME\", \"purpose\": \"A DAO deployed by another DAO - so tasty these DAOnuts\", \"metadata\":\"\"}, \"policy\": $COUNCIL}" | base64`
FIXED_ARGS=`echo $ARGS | tr -d '\r' | tr -d ' '`
SUB_ADD_PROPOSAL=`echo "{\"name\": \"$NEW_DAO_NAME\", \"args\": \"$FIXED_ARGS\"}" | base64`
FIXED_SUB_ARGS=`echo $SUB_ADD_PROPOSAL | tr -d '\r' | tr -d ' '`

## Create proposal on MultiDAO
near call $DAO_ACCOUNT add_proposal '{
  "proposal": {
    "description": "DAO Creation Proposal - This proposal contains the policy and initial amount to fund and deploy a new DAO",
    "kind": {
      "FunctionCall": {
        "receiver_id": "'$DAO_ROOT_ACC'",
        "actions": [
          {
            "method_name": "create",
            "args": "'$FIXED_SUB_ARGS'",
            "deposit": "5000000000000000000000000",
            "gas": "150000000000000"
          }
        ]
      }
    }
  }
}' --accountId $MASTER_ACC --amount $BOND_AMOUNT


## --------------------------------
## Vote
## --------------------------------
## NOTE: Examples setup as needed, adjust variables for use cases.
# near view $DAO_ACCOUNT get_policy
# near call $DAO_ACCOUNT act_proposal '{"id": 0, "action" :"VoteApprove"}' --accountId $MASTER_ACC  --gas 300000000000000
# near call $DAO_ACCOUNT act_proposal '{"id": 0, "action" :"VoteReject"}' --accountId $MASTER_ACC  --gas 300000000000000
# near call $DAO_ACCOUNT act_proposal '{"id": 0, "action" :"VoteRemove"}' --accountId $MASTER_ACC  --gas 300000000000000


# # When the proposal goes through:
# near view $NEW_DAO_ACCOUNT get_policy

echo "'$NEAR_ENV' Deploy Complete!"