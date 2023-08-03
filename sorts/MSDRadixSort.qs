namespace Quantum.RadixSort {
    open Microsoft.Quantum.Canon;
    
    operation RadixSort(inputArray : Int[], qubitReg : Qubit[]) : Int[] {
        // Calculate the number of qubits required for sorting
        let numBits = IntAsBoolArray(MaxInArray(inputArray))[0];
        // Calculate the number of iterations required for sorting
        let numIterations = Length(inputArray);
        mutable sortedArray = inputArray;
        
        // Loop through each bit from the most significant bit to the least significant bit
        for (bit in 0 .. numBits) {
            // Apply the Hadamard transform to create a superposition of the array
            ApplyToEach(H, qubitReg);
            
            // Apply conditional swap operations based on the current bit value
            for (i in 0 .. numIterations - 1) {
                let bitValue = (sortedArray[i] & (1 <<< (numBits - bit))) != 0;
                if (bitValue) {
                    // Conditionally swap elements if the current bit is set
                    SWAP(sortedArray[i], sortedArray[numIterations - 1]);
                }
            }
        }
        
        return sortedArray;
    }
}
