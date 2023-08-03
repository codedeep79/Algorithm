namespace MyNamespace {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    operation BinarySearch (sortedArray : Int[], target : Int) : Int {
        mutable left = 0;
        mutable right = Length(sortedArray) - 1;

        while (left <= right) {
            let mid = (left + right) / 2;
            let midValue = sortedArray[mid];
            
            if (midValue == target) {
                return mid;
            } elif (midValue < target) {
                set left = mid + 1;
            } else {
                set right = mid - 1;
            }
        }
        return -1;
    }
}
