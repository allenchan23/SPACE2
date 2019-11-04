function res = compareKeys(K1, K2)

    if (K1(1) < K2(1))
        res = -1;
        return;
    elseif (K1(1) > K2(1))
        res = 1;
        return;
    end
    
   if (K1(2) < K2(2))
        res = -1;
        return;
    elseif (K1(2) > K2(2))
        res = 1;
        return;
   end
    
   res = 0;
   return;
end