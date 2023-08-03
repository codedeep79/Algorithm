namespace OddEvenSort {
    open Microsoft.Quantum.Measurement;

    operation OddEvenSort(input : Qubit[]) : Unit {
        let n = Length(input);
        for (i in 1..n) {
            // Apply odd-even comparisons in parallel
            if (i % 2 == 1) {
                ApplyOddEvenComparison(input);
            }
            
            // Measure and collapse the qubits to perform a classical exchange step
            for (j in 0..n - 2) {
                MeasureTwoAndSwap(input[j], input[j + 1]);
            }
        }
    }

    operation ApplyOddEvenComparison(input : Qubit[]) : Unit {
        let n = Length(input);
        for (i in 0..n - 2) {
            Controlled X([input[i]], input[i + 1]);
        }
    }

    operation MeasureTwoAndSwap(q1 : Qubit, q2 : Qubit) : Unit {
        // Measure two qubits in the computational basis
        let m1 = M(q1);
        let m2 = M(q2);

        // Classical swap based on measurement results
        if (m1 != m2) {
            X(q1);
            X(q2);
        }
    }
}
