namespace BinaryInsertionSort {
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Convert;

    // Define the operation to perform binary insertion sort
    operation BinaryInsertionSort(arr : Qubit[]) : Unit {
        body {
            // Initialize variables
            let n = Length(arr);
            for (var i = 1; i < n; i++) {
                // Apply binary search to find the correct position for the current element
                let left = 0;
                let right = i;
                mutable index = 0;
                while (left < right) {
                    let mid = (left + right) / 2;
                    if (Measure(arr[mid])) {
                        set index = mid;
                        set left = mid + 1;
                    } else {
                        set right = mid;
                    }
                }

                // Insert the current element at the correct position in the sorted part of the array
                if (index != i) {
                    Controlled X([arr[index]], arr[i]);
                }
            }
        }
        adjoint invert {}
    }
}
