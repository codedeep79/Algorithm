namespace RecursiveInsertionSort {
    // Define a mutable array type to store elements in Q#.
    mutable array = Microsoft.Quantum.Arrays.Array;

    // Function to insert an element into a sorted sublist.
    operation InsertElement(sortedList : array, idx : Int, element : Int) : array {
        mutable sublist = sortedList;

        // Base case: If we reach the beginning of the list or the current element is greater than the element to insert,
        // insert the element at the current index and return the modified sublist.
        if (idx == 0 or sortedList[idx - 1] <= element) {
            set sublist = InsertAt(sortedList, idx, element);
            return sublist;
        }
        // Recursive case: Recursively move the element to the left until the correct position is found.
        else {
            set sublist = InsertElement(sortedList, idx - 1, element);
            return sublist;
        }
    }

    // Function to sort the entire array using recursive insertion sort.
    operation RecursiveInsertionSort(inputList : array) : array {
        mutable sortedList = inputList;

        // Base case: If the list is empty or contains only one element, it is already sorted.
        if (Length(inputList) <= 1) {
            return sortedList;
        }
        // Recursive case: Sort the sublist from the second element to the end.
        else {
            set sortedList = RecursiveInsertionSort(Tail(inputList));

            // Insert the first element (Head) into the sorted sublist.
            set sortedList = InsertElement(sortedList, Length(sortedList), Head(inputList));

            return sortedList;
        }
    }
}
