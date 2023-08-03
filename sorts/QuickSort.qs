namespace Sorting {
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Convert;

    // Main entry point of the program
    operation QuickSort(inputArray : Int[], left : Int, right : Int) : Unit {
        mutable array = inputArray;
        if (left < right) {
            // Partition the array and get the pivot index
            let pivotIndex = Partition(array, left, right);
            
            // Recursively sort the left and right subarrays
            QuickSort(array, left, pivotIndex - 1);
            QuickSort(array, pivotIndex + 1, right);
        }
    }

    // Partition operation to select the pivot and arrange the array
    operation Partition(array : Int[], left : Int, right : Int) : Int {
        let pivotValue = array[right];
        mutable pivotIndex = left - 1;
        
        for (index in left..right-1) {
            if (array[index] <= pivotValue) {
                pivotIndex += 1;
                (array[pivotIndex], array[index]) = (array[index], array[pivotIndex]);
            }
        }

        // Move the pivot to its correct position
        (array[pivotIndex + 1], array[right]) = (array[right], array[pivotIndex + 1]);
        
        // Return the pivot index
        return pivotIndex + 1;
    }
}
