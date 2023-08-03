namespace Sorting {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    operation InsertionSort(arr : Qubit[]) : Unit {
        let n = Length(arr);
        for (i in 1..n-1) {
            for (j in i-1..0 step -1) {
                let x = arr[j];
                let y = arr[j + 1];
                CompareExchange(x, y);
                set arr w/= [j + 1] <- y;
                set arr w/= [j] <- x;
            }
        }
    }
}
