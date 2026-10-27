pragma circom 2.0.0;

include "../node_modules/circomlib/circuits/switcher.circom";
include "../node_modules/circomlib/circuits/poseidon.circom";
include "../node_modules/circomlib/circuits/bitify.circom";

template Mkt2VerifierLevel() {
    signal input sibling;
    signal input lower_level;
    signal input selector;
    signal output root;

    component switcher = Switcher();
    component hash = Poseidon(2);

    switcher.sel <== selector;
    switcher.L <== lower_level;
    switcher.R <== sibling;

    hash.inputs[0] <== switcher.outL;
    hash.inputs[1] <== switcher.outR;

    root <== hash.out;
}

template Mkt2Verifier(nLevels) {

    signal input key;
    signal input value;
    signal input root;
    signal input siblings[nLevels];

    component n2b = Num2Bits(nLevels);
    component levels[nLevels];

    component secret_key_hash = Poseidon(1);

    secret_key_hash.inputs[0] <== value;

    n2b.in <== key;

    for (var i=nLevels-1; i>=0; i--) {
        levels[i] = Mkt2VerifierLevel();
        levels[i].sibling <== siblings[i];
        levels[i].selector <== n2b.out[i];
        if (i==nLevels-1) {
            levels[i].lower_level <== secret_key_hash.out;
        } else {
            levels[i].lower_level <== levels[i+1].root;
        }
    }

    root === levels[0].root;
}