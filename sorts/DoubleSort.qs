namespace DoubleSortAlgorithm {
    open Microsoft.Quantum.Arrays;

    operation DoubleSort(inputArray : Int[][]) : Int[][] {
        // Sort the array in ascending order
        let sortedArray = StableSort(inputArray, CompareIntArrays);

        // Sort the sortedArray in descending order
        let doubleSortedArray = Reverse(StableSort(sortedArray, CompareIntArrays));

        return doubleSortedArray;
    }

    // Define a comparator to compare integer arrays
    function CompareIntArrays(arr1 : Int[], arr2 : Int[]) : Int {
        for (i in 0 .. Length(arr1) - 1) {
            if (arr1[i] > arr2[i]) {
                return 1; // arr1 is greater than arr2
            } elif (arr1[i] < arr2[i]) {
                return -1; // arr1 is less than arr2
            }
        }
        return 0; // arr1 and arr2 are equal
    }
}
