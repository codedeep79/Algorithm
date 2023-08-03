namespace Quantum.BitonicSort {
    // Define the BitonicSort operation.
    operation BitonicSort(inputRegister : Qubit[], direction : Int) : Unit is Adj {
        // Check if the input register size is a power of 2.
        let n = Length(inputRegister);
        if (PowI(2, IntAsDouble(n)) != n) {
            Message("Input register size must be a power of 2.");
            return;
        }

        for (i in 0 .. n - 1) {
            for (j in 0 .. i) {
                if ((j & (i >> 1)) == 0) {
                    BitonicCompare(inputRegister, j, j + i, direction);
                }
            }
        }
    }

    // Define the BitonicCompare operation.
    operation BitonicCompare(inputRegister : Qubit[], i : Int, j : Int, direction : Int) : Unit is Adj {
        let diff = inputRegister[i] == Zero ? -1 : 1;
        if (diff == direction) {
            X(inputRegister[i]);
            X(inputRegister[j]);
        }

        Controlled X([inputRegister[i]], (inputRegister[j], diff));
        if (diff == direction) {
            X(inputRegister[i]);
            X(inputRegister[j]);
        }
    }
}
