namespace GnomeSort {
    open Microsoft.Quantum.Arrays;

    operation GnomeSort(arr : Qubit[]) : Unit {
        mutable i = 1;
        mutable j = 2;

        while (i < Length(arr)) {
            if (M(arr[i - 1]) > M(arr[i])) {
                X(arr[i - 1]);
                X(arr[i]);
                
                // Move back one position and compare again
                if (i > 1) {
                    i -= 1;
                    continue;
                }
            }

            // Move forward one position
            i = j;
            j += 1;
        }
    }
}
