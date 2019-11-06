function path = DStarLiteSearch(Dest,Orig,k)

    global CELLH;
    global CELLL;
    global maxY;
    global maxX;
    global QUEUE;
    global MAP;
    global OBSTACLES;
    
    LIVEPLOT = false;
    
    ComputeShortestPath(Dest,Orig,k)  
    
    is = Orig.i;
    js = Orig.j;
    
    iDest = Dest.i;
    jDest = Dest.j;
    
    jl = js;
    il = is;
    path = [];
    
    while ~isDestination(is,js,iDest,jDest)
        
        [js, is] = nextPos(js,is); 
        jll = jl;
        ill = il;
        
        jl = js;
        il = is;
        change = false;
        
        coord = [MAP{js,is}.x, MAP{js,is}.y];
        path = [path;coord];
        
        current = [];
        
        ic = il;
        jc = jl;
        current = [jc,ic];
        
        if LIVEPLOT
            while ~isDestination(ic,jc,iDest,jDest)

                minVal = inf;

                if isValid(jc-1,ic)
                    if MAP{jc-1,ic}.rhs < minVal
                        minVal = MAP{jc-1,ic}.rhs;
                        in = ic;
                        jn = jc-1;
                    end
                end

                if isValid(jc,ic-1)
                    if MAP{jc,ic-1}.rhs < minVal
                        minVal = MAP{jc,ic-1}.rhs;
                        in = ic-1;
                        jn = jc;
                    end
                end   

               if isValid(jc+1,ic)
                    if MAP{jc+1,ic}.rhs < minVal
                        minVal = MAP{jc+1,ic}.rhs;
                        in = ic;
                        jn = jc+1;
                    end
                end

                if isValid(jc,ic+1)
                    if MAP{jc,ic+1}.rhs < minVal
                        minVal = MAP{jc,ic+1}.rhs;
                        in = ic+1;
                        jn = jc;
                    end
                end  

                if isValid(jc-1,ic+1)
                    if MAP{jc-1,ic+1}.rhs < minVal
                        minVal = MAP{jc-1,ic+1}.rhs;
                        in = ic+1;
                        jn = jc-1;
                    end
                end

                if isValid(jc+1,ic-1)
                    if MAP{jc+1,ic-1}.rhs < minVal
                        minVal = MAP{jc+1,ic-1}.rhs;
                        in = ic-1;
                        jn = jc+1;
                    end
                end   

               if isValid(jc+1,ic+1)
                    if MAP{jc+1,ic+1}.rhs < minVal
                        minVal = MAP{jc+1,ic+1}.rhs;
                        in = ic+1;
                        jn = jc+1;
                    end
                end

                if isValid(jc-1,ic-1)
                    if MAP{jc-1,ic-1}.rhs < minVal
                        minVal = MAP{jc-1,ic-1}.rhs;
                        in = ic-1;
                        jn = jc-1;
                    end
                end 

                next = [jn, in];
                current = [current;next];
                ic = in;
                jc = jn;            
            end

            hold on;
            p1 = plot(current(:,2),30-current(:,1)+1,'--r','linewidth',2);
            p2 = plot(path(:,2),30-path(:,1)+1,'-b','linewidth',5);
            p3 = plot(is,30-js+1,'ok','MarkerSize',10);
            drawnow;
            delete(p1);
            delete(p3);
        end
        
        if isValid(js-1,is)
            if ~OBSTACLES(js-1,is)
                change = true;
                MAP{js-1,is} = makeObstacle(MAP{js-1,is});
                MAP{js-1,is}.rhs = Inf;
                MAP{js-1,is}.g = Inf;
                plot(MAP{js-1,is}.x,MAP{js-1,is}.y,'ks','MarkerFaceColor','k');
                updateVertex(MAP{js,is},MAP{js,is},Dest,k);
            end
        end
        
        if isValid(js+1,is)              
            if ~OBSTACLES(js+1,is)
                change = true;
                MAP{js+1,is} = makeObstacle(MAP{js+1,is});
                MAP{js+1,is}.rhs = Inf;
                MAP{js+1,is}.g = Inf;
                plot(MAP{js+1,is}.x,MAP{js+1,is}.y,'ks','MarkerFaceColor','k');
                updateVertex(MAP{js,is},MAP{js,is},Dest,k);
            end          
        end
        
        if isValid(js,is-1)              
            if ~OBSTACLES(js,is-1)
                change = true;
                MAP{js,is-1} = makeObstacle(MAP{js,is-1});
                MAP{js,is-1}.rhs = Inf;
                MAP{js,is-1}.g = Inf;  
                plot(MAP{js,is-1}.x,MAP{js,is-1}.y,'ks','MarkerFaceColor','k');
                updateVertex(MAP{js,is},MAP{js,is},Dest,k);
            end        
        end
        
        if isValid(js,is+1)              
            if ~OBSTACLES(js,is+1)
                change = true;
                MAP{js,is+1} = makeObstacle(MAP{js,is+1});
                MAP{js,is+1}.rhs = Inf;
                MAP{js,is+1}.g = Inf; 
                plot(MAP{js,is+1}.x,MAP{js,is+1}.y,'ks','MarkerFaceColor','k');
                updateVertex(MAP{js,is},MAP{js,is},Dest,k);
            end          
        end
        
        if isValid(js+1,is+1)              
            if ~OBSTACLES(js+1,is+1)
                change = true;
                MAP{js+1,is+1} = makeObstacle(MAP{js+1,is+1});
                MAP{js+1,is+1}.rhs = Inf;
                MAP{js+1,is+1}.g = Inf; 
                plot(MAP{js+1,is+1}.x,MAP{js+1,is+1}.y,'ks','MarkerFaceColor','k');
                updateVertex(MAP{js,is},MAP{js,is},Dest,k);
            end         
        end
        
        if isValid(js-1,is+1)              
            if ~OBSTACLES(js-1,is+1)
                change = true;
                MAP{js-1,is+1} = makeObstacle(MAP{js-1,is+1});
                MAP{js-1,is+1}.rhs = Inf;
                MAP{js-1,is+1}.g = Inf;
                plot(MAP{js-1,is+1}.x,MAP{js-1,is+1}.y,'ks','MarkerFaceColor','k');
                updateVertex(MAP{js,is},MAP{js,is},Dest,k);
            end        
        end
        
        if isValid(js-1,is-1)              
            if ~OBSTACLES(js-1,is-1)
                change = true;
                MAP{js-1,is-1} = makeObstacle(MAP{js-1,is-1});
                MAP{js-1,is-1}.rhs = Inf;
                MAP{js-1,is-1}.g = Inf;  
                plot(MAP{js-1,is-1}.x,MAP{js-1,is-1}.y,'ks','MarkerFaceColor','k');
                updateVertex(MAP{js,is},MAP{js,is},Dest,k);
            end          
        end
        
        if isValid(js+1,is-1)              
            if ~OBSTACLES(js+1,is-1)
                change = true;
                MAP{js+1,is-1} = makeObstacle(MAP{js+1,is-1});
                MAP{js+1,is-1}.rhs = Inf;
                MAP{js+1,is-1}.g = Inf;   
                plot(MAP{js+1,is-1}.x,MAP{js+1,is-1}.y,'ks','MarkerFaceColor','k');
                updateVertex(MAP{js,is},MAP{js,is},Dest,k);
            end        
        end
        
        if (~change)
            jl = jll;
            il = ill;
        end
        ComputeShortestPath(Dest,Orig,k);
    end
        
end