namespace FibonacciSearch {

    open Microsoft.Quantum.Arrays;

    // Define the Fibonacci search operation.
    operation FibonacciSearch(target : Int, sortedArray : Int[]) : Int {
        // Calculate the Fibonacci numbers up to the length of the sorted array.
        mutable fibonacciNumbers = FibonacciSequence(Length(sortedArray));

        mutable left = 0;
        mutable mid = 0;
        mutable right = Length(sortedArray) - 1;

        // Search loop using Fibonacci numbers.
        while (left <= right) {
            // Calculate the mid position using the Fibonacci numbers.
            mid = left + fibonacciNumbers[Length(sortedArray) - 1 - fibonacciNumbers.Count()];
            if (mid >= Length(sortedArray)) {
                mid = Length(sortedArray) - 1;
            }

            let midValue = sortedArray[mid];

            // Check if the target element is found at the mid position.
            if (midValue == target) {
                return mid;
            }

            // If the target element is less than the mid value, restrict the search to the left subarray.
            elif (target < midValue) {
                right = mid - 1;
            }

            // If the target element is greater than the mid value, restrict the search to the right subarray.
            else {
                left = mid + 1;
            }
        }

        return -1;
    }

}
