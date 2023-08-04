open Microsoft.Quantum.Intrinsic;
open Microsoft.Quantum.Canon;

namespace LinearSearch {
    // Define the operation to perform a linear search
    operation LinearSearchAlgorithm(target : Int, arr : Int[]) : Bool {
        // Iterate through the array
        for (idx in 0 .. Length(arr) - 1) {
            if (arr[idx] == target) {
                // If the target is found, return true
                return true;
            }
        }
        // If the target is not found, return false
        return false;
    }
}
