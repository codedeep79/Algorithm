namespace OddEvenSort {
    // Define a mutable array to hold the list to be sorted
    mutable arr = new Int[0];

    // Operation to perform a single pass of the Odd-Even Sort algorithm
    operation OddEvenSortPass() : Unit {
        for (i in 0..Length(arr) - 2) {
            if (i % 2 == 0) {
                // Compare and swap elements at even indices
                if (arr[i] > arr[i + 1]) {
                    (arr[i], arr[i + 1]) = (arr[i + 1], arr[i]);
                }
            } else {
                // Compare and swap elements at odd indices
                if (arr[i] < arr[i + 1]) {
                    (arr[i], arr[i + 1]) = (arr[i + 1], arr[i]);
                }
            }
        }
    }

    // Operation to perform the Odd-Even Sort on the input array
    operation OddEvenSort(inputArray : Int[]) : Int[] {
        // Copy the input array to the mutable array for sorting
        set arr = Copy(inputArray);

        // Perform the Odd-Even Sort repeatedly until the list is sorted
        for (i in 0..Length(arr) - 1) {
            OddEvenSortPass();
        }

        // Return the sorted array
        return arr;
    }
}
