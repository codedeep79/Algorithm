namespace KMPAlgorithm {
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Math;

    operation KMPAlgorithm(pattern : Qubit[], text : Qubit[]) : Unit {
        mutable failureFunction = new Int[Length(pattern)];
        set failureFunction = CalculateFailureFunction(pattern);

        mutable i = 0;
        mutable j = 0;

        while (i < Length(text)) {
            if (MeasureOne(text[i]) == One) {
                set i = i + 1;
                set j = j + 1;
            } else {
                set j = failureFunction[j];
            }

            if (j == Length(pattern)) {
                Message("Pattern found at position " + ToString(i - Length(pattern)));
                set j = failureFunction[j];
            }
        }
    }

    function CalculateFailureFunction(pattern : Qubit[]) : Int[] {
        mutable failureFunction = new Int[Length(pattern) + 1];
        set failureFunction = [0 | rest(CalculateFailureFunctionAux(pattern, 1, 0))];
        return failureFunction;
    }

    function CalculateFailureFunctionAux(pattern : Qubit[], i : Int, j : Int) : Int[] {
        if (i == Length(pattern)) {
            return [];
        } else {
            mutable failureFunction = [0];
            let nextJ = if (MeasureOne(pattern[i]) == One) then j + 1 else 0;
            set failureFunction = failureFunction + [nextJ | CalculateFailureFunctionAux(pattern, i + 1, nextJ)];
            return failureFunction;
        }
    }
}
