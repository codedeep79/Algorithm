namespace WiggleSort {
    open Microsoft.Quantum.Arrays;

    operation SwapWithNext (arr : Int[][], index : Int) : Unit {
        mutable temp = arr[index];
        set arr w/= index <- arr[index + 1];
        set arr w/= index + 1 <- temp;
    }

    operation WiggleSort (arr : Int[][]) : Int[][] {
        for i in 0..Length(arr) - 2 {
            if i % 2 == 0 {
                if arr[i] > arr[i + 1] {
                    SwapWithNext(arr, i);
                }
            } else {
                if arr[i] < arr[i + 1] {
                    SwapWithNext(arr, i);
                }
            }
        }
        return arr;
    }
}
