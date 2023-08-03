namespace PatienceSort {
    open Microsoft.Quantum.Measurement;

    operation Sort(input : Int[]) : Int[] {
        mutable piles = new Int[0][];
        for (i in input) {
            // Find the correct pile to add the element
            mutable pileIdx = -1;
            for (idx in 0..Length(piles)-1) {
                if (Length(piles[idx]) > 0 && piles[idx][Length(piles[idx])-1] > i) {
                    pileIdx = idx;
                    break;
                }
            }
            if (pileIdx == -1) {
                // If no existing pile can hold the element, create a new pile
                piles += [i];
            } else {
                // Add the element to the correct pile
                mutable pile = piles[pileIdx];
                pile += [i];
                piles w/= pileIdx;
                piles += pile;
            }
        }

        // Merge the piles to get the sorted list
        mutable sortedList = new Int[0];
        for (pile in piles) {
            sortedList += pile;
        }

        return sortedList;
    }
}
