namespace Quantum.Sorting {
    open Microsoft.Quantum.Intrinsic;

    operation RandomNormalDistributionQuickSort(array : Int[], left : Int, right : Int) : Unit {
        if (left < right) {
            let pivot = RandomNormalDistributionPivot(array, left, right);
            let pivotIndex = Partition(array, left, right, pivot);
            RandomNormalDistributionQuickSort(array, left, pivotIndex - 1);
            RandomNormalDistributionQuickSort(array, pivotIndex + 1, right);
        }
    }

    operation RandomNormalDistributionPivot(array : Int[], left : Int, right : Int) : Int {
        mutable total = 0.0;
        for (i in left .. right) {
            set total += array[i];
        }

        let average = total / IntAsDouble(right - left + 1);
        mutable variance = 0.0;
        for (i in left .. right) {
            set variance += PowD(IntAsDouble(array[i]) - average, 2.0);
        }
        set variance /= IntAsDouble(right - left + 1);
        set variance = Sqrt(variance);

        // Random normal distribution with mean = average and standard deviation = variance.
        mutable pivot = RoundToNearestInt(average + StandardNormalSample() * variance);
        set pivot = Max(left, Min(right, pivot)); // Make sure the pivot index is within the array bounds.

        return pivot;
    }

    operation Partition(array : Int[], left : Int, right : Int, pivot : Int) : Int {
        mutable pivotValue = array[pivot];
        // Move the pivot element to the rightmost position.
        (array[pivot], array[right]) = (array[right], array[pivot]);

        mutable i = left;
        for (j in left .. right - 1) {
            if (array[j] <= pivotValue) {
                (array[i], array[j]) = (array[j], array[i]);
                set i += 1;
            }
        }
        (array[i], array[right]) = (array[right], array[i]);

        return i;
    }
}
