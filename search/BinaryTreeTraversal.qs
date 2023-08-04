namespace BinaryTreeTraversal {
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Diagnostics;
    newtype BinaryTree = (Int, BinaryTree?, BinaryTree?);
    operation InOrderTraversal(tree : BinaryTree) : Unit {
        if (tree == (0, _, _)) {
            return;
        }
        InOrderTraversal(tree!1);
        Message($"{tree!0}");
        InOrderTraversal(tree!2);
    }

    operation QuantumAlgorithm() : Unit {
        let tree = (1, (2, (4, _, _), (5, _, _)), (3, (6, _, _), (7, _, _)));

        InOrderTraversal(tree);
    }
}
