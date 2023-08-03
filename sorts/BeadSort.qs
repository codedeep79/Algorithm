namespace BeadSort {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;

    operation BeadSort(input : Qubit[], maxValue : Int) : Unit {
        mutable nBeads = new Int[maxValue];

        // Place beads on the rods based on the input values
        for (idx in 0 .. Length(input) - 1) {
            let value = Length(input) - idx;
            for (j in 0 .. value - 1) {
                X(input[idx]);
            }
            for (j in value .. maxValue - 1) {
                H(input[idx]);
            }
        }

        // Measure the number of beads on each rod
        for (idx in 0 .. Length(input) - 1) {
            mutable numBeads = 0;
            for (j in 0 .. maxValue - 1) {
                Controlled X([input[idx]], nBeads[j]);
                Controlled H([input[idx]], nBeads[j]);
                if (M(nBeads[j]) == One) {
                    set numBeads += 1;
                }
            }
            for (j in 0 .. maxValue - 1) {
                if (j < numBeads) {
                    X(input[idx]);
                }
                Controlled X([input[idx]], nBeads[j]);
                Controlled H([input[idx]], nBeads[j]);
            }
        }
    }
}
