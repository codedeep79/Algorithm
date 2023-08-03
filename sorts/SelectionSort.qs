namespace Quantum.SelectionSort {
    // Define a custom data type for the array of integers
    newtype IntArray = Int[];

    // Helper function to find the index of the minimum element in the array
    function FindMinIndex(array : IntArray, startIndex : Int) : Int {
        mutable minIndex = startIndex;
        mutable minValue = array[startIndex];
        for (i in startIndex + 1 .. Length(array) - 1) {
            if (array[i] < minValue) {
                set minValue = array[i];
                set minIndex = i;
            }
        }
        return minIndex;
    }

    // Helper function to swap two elements in the array
    operation SwapElements(array : IntArray, i : Int, j : Int) : Unit {
        mutable temp = array[i];
        set array[i] = array[j];
        set array[j] = temp;
    }

    // Selection sort algorithm
    operation SelectionSort(array : IntArray) : IntArray {
        for (i in 0 .. Length(array) - 1) {
            // Find the index of the minimum element in the unsorted part
            let minIndex = FindMinIndex(array, i);

            // Swap the minimum element with the first unsorted element
            if (minIndex != i) {
                SwapElements(array, i, minIndex);
            }
        }
        return array;
    }
}
