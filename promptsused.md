``
pragma circom 2.0.0;

    include "../node_modules/circomlib/circuits/switcher.circom";
    include "../node_modules/circomlib/circuits/poseidon.circom";
    include "../node_modules/circomlib/circuits/bitify.circom";
    include: "./merkletree.circom";

    template Vote() {
        // private
        signal input secret;
        signal input siblings[depth];
        signal input key;

        // public
        signal input electionID;
        signal input choice;
        signal input root;
        signal input depth;

        // outputs
        signal output nullifier;

        component mkt2verifier = Mkt2Verifier(depth);

        mkt2verifier.key <== key;
        mkt2verifier.root <== root;
        mkt2verifier.siblings[depth] <== siblings;
        mkt2verifier.value <== secret;

        component nullHash = Poseidon(2);
        nullHash.inputs[0] <== pollId;
        nullHash.inputs[1] <== secret;
        nullifier <== nullHash.out;

        signal choiceOut;
        choiceOut <== choice * choice;

    }

    component main { public [electionID, choice, root] } = Vote();

``

I wrote a vote circuit, does this make sense for my architecture? Proof read it please.

---
