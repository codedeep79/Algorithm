namespace Quantum.RadixSort {
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Convert;
    
    operation RadixSort (input : Qubit[], maxValue : Int) : Unit {
        mutable i = 0;
        mutable j = 0;
        mutable currentBit = 0;

        let n = Length(input);
        let numBits = IntAsDoubleC(currentBit);

        repeat {
            mutable count0 = 0;
            mutable count1 = 0;

            for (i in 0..n - 1) {
                let bitValue = M(input[i], BigEndian(currentBit));
                if (bitValue == Zero) {
                    Set(input[i]);
                    count0 += 1;
                } else {
                    Set(input[i]);
                    count1 += 1;
                }
            }

            for (j in 0..count0 - 1) {
                let bitValue = M(input[j], BigEndian(currentBit));
                if (bitValue != Zero) {
                    CNOT(input[j], input[count0 + j]);
                }
            }

            set currentBit = currentBit + 1;

        } until (currentBit == numBits);
    }
}
