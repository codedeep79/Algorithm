namespace AhoCorasick {
    open Microsoft.Quantum.Measurement;

    newtype TrieNode = (Int, Bool, Int[]);
    operation AddPattern(pattern : Int[], root : TrieNode) : TrieNode {
        mutable currentNode = root;
        for (index in pattern) {
            mutable children = snd(currentNode);
            let childExists = false;
            for (i in 0 .. Length(children) - 1) {
                if (children[i] == index) {
                    set childExists = true;
                }
            }
            if (not childExists) {
                set children += [index];
            }
            set currentNode = (currentNode[0], currentNode[1], children);
        }
        return currentNode;
    }

    operation ConstructTrie(patterns : Int[][]) : TrieNode {
        let root = (0, false, []);
        for (pattern in patterns) {
            set root = AddPattern(pattern, root);
        }
        return root;
    }

    // Function to search for patterns in the input text using the Trie
    operation SearchPatterns(input : Int[], root : TrieNode) : Unit {
        mutable currentNode = root;
        for (index in input) {
            let children = snd(currentNode);
            for (child in children) {
                if (child == index) {
                    set currentNode = (currentNode[0], true, children);
                }
            }
        }
        if (currentNode[1]) {
            Message("Pattern found!");
        } else {
            Message("Pattern not found!");
        }
    }
}
