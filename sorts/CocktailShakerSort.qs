namespace Sorting {
    // Define an operation to perform the Cocktail Shaker Sort
    operation CocktailShakerSort (arr : Qubit[]) : Unit {
        mutable swapped = true;
        mutable start = 0;
        mutable end = Length(arr) - 1;

        // Keep iterating until no swaps are made
        while (swapped) {
            swapped = false;

            // Move from left to right, similar to the Bubble Sort
            for (i in start .. end - 1) {
                if (M(arr[i]) > M(arr[i+1])) {
                    SWAP(arr[i], arr[i+1]);
                    set swaped = true;
                }
            }
            if (not swapped) {
                // If no swaps are made, the array is already sorted
                break;
            }

            // Move from right to left
            for (i in end - 1 .. start - 1 by -1) {
                if (M(arr[i]) > M(arr[i+1])) {
                    SWAP(arr[i], arr[i+1]);
                    set swapped = true;
                }
            }
            // Increment the start and decrement the end
            set start = start + 1;
            set end = end - 1;
        }
    }

    // Helper operation to perform the swap of two qubits
    operation SWAP (q1 : Qubit, q2 : Qubit) : Unit is Adj+Ctl {
        X(q1);
        X(q2);
        Controlled X([q1], q2);
        X(q1);
        X(q2);
    }
}
