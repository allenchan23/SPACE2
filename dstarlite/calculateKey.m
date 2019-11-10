function key = calculateKey(V,S,k)
    key = [min([V.g,V.rhs]) + calculateH(V,S) + k, min([V.g,V.rhs])];
end