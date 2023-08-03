namespace PancakeSort {
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Convert;

    // Function to flip the elements of an array up to the given index.
    operation FlipRange (arr : Qubit[], index : Int) : Unit {
        let mid = (index + 1) div 2;
        for (i in 0 .. mid - 1) {
            (arr[i], arr[index - i]) = (arr[index - i], arr[i]);
        }
    }

    // Function to find the index of the maximum element in the array.
    operation FindMaxIndex (arr : Qubit[], size : Int) : Int {
        mutable maxIndex = 0;
        for (i in 0 .. size - 1) {
            if (M(GetResultAsBool(arr[i]))) {
                maxIndex = i;
            }
        }
        return maxIndex;
    }

    // Main Pancake sort operation.
    operation PancakeSort (arr : Qubit[]) : Unit {
        let size = Length(arr);
        for (i in size downto 1) {
            // Find the index of the maximum element in the current array.
            let maxIndex = FindMaxIndex(arr, i);

            // If the maximum element is not at the first position, flip the array up to the maximum element.
            if (maxIndex != 0) {
                FlipRange(arr, maxIndex);
            }

            // Flip the array up to the current index to move the maximum element to the first position.
            FlipRange(arr, i - 1);
        }
    }
}
