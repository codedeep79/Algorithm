namespace NaturalSort {
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Convert;

    operation NaturalSort(input: String[], sorted: String[]) : Unit {
        // Create a copy of the input array to avoid modifying the original array.
        mutable arr = input;

        // Sort the array using the natural sort algorithm.
        QuickSortNatural(arr, 0, Length(arr) - 1);

        // Copy the sorted array to the output parameter.
        set sorted = arr;
    }

    // Helper function to perform quicksort with natural sorting.
    operation QuickSortNatural(arr: String[], left: Int, right: Int) : Unit {
        mutable l = left;
        mutable r = right;
        let pivot = arr[(left + right) / 2];

        while (l <= r) {
            while (CompareNatural(arr[l], pivot) < 0) {
                l += 1;
            }

            while (CompareNatural(arr[r], pivot) > 0) {
                r -= 1;
            }

            if (l <= r) {
                (arr[l], arr[r]) = (arr[r], arr[l]);
                l += 1;
                r -= 1;
            }
        }

        if (left < r) {
            QuickSortNatural(arr, left, r);
        }

        if (l < right) {
            QuickSortNatural(arr, l, right);
        }
    }

    // Helper function to compare two strings in a natural way.
    operation CompareNatural(a: String, b: String) : Int {
        mutable aChars = Characters(a);
        mutable bChars = Characters(b);

        while (Length(aChars) > 0 && Length(bChars) > 0) {
            if (IsInt(aChars[0]) && IsInt(bChars[0])) {
                let aNum = ParseInt(ToString(aChars), NumberFormat.Decimal);
                let bNum = ParseInt(ToString(bChars), NumberFormat.Decimal);
                if (aNum != bNum) {
                    return Compare(aNum, bNum);
                }
            } else {
                if (aChars[0] != bChars[0]) {
                    return Compare(aChars[0], bChars[0]);
                }
            }

            aChars = Drop(aChars, 1);
            bChars = Drop(bChars, 1);
        }

        if (Length(aChars) > 0) {
            return 1;
        } else if (Length(bChars) > 0) {
            return -1;
        } else {
            return 0;
        }
    }
}
