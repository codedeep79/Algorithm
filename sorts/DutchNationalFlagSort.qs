namespace Quantum.DutchNationalFlag {
    open Microsoft.Quantum.Primitive;

    // Helper function to swap elements in an array
    operation SwapElements (arr : Qubit[], idx1 : Int, idx2 : Int) : Unit {
        Body (...) {
            // XOR swap to exchange elements
            X(arr[idx1]);
            X(arr[idx2]);
            Controlled X([arr[idx1]], arr[idx2]);
            Controlled X([arr[idx2]], arr[idx1]);
            X(arr[idx2]);
            X(arr[idx1]);
        }
        Adjoint (...) {
            // The adjoint of swapping is the same as swapping.
            Controlled X([arr[idx1]], arr[idx2]);
            Controlled X([arr[idx2]], arr[idx1]);
            X(arr[idx2]);
            X(arr[idx1]);
            Controlled X([arr[idx1]], arr[idx2]);
            Controlled X([arr[idx2]], arr[idx1]);
        }
        Controlled (...) {
            // Controlled Swap is the same as swapping.
            CNOT([arr[idx1]], [arr[idx2]]);
            CNOT([arr[idx2]], [arr[idx1]]);
            CNOT([arr[idx1]], [arr[idx2]]);
            CNOT([arr[idx2]], [arr[idx1]]);
        }
    }

    // Implementation of Dutch National Flag Algorithm
    operation DutchNationalFlag (arr : Qubit[]) : Unit {
        Body (...) {
            mutable mid = Length(arr) - 1;
            mutable start = 0;

            // Loop through the array and sort the elements
            for (idx in 0..mid) {
                if (M(arr[idx]) == One) {
                    // Move 1 to the middle
                    SwapElements(arr, idx, mid);
                    set mid = mid - 1;
                    idx = idx - 1; // recheck the current index
                } elif (M(arr[idx]) == Zero) {
                    // Move 0 to the start
                    SwapElements(arr, idx, start);
                    set start = start + 1;
                }
            }
        }
        Adjoint (...) {
            // The adjoint of DutchNationalFlag is the same as DutchNationalFlag.
            mutable mid = Length(arr) - 1;
            mutable start = 0;

            // Loop through the array and sort the elements
            for (idx in 0..mid) {
                if (M(arr[idx]) == Zero) {
                    // Move 0 to the middle
                    SwapElements(arr, idx, mid);
                    set mid = mid - 1;
                    idx = idx - 1; // recheck the current index
                } elif (M(arr[idx]) == One) {
                    // Move 1 to the start
                    SwapElements(arr, idx, start);
                    set start = start + 1;
                }
            }
        }
        Controlled (...) {
            // Controlled DutchNationalFlag is the same as DutchNationalFlag.
            mutable mid = Length(arr) - 1;
            mutable start = 0;

            // Loop through the array and sort the elements
            for (idx in 0..mid) {
                if (M(arr[idx]) == Zero) {
                    // Move 0 to the middle
                    SwapElements(arr, idx, mid);
                    set mid = mid - 1;
                    idx = idx - 1; // recheck the current index
                } elif (M(arr[idx]) == One) {
                    // Move 1 to the start
                    SwapElements(arr, idx, start);
                    set start = start + 1;
                }
            }
        }
    }
}
