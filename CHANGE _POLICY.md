## How To Submit a `ChangePolicy` Proposal

*guidance for any DAO ~ not specific to multi-DAOs*

```
export NEAR_ENV=mainnet

near call <dao_name>.sputnik-dao.near add_proposal '{ "proposal": { "description": "reconfigure", "kind": { "ChangePolicy": { "policy": { "roles": [{ "name": "Council", "kind": { "Group": ["<council_member1>.near", "<council_member2>", "<council_member3>" ] }, "permissions": ["*:VoteReject", "*:VoteRemove", "*:VoteApprove", "*:AddProposal", "*:Finalize"], "vote_policy": {} }, { "name": "all", "kind": "Everyone", "permissions": ["*:AddProposal"], "vote_policy": {} }], "default_vote_policy": { "weight_kind": "RoleWeight", "quorum": "0", "threshold": [1, 2] }, "proposal_bond": "100000000000000000000000", "proposal_period": "604800000000000", "bounty_bond": "100000000000000000000000", "bounty_forgiveness_period": "604800000000000" }}}}}' --accountId=<your_account>.near  --amount 1
```

## [via Sputnik DAOcumentation](https://github.com/near-daos/sputnik-dao-contract/tree/feat/enchance-contract-v2-readme/sputnikdao2#roles-and-permissions)

### Roles and Permissions

> The DAO can have several roles, each of which allows for permission configuring. These permissions are a combination of [`proposal_kind`](#proposal-types) and `VotingAction`. Due to this combination these permissions can be scoped to be very specific or you can use wildcards to grant greater access.

**Examples:**

- A role with: `["mint:VoteReject","mint:VoteRemove"]` means they can only vote to _reject_ or _remove_ a `mint` proposal, but they can't vote to approve.

- A role with: `["mint:*"]` can perform any vote action on `mint` proposals.

- A role with: `["*:*"]` has _unlimited_ permission. Normally, the `council` role has `*:*` as its permission so they can perform _any_ vote action on _any_ kind of proposal.

**Here is a list of actions:**

- `AddProposal` - _Adds given proposal to the DAO (this is the primary mechanism for getting things done)._
- `RemoveProposal` - _Removes given proposal (this is used for immediate deletion in special cases)._
- `VoteApprove` - _Votes to approve given proposal or bounty._
- `VoteReject` - _Votes to reject given proposal or bounty._
- `VoteRemove` - _Votes to remove given proposal or bounty (this may be because the proposal is spam or otherwise invalid)._
- `Finalize` - _Finalizes proposal which is cancelled when proposal has expired (this action also returns funds)._
- `MoveToHub` - _Moves a proposal to the hub (this is used to move a proposal into another DAO)._
