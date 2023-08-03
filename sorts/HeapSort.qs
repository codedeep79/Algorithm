namespace Sorting {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Measurement;

    // Helper operation to swap two elements in an array.
    operation Swap (arr : Qubit[], i : Int, j : Int) : Unit {
        Body.ApplyTo([arr[i], arr[j]], Xor);
    }

    // Operation to build a max-heap from an array.
    operation BuildMaxHeap (arr : Qubit[], n : Int) : Unit {
        for (i in 1..(n-1) / 2) {
            let parent = i - 1;
            let left = 2 * i - 1;
            let right = 2 * i;

            // Compare parent with its left and right child.
            // Swap parent with the larger child if necessary.
            if (ResultArray.GetMeasurements([arr[parent], arr[left]])) {
                Swap(arr, parent, left);
            }
            if (right < n && ResultArray.GetMeasurements([arr[parent], arr[right]])) {
                Swap(arr, parent, right);
            }
        }
    }

    // Operation to perform Heap Sort on an array.
    operation HeapSort (arr : Qubit[], n : Int) : Unit {
        // Build a max-heap from the input array.
        BuildMaxHeap(arr, n);

        // Extract elements one by one from the max-heap to get the sorted array.
        for (i in n-1...0 step -1) {
            Swap(arr, 0, i);
            for (j in 0..i-1) {
                let parent = j;
                let left = 2 * j + 1;
                let right = 2 * j + 2;

                // Compare parent with its left and right child.
                // Swap parent with the larger child if necessary.
                if (ResultArray.GetMeasurements([arr[parent], arr[left]])) {
                    Swap(arr, parent, left);
                }
                if (right < i && ResultArray.GetMeasurements([arr[parent], arr[right]])) {
                    Swap(arr, parent, right);
                }
            }
        }
    }
}
