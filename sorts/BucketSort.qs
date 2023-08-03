namespace Sorting {
    open Microsoft.Quantum.Arrays;

    operation BucketSort(array : Qubit[]) : Unit {
        // Define the number of buckets
        let numBuckets = Length(array);

        // Create an array of empty lists to represent the buckets
        mutable buckets = [for _ in 0..numBuckets - 1 do new Qubit[]];

        // Distribute the elements of the input array into buckets
        for (i in 0 .. Length(array)-1) {
            let value = M(array[i]);
            let bucketIndex = IntAsIntC(value * IntAsDouble(numBuckets));
            mutable bucket = buckets[bucketIndex];
            set item = Copy(array[i]);
            set bucket = Append(bucket, item);
        }

        // Sort each bucket individually using Insertion Sort (or any other sorting algorithm)
        for (i in 0 .. Length(buckets)-1) {
            InsertionSort(buckets[i]);
        }

        // Concatenate the sorted buckets back into the original array
        mutable currentIndex = 0;
        for (i in 0 .. Length(buckets)-1) {
            let bucket = buckets[i];
            for (j in 0 .. Length(bucket)-1) {
                set array[currentIndex] = Copy(bucket[j]);
                set currentIndex += 1;
            }
            ResetAll(bucket);
        }
    }

    operation InsertionSort(array : Qubit[]) : Unit {
        for (i in 1 .. Length(array)-1) {
            for (j in i-1 .. -1 .. 0) {
                if (M(array[j]) <= M(array[j+1])) {
                    break;
                }
                SWAP(array[j], array[j+1]);
            }
        }
    }

    operation SWAP(q1 : Qubit, q2 : Qubit) : Unit {
        CNOT(q1, q2);
        CNOT(q2, q1);
        CNOT(q1, q2);
    }
}
