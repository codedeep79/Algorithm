namespace QuickSortWithNormalDistribution {
    open Microsoft.Quantum.Arrays;

    operation Swap (arr : Qubit[], i : Int, j : Int) : Unit {
        if (i != j) {
            (M, M) = (M, M) + (arr[i], arr[j]);
            (X, X) = (X, X) + (arr[i], arr[j]);
            (M, M) = (M, M) + (arr[i], arr[j]);
        }
    }

    operation Partition (arr : Qubit[], low : Int, high : Int, pivot : Int) : Int {
        mutable i = low - 1;
        for idx in low .. high {
            if (MeasureInteger([arr[idx]]) == 0) {
                set i = i + 1;
                Swap(arr, i, idx);
            }
        }
        return i + 1;
    }

    operation QuickSort (arr : Qubit[], low : Int, high : Int) : Unit {
        if (low < high) {
            let pivot = Partition(arr, low, high, high);
            QuickSort(arr, low, pivot - 1);
            QuickSort(arr, pivot + 1, high);
        }
    }

    operation RunQuickSort () : Int[] {
        // Number of elements in the list
        let n = 10;

        // Generate a list of random numbers from a normal distribution
        mutable nums = new Int[n];
        using (qubits = Qubit[n]) {
            for (idx in 0 .. n - 1) {
                let num = Int(QuantumRandomNumber(NormalDistribution(0.0, 1.0)));
                set nums w/= [idx <- num];
            }
            // Print the unsorted list
            Message("Unsorted List: ", nums);

            // Sort the list using QuickSort
            QuickSort(qubits, 0, n - 1);

            // Measure the qubits to get the sorted list
            set nums = [MeasureInteger([q]) | q in qubits];
        }

        // Print the sorted list
        Message("Sorted List: ", nums);

        return nums;
    }
}
