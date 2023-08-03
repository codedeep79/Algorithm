namespace Quantum.Combsort {
    open Microsoft.Quantum.Primitive;

    operation CombSort(arr : Qubit[], length : Int) : Unit {
        mutable gap = length;
        mutable swapped = true;

        while (gap > 1 or swapped) {
            gap = FloorI(gap / 1.3);
            if (gap < 1) {
                set gap = 1;
            }

            set swapped = false;

            for (i in 0 .. length - gap - 1) {
                if (M(arr[i]) > M(arr[i + gap])) {
                    SWAP(arr[i], arr[i + gap]);
                    set swapped = true;
                }
            }
        }
    }

    operation SWAP(a : Qubit, b : Qubit) : Unit {
        X(a); X(b);
    }
}
