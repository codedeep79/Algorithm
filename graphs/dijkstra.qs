namespace QuantumDijkstra {
    open Microsoft.Quantum.Diagnostics;

    operation Graph(): (Int, Int, Int, Int)[] {
        return [ (0, 1, 4, 0), (0, 2, 1, 0), (1, 2, 2, 0), (1, 3, 5, 0), (2, 3, 1, 0) ];
    }

    operation FindMinimumDistanceNode(distances : Qubit[], n : Int) : Int {
        mutable minIndex = 0;
        mutable minValue = 1000;

        for (i in 0 .. n - 1) {
            let value = M(distances[i]);
            if (value > 0 && value < minValue) {
                set minIndex = i;
                set minValue = value;
            }
        }
        return minIndex;
    }

    operation Dijkstra() : Int[] {
        let graph = Graph();
        let n = 4; 

        mutable distances = new Qubit[n];
        for (i in 0 .. n - 1) {
            set distances w/= i <- Microsoft.Quantum.Convert.IntAsBool(i == 0);
        }


        for (i in 0 .. n - 1) {
            let minIndex = FindMinimumDistanceNode(distances, n);
            Message($"Visiting Node {minIndex}");

            for (edge in graph) {
                if (edge[0] == minIndex) {
                    let neighbor = edge[1];
                    let weight = edge[2];
                    mutable currentDistance = distances[neighbor];
                    if (M(currentDistance) == 0) {
                        set distances w/= neighbor <- Microsoft.Quantum.Convert.IntAsBool(NotBool(M(currentDistance)) or weight < M(distances[minIndex]) + weight);
                    }
                }
            }
            set distances[minIndex] = One;
        }

        mutable result = new Int[n];
        for (i in 0 .. n - 1) {
            set result w/= i <- M(distances[i]);
            Reset(distances[i]);
        }

        return result;
    }

    entrypoint() : Unit {
        let shortestDistances = Dijkstra();
        Message($"Shortest distances: {shortestDistances}");
    }
}
