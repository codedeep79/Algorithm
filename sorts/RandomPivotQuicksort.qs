namespace Quantum.Quicksort {
    open Microsoft.Quantum.Measurement;

    operation RandomPivotQuicksort(arr : Qubit[]) : Unit {
        // Base case: If the array has 0 or 1 element, it is already sorted.
        if Length(arr) <= 1 {
            return;
        }

        // Choose a random pivot element
        let pivotIndex = Random(Length(arr));

        // Partition the array around the pivot
        PartitionArray(arr, pivotIndex, _);

        // Apply Quicksort to the left and right subarrays
        RandomPivotQuicksort(Most(arr, pivotIndex));
        RandomPivotQuicksort(Most(arr, Length(arr) - pivotIndex - 1));
    }

    operation PartitionArray(arr : Qubit[], pivotIndex : Int, result : Int) : Unit {
        mutable left = 0;
        mutable right = Length(arr) - 1;

        while (left <= right) {
            // Find the first element greater than the pivot from the left
            while (left <= right && Compare(arr[left], arr[pivotIndex]) < 0) {
                set left += 1;
            }

            // Find the first element smaller than the pivot from the right
            while (right >= left && Compare(arr[right], arr[pivotIndex]) > 0) {
                set right -= 1;
            }

            // Swap the elements at left and right if they are in the wrong order
            if left <= right {
                if Compare(arr[left], arr[right]) != 0 {
                    SWAP(arr, left, right);
                }
                set left += 1;
                set right -= 1;
            }
        }
        set result = left;
    }

    operation SWAP(arr : Qubit[], i : Int, j : Int) : Unit {
        using (temp = Qubit()) {
            // Swap the elements at index i and j in the array
            X(arr[i]);
            X(arr[j]);
            Controlled X([temp], arr[i], arr[j]);
            Controlled X([temp], arr[j], arr[i]);
            X(arr[i]);
            X(arr[j]);
        }
    }

    function Compare(x : Qubit, y : Qubit) : Int {
        // Compare two qubits and return 0 if they are the same, 1 if x is greater, and -1 if y is greater
        let result = 0;
        if M(x) {
            set result = 1;
        }
        if M(y) {
            set result = -1;
        }
        return result;
    }
}
