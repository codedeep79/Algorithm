namespace RecursiveMergeSort {

    // Define the merge sort operation
    operation MergeSort(inputArray : Int[], startIndex : Int, endIndex : Int) : Int[] {
        // Base case: if the array has one or zero elements, it is already sorted
        if (endIndex - startIndex <= 0) {
            return inputArray;
        }

        // Calculate the middle index to divide the array into two halves
        let middleIndex = startIndex + (endIndex - startIndex) / 2;

        // Recursively sort the left and right halves of the array
        let leftSortedArray = MergeSort(inputArray, startIndex, middleIndex);
        let rightSortedArray = MergeSort(inputArray, middleIndex + 1, endIndex);

        // Merge the sorted halves
        return Merge(leftSortedArray, rightSortedArray);
    }

    // Define the merge operation to merge two sorted arrays
    operation Merge(leftArray : Int[], rightArray : Int[]) : Int[] {
        mutable mergedArray = new Int[leftArray + rightArray].Zero();
        mutable leftIndex = 0;
        mutable rightIndex = 0;
        mutable mergedIndex = 0;

        // Merge the two sorted arrays
        while (leftIndex < Length(leftArray) and rightIndex < Length(rightArray)) {
            if (leftArray[leftIndex] < rightArray[rightIndex]) {
                set mergedArray w/= mergedIndex <- leftArray[leftIndex];
                set leftIndex += 1;
            } else {
                set mergedArray w/= mergedIndex <- rightArray[rightIndex];
                set rightIndex += 1;
            }
            set mergedIndex += 1;
        }

        // Copy any remaining elements from the left and right arrays
        while (leftIndex < Length(leftArray)) {
            set mergedArray w/= mergedIndex <- leftArray[leftIndex];
            set leftIndex += 1;
            set mergedIndex += 1;
        }
        while (rightIndex < Length(rightArray)) {
            set mergedArray w/= mergedIndex <- rightArray[rightIndex];
            set rightIndex += 1;
            set mergedIndex += 1;
        }

        return mergedArray;
    }

}
