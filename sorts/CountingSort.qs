namespace CountingSort {

    operation CountingSort(inputArray : Int[] ) : Int[] {
        // Find the maximum element in the array
        mutable maxElement = 0;
        for (value in inputArray) {
            if (value > maxElement) {
                set maxElement = value;
            }
        }

        // Create a frequency array to count occurrences of each element
        mutable frequency = new Int[maxElement + 1];
        for (value in inputArray) {
            set frequency w/= value <- frequency[value] + 1;
        }

        // Create a cumulative frequency array to determine positions of elements
        mutable cumulativeFrequency = new Int[maxElement + 1];
        mutable sum = 0;
        for (idx in 0 .. maxElement) {
            set sum += frequency[idx];
            set cumulativeFrequency w/= idx <- sum;
        }

        // Create the output sorted array
        mutable sortedArray = new Int[Length(inputArray)];
        for (value in inputArray) {
            set sortedArray with cumulativeFrequency[value] <- value;
            set cumulativeFrequency w/= value <- cumulativeFrequency[value] + 1;
        }

        return sortedArray;
    }
}
