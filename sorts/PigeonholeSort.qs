namespace PigeonholeSort {
    // Define the Pigeonhole Sort operation
    operation PigeonholeSort(arr : Qubit[], minVal : Int, maxVal : Int) : Unit {
        mutable freqTable = new Int[maxVal - minVal + 1];
        mutable index = 0;
        
        // Count the frequency of each value in the array
        for (i in 0 .. Length(arr) - 1) {
            let value = M(arr[i]);
            set freqTable w/= value <- freqTable[value] + 1;
        }
        
        // Reconstruct the sorted array using the frequency table
        for (i in 0 .. Length(freqTable) - 1) {
            repeat (freqTable[i]) {
                X(arr[index]);
                set index = index + 1;
            }
        }
    }
}
