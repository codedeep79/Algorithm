namespace Quantum.QuickSort {
    open Microsoft.Quantum.Arrays;

    operation QuickSort(input : Qubit[]) : Unit {
        // Apply the QuickSort algorithm to the input array
        ApplyQuickSort(input, 0, Length(input) - 1);
    }

    operation ApplyQuickSort(input : Qubit[], low : Int, high : Int) : Unit {
        if (low < high) {
            // Partition the input array
            let pivotIdx = Partition(input, low, high);

            // Apply QuickSort recursively to the sub-lists
            ApplyQuickSort(input, low, pivotIdx - 1);
            ApplyQuickSort(input, pivotIdx + 1, high);
        }
    }

    operation Partition(input : Qubit[], low : Int, high : Int) : Int {
        // Choose the pivot element (here we choose the last element)
        let pivotValue = M(input[high]);

        mutable i = low - 1;
        for idx in low .. high - 1 {
            if (M(input[idx]) < pivotValue) {
                i = i + 1;
                // Swap input[i] and input[idx]
                SWAP(input, i, idx);
            }
        }

        // Swap input[i + 1] and input[high] (the pivot)
        SWAP(input, i + 1, high);

        // Return the index of the pivot after partitioning
        return i + 1;
    }

    operation SWAP(input : Qubit[], i : Int, j : Int) : Unit is Adj {
        if (i != j) {
            (input[i], input[j]) = (input[j], input[i]);
        }
    }
}
