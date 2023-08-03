namespace OddEvenSort {
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Arrays;

    operation OddEvenSortAlgorithm(arr : Qubit[]) : Unit is Adj {
        let n = Length(arr);
        for i in 0 .. n - 1 {
            if i % 2 == 0 {
                // Odd-phase sorting
                for j in 1 .. n - 1 step 2 {
                    if M(arr[j - 1]) < M(arr[j]) {
                        SWAP(arr[j - 1], arr[j]);
                    }
                }
            } else {
                // Even-phase sorting
                for j in 1 .. n - 2 step 2 {
                    if M(arr[j]) > M(arr[j + 1]) {
                        SWAP(arr[j], arr[j + 1]);
                    }
                }
            }
        }
    }

    operation SortAndMeasure(arr : Qubit[]) : Result[] {
        OddEvenSortAlgorithm(arr);
        return MultiM(arr);
    }
}
