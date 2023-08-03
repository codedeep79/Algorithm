namespace Quantum.ShellSort {
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Diagnostics;

    // Shell Sort implementation
    operation ShellSort(input : Int[], gaps : Int[]) : Int[] {
        mutable arr = input;
        let n = Length(arr);
        for (gap in gaps) {
            for (i in gap .. n - 1) {
                let temp = arr[i];
                let j = i;
                while (j >= gap and arr[j - gap] > temp) {
                    set arr w/= [i => arr[j - gap], j - gap => temp];
                    set j = j - gap;
                }
            }
        }
        return arr;
    }
}
