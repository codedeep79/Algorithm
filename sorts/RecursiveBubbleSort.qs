namespace RecursiveBubbleSort {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;

    // Recursive function to perform the bubble sort algorithm.
    operation BubbleSortRecursive(arr : Qubit[], length : Int) : Unit {
        // Base case: if the array has length 1, it is already sorted.
        if (length <= 1) {
            return;
        }

        // Perform one pass of bubble sort to move the largest element to the end.
        for (i in 0..length - 2) {
            if (M(arr[i]) > M(arr[i + 1])) {
                X(arr[i]);
                X(arr[i + 1]);
            }
        }

        // Recursively sort the remaining (length - 1) elements.
        within {
            ApplyToEachCA(BubbleSortRecursive(_, length - 1), arr[0..length - 2]);
        } apply {
            // Perform one more pass to move the second largest element to the second last position.
            for (i in 0..length - 3) {
                if (M(arr[i]) > M(arr[i + 1])) {
                    X(arr[i]);
                    X(arr[i + 1]);
                }
            }
        }
    }

    // Driver operation to sort the input array using bubble sort.
    operation RunBubbleSort() : Unit {
        // Initialize the array to be sorted.
        mutable arr = new Qubit[5];
        for (i in 0..4) {
            set arr w/= i <- Zero;
        }

        // Set the elements of the array.
        X(arr[0]);
        X(arr[1]);
        X(arr[3]);

        // Print the unsorted array.
        Message("Unsorted array:");
        for (i in 0..4) {
            Message($"{i} : {M(arr[i])}");
        }

        // Sort the array using bubble sort.
        BubbleSortRecursive(arr, 5);

        // Print the sorted array.
        Message("Sorted array:");
        for (i in 0..4) {
            Message($"{i} : {M(arr[i])}");
        }

        // Release qubits.
        ResetAll(arr);
    }
}
