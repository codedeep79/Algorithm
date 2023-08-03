namespace IterativeMergeSort {
    open Microsoft.Quantum.Convert;

    // Function to merge two sorted arrays
    function MergeArrays(arr1 : Int[], arr2 : Int[]) : Int[] {
        mutable merged = new Int[Length(arr1) + Length(arr2)];
        mutable i = 0;
        mutable j = 0;
        mutable k = 0;

        while (i < Length(arr1) && j < Length(arr2)) {
            if (arr1[i] < arr2[j]) {
                set merged w/= [k] <- arr1[i];
                set i += 1;
            } else {
                set merged w/= [k] <- arr2[j];
                set j += 1;
            }
            set k += 1;
        }

        while (i < Length(arr1)) {
            set merged w/= [k] <- arr1[i];
            set i += 1;
            set k += 1;
        }

        while (j < Length(arr2)) {
            set merged w/= [k] <- arr2[j];
            set j += 1;
            set k += 1;
        }

        return merged;
    }

    // Function to perform iterative merge sort
    operation IterativeMergeSort(inputArray : Int[]) : Int[] {
        mutable arrays = new List<Int[]>();

        // Split input array into individual elements
        for (item in inputArray) {
            set arrays += [item];
        }

        // Perform merging of arrays until a single sorted array is obtained
        while (Length(arrays) > 1) {
            for (i in 0 .. 1 .. Length(arrays) - 1) {
                if (i + 1 < Length(arrays)) {
                    set arrays w/= [i] <- MergeArrays(arrays[i], arrays[i + 1]);
                    set arrays w/= [i + 1] <- new Int[0];
                }
            }
            set arrays = Filter(Length, arrays);
        }

        return arrays[0];
    }
}
