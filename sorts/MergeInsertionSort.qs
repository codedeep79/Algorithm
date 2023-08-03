namespace Quantum.MergeInsertionSort {
    open Microsoft.Quantum.Arrays;

    // Merge sort implementation
    operation MergeSort(input : Int[]) : Int[] {
        if Length(input) <= 1 {
            return input;
        } else {
            let mid = Length(input) / 2;
            let left = MergeSort(CopyRange(input, 0, mid));
            let right = MergeSort(CopyRange(input, mid, Length(input) - mid));
            return Merge(left, right);
        }
    }

    // Merge operation
    operation Merge(left : Int[], right : Int[]) : Int[] {
        mutable result = new Int[Length(left) + Length(right)];
        mutable i = 0;
        mutable j = 0;

        while (i < Length(left) && j < Length(right)) {
            if (left[i] <= right[j]) {
                set result w/= i+j <- left[i];
                set i += 1;
            } else {
                set result w/= i+j <- right[j];
                set j += 1;
            }
        }

        for (; i < Length(left); i += 1) {
            set result w/= i+j <- left[i];
        }

        for (; j < Length(right); j += 1) {
            set result w/= i+j <- right[j];
        }

        return result;
    }

    // Insertion sort implementation
    operation InsertionSort(input : Int[]) : Int[] {
        for (i in 1 .. Length(input) - 1) {
            let value = input[i];
            let j = i - 1;
            while (j >= 0 && input[j] > value) {
                set input w/= j+1 <- input[j];
                set j -= 1;
            }
            set input w/= j+1 <- value;
        }
        return input;
    }

    // Merge-insertion sort algorithm
    operation MergeInsertionSort(input : Int[]) : Int[] {
        let cutoff = 5; // Insertion sort is used for small subarrays

        if Length(input) <= cutoff {
            return InsertionSort(input);
        } else {
            let mid = Length(input) / 2;
            let left = MergeInsertionSort(CopyRange(input, 0, mid));
            let right = MergeInsertionSort(CopyRange(input, mid, Length(input) - mid));
            return Merge(left, right);
        }
    }
}
