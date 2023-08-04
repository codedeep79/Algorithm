operation JumpSearch(list : Int[], target : Int, stepSize : Int) : Int {
    // Initialize variables
    mutable index = 0;
    mutable jump = stepSize;
    let listSize = Length(list);

    // Perform jump ahead search
    while (index < listSize && list[index] < target) {
        Set(index, Min(index + stepSize, listSize - 1));
        Set(jump, stepSize);
    }

    // Perform linear search in the range
    for i in Range(0, jump) {
        if (index + i >= listSize) {
            return -1; // Target element not found
        }
        if (list[index + i] == target) {
            return index + i; // Target element found
        }
    }

    return -1; // Target element not found
}
