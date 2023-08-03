namespace IntroSort {
    open Microsoft.Quantum.Arrays;

    // Introspective Sort implementation
    operation IntrospectiveSort(input : Qubit[]) : Unit {
        // Convert qubits to classical array for sorting
        let array = ApplyToEach(Auto, input);

        // Sort the array using Introspective Sort
        IntrospectiveSortImpl(array, 0, Length(array) - 1);

        // Convert the sorted array back to qubits
        SetArray(array, input);
    }

    // Implementation of Introspective Sort (Classical)
    function IntrospectiveSortImpl(array : Int[], low : Int, high : Int) : Unit {
        mutable partitionThreshold = 16;

        if (Length(array) <= 1) {
            return;
        } else if (Length(array) <= partitionThreshold) {
            InsertionSortImpl(array, low, high);
        } else if (low < high) {
            if (high - low <= partitionThreshold) {
                InsertionSortImpl(array, low, high);
            } else {
                let pivot = Partition(array, low, high);
                IntrospectiveSortImpl(array, low, pivot - 1);
                IntrospectiveSortImpl(array, pivot + 1, high);
            }
        }
    }

    // Implementation of Insertion Sort (Classical)
    function InsertionSortImpl(array : Int[], low : Int, high : Int) : Unit {
        for (let i = low + 1; i <= high; i++) {
            let j = i;
            while (j > low && array[j] < array[j - 1]) {
                let temp = array[j];
                set array w/= j <- array[j - 1];
                set array w/= (j - 1) <- temp;
                set j -= 1;
            }
        }
    }

    // Partition step of Introspective Sort
    function Partition(array : Int[], low : Int, high : Int) : Int {
        let pivot = array[high];
        mutable i = low - 1;

        for (let j = low; j < high; j++) {
            if (array[j] <= pivot) {
                set i += 1;
                let temp = array[i];
                set array w/= i <- array[j];
                set array w/= j <- temp;
            }
        }

        let temp = array[i + 1];
        set array w/= (i + 1) <- array[high];
        set array w/= high <- temp;

        return i + 1;
    }
}
