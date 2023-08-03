namespace StrandSort {
    // Operation to merge two sorted arrays
    operation MergeSortedArrays(inputArray1 : Int[], inputArray2 : Int[]) : Int[] {
        mutable mergedArray = new Int[Length(inputArray1) + Length(inputArray2)];
        mutable i = 0;
        mutable j = 0;
        mutable k = 0;

        while (i < Length(inputArray1) && j < Length(inputArray2)) {
            if (inputArray1[i] < inputArray2[j]) {
                set mergedArray w/= k <- inputArray1[i];
                set i += 1;
            } else {
                set mergedArray w/= k <- inputArray2[j];
                set j += 1;
            }
            set k += 1;
        }

        while (i < Length(inputArray1)) {
            set mergedArray w/= k <- inputArray1[i];
            set i += 1;
            set k += 1;
        }

        while (j < Length(inputArray2)) {
            set mergedArray w/= k <- inputArray2[j];
            set j += 1;
            set k += 1;
        }

        return mergedArray;
    }

    // Recursive operation to perform Strand sort on an input array
    operation StrandSort(inputArray : Int[]) : Int[] {
        if (Length(inputArray) <= 1) {
            return inputArray;
        }

        mutable sublist = new Int[0];
        mutable remainingArray = inputArray;

        for (i in 0..Length(inputArray)-1) {
            if (Length(sublist) == 0) {
                set sublist = new Int[]([inputArray[i]]);
            } else {
                if (inputArray[i] >= sublist[Length(sublist)-1]) {
                    set sublist += [inputArray[i]];
                } else {
                    set remainingArray = Slice(remainingArray, 1, Length(remainingArray)-1);
                }
            }
        }

        set remainingArray = Slice(remainingArray, 0, Length(remainingArray)-1);
        set sublist = StrandSort(MergeSortedArrays(sublist, remainingArray));

        return sublist;
    }
}
