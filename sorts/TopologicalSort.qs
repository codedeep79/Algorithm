namespace Quantum.TopologicalSort {
    open Microsoft.Quantum.Arrays;

    operation TopologicalSort(adjList : Int[][]; startNode : Int) : Int[] {
        mutable stack = new Int[0];
        mutable visited = new Int[Length(adjList)];
        mutable result = new Int[0];

        // Helper function for DFS
        function DFS(node : Int) : Unit {
            if (visited[node] == 1) {
                return;
            }

            set visited w/= node;
            for (neighbor in adjList[node]) {
                DFS(neighbor);
            }
            set stack += [node];
        }

        // Perform DFS from the start node
        DFS(startNode);

        // Pop nodes from the stack to obtain the topological order
        for (i in 0 .. Length(adjList) - 1) {
            let node = stack[Length(stack) - 1 - i];
            set result += [node];
        }

        return result;
    }
}
