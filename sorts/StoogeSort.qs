namespace StoogeSort {
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Canon;

    operation StoogeSort(arr : Qubit[], startIndex : Int, endIndex : Int) : Unit is Adj {
        if (startIndex >= endIndex) {
            return;
        }

        // Compare first and last elements, swap if necessary
        ApplyToEach(H, arr![startIndex]);
        ApplyToEach(H, arr![endIndex]);
        Controlled X( [arr![startIndex]], (arr![endIndex], _) => X(_, arr![startIndex]) );
        Controlled X( [arr![startIndex]], (arr![endIndex], _) => X(_, arr![startIndex]) );
        ApplyToEach(H, arr![startIndex]);
        ApplyToEach(H, arr![endIndex]);

        // If there are more than two elements, recursively sort first two-thirds and last two-thirds
        let twoThird := (endIndex - startIndex + 1) / 3;
        if (startIndex + twoThird <= endIndex) {
            StoogeSort(arr, startIndex, endIndex - twoThird);
        }

        if (startIndex + twoThird + twoThird <= endIndex) {
            StoogeSort(arr, startIndex + twoThird, endIndex);
        }

        // Sort the remaining two-thirds again to ensure the whole array is sorted
        StoogeSort(arr, startIndex, endIndex - twoThird);
    }

    operation RunStoogeSort(inputArray : Int[]) : Int[] {
        mutable outputArray = ToQubits(inputArray);
        StoogeSort(outputArray, 0, Length(outputArray) - 1);
        return ToInts(outputArray);
    }
}
