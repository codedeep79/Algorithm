namespace Quantum.PrimAlgorithm {

    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Measurement;

    // Define the custom operation to find the minimum-weight edge
    @SuppressWarnings("fail-message", "QS6205")
    operation FindMinimumWeightEdge(adjMatrix : Int[][]; edges : Int[][]) : (Int, Int) {
        mutable minWeight = Int.MaxValue;
        mutable minEdge = (0, 0);
        for idxEdge in 0 .. Length(edges) - 1 {
            let (src, dest) = edges[idxEdge];
            if adjMatrix[src][dest] < minWeight {
                set minWeight = adjMatrix[src][dest];
                set minEdge = (src, dest);
            }
        }
        return minEdge;
    }

    // Define the main operation for Prim's algorithm
    operation PrimAlgorithm (adjMatrix : Int[][]) : (Int[], Int[][]) {
        // Initialize variables for the minimum spanning tree
        mutable nVertices = Length(adjMatrix);
        mutable minSpanningTreeEdges = new Int[nVertices - 1][2];
        mutable selectedVertices = new Int[nVertices];
        set selectedVertices = [0]; // Start with vertex 0 as the initial vertex

        // Loop until all vertices are included in the MST
        for idx in 0 .. nVertices - 2 {
            // Find the minimum-weight edge between selected and unselected vertices
            let edges = [ for src in selectedVertices { for dest in 0 .. nVertices - 1 { if not (dest in selectedVertices) then (src, dest) else (-1, -1) } }];
            let (src, dest) = FindMinimumWeightEdge(adjMatrix, edges);

            // Add the edge to the minimum spanning tree
            set minSpanningTreeEdges w/= idx <- (src, dest);
            set selectedVertices += [dest];
        }

        return (selectedVertices, minSpanningTreeEdges);
    }
}
