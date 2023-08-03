namespace Quantum.Sorting {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;

    operation ExchangeSort(arr : Qubit[]) : Unit {
        // Determine the number of qubits in the array.
        let nQubits = Length(arr);

        // Apply the Exchange Sort algorithm.
        for i in 0 .. nQubits - 1 {
            for j in i + 1 .. nQubits {
                // Compare the qubits.
                if (M(arr[i]) == One && M(arr[j]) == Zero) {
                    // If the qubit at index i is greater than the qubit at index j,
                    // perform a swap operation.
                    X(arr[i]);
                    X(arr[j]);
                }
            }
        }
    }

    // Helper operation to measure and print the sorted array.
    operation MeasureArrayAndPrint(arr : Qubit[]) : Int[] {
        mutable result = new Int[Length(arr)];
        for i in 0 .. Length(arr) {
            set result w/= i <- M(arr[i]);
        }
        Message($"Sorted array: {result}");
        return result;
    }
}
