namespace TreeTraversal {
    open Microsoft.Quantum.Intrinsic;
    newtype TreeNode = (Int, TreeNode?, TreeNode?);
    operation DepthFirstTraversal(root : TreeNode) : Unit {
        BodyTraverse(root);
    }
    operation BodyTraverse(node : TreeNode) : Unit {
        Message($"Visited Node: {node[0]}");
        if (not IsResultZero(M, node[1])) {
            BodyTraverse(M!Borrow(node[1]));
        }
        if (not IsResultZero(M, node[2])) {
            BodyTraverse(M!Borrow(node[2]));
        }
    }
}
