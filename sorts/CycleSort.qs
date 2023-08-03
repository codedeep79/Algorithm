namespace Sorting {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Math;

    operation SwapCycleInPlace(arr : Qubit[], start : Int, cycleLen : Int) : Unit {
        if (cycleLen > 1) {
            mutable cycleStart = start;
            mutable temp = M(qubit);
            for (i in 0 .. cycleLen - 2) {
                SWAP(arr[cycleStart + i], temp);
                Controlled X([arr[cycleStart + i]], (cycleStart + i + 1) .. (cycleStart + cycleLen - 1), temp);
            }
            SWAP(arr[cycleStart + cycleLen - 1], temp);
        }
    }

    operation CycleSort(arr : Qubit[]) : Unit {
        let n = Length(arr);

        for (cycleStart in 0 .. n - 2) {
            mutable item = arr[cycleStart];
            mutable pos = cycleStart;

            for (i in cycleStart + 1 .. n - 1) {
                if (M(arr[i]) < M(item)) {
                    set item = arr[i];
                    set pos = i;
                }
            }

            if (pos != cycleStart) {
                SwapCycleInPlace(arr, cycleStart, pos - cycleStart + 1);
            }
        }
    }
}
