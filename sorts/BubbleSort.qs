namespace BubbleSort {
    // Helper operation to swap two elements in an array
    operation Swap (arr : Qubit[], i : Int, j : Int) : Unit {
        if (i != j) {
            CNOT(arr[i], arr[j]);
            CNOT(arr[j], arr[i]);
            CNOT(arr[i], arr[j]);
        }
    }

    // Bubble Sort operation
    operation BubbleSort (arr : Qubit[]) : Unit {
        mutable n = Length(arr);
        for (i in 0 .. n - 1) {
            for (j in 0 .. n - i - 2) {
                if (M(arr[j]) > M(arr[j + 1])) {
                    Swap(arr, j, j + 1);
                }
            }
        }
    }
}
