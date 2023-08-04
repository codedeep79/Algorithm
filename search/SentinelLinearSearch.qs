open Microsoft.Quantum.Intrinsic;
namespace SentinelSearch {
    // The operation that implements the sentinel linear search algorithm.
    operation SentinelLinearSearch(arr : Int[], target : Int) : Int {
        // Define the sentinel value to be searched for (target).
        mutable sentinel = target;
        
        // Add the sentinel value at the end of the array.
        set arr w/= Length(arr) <- sentinel;

        // Start the search from the first element.
        mutable index = 0;

        // Perform the search.
        while (arr[index] != sentinel) {
            set index = index + 1;
        }

        // If the index reaches the end of the array, the target was not found.
        if (index == Length(arr) - 1) {
            return -1;
        } else {
            return index;
        }
    }
}
