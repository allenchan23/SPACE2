function path = DStarLiteSearch(Dest,Orig,k)

    global CELLH;
    global CELLL;
    global maxY;
    global maxX;
    global QUEUE;
    global MAP;
    global OBSTACLES;
    
    ComputeShortestPath(Dest,Orig,k)  
%     x = [];
%     y = [];
%     z = [];
%     for i = 1:CELLL
%         for j = 1:CELLH        
%            %Initialize Map
%             currentNode = MAP{j,i};
%             if OBSTACLES(j,i)
%                 x = [x,MAP{j,i}.x];
%                 y = [y,MAP{j,i}.y];
%                 c = [z,MAP{j,i}.g];
%             end
%         end
%     end
%     sz = 20;
%     c = linspace(MAP{25,3}.g,MAP{10,47}.g,length(x));
%     scatter(x,y,sz,c,'filled');
%     plot(MAP{10,47}.x,MAP{10,47}.y,'xr','MarkerSize',15,'linewidth',3);	
%     plot(MAP{25,3}.x,MAP{25,3}.y,'ob','MarkerSize',15,'linewidth',3);
%     colorbar;
    is = Orig.i;
    js = Orig.j;
    
    iDest = Dest.i;
    jDest = Dest.j;
    
    jl = js;
    il = is;
    path = []
    
    count = CELLL* CELLH*CELLH;
    h = 0;
    
    while ~isDestination(is,js,iDest,jDest)
        
        h = h+1;
        if h > count
            break;
        end
        [js, is] = nextPos(js,is); 
        jll = jl;
        ill = il;
        
        jl = js;
        il = is;
        change = false;
        
        coord = [jl, il];
        path = [path;coord];
        
        current = [];
        
        ic = il;
        jc = jl;
        current = [jc,ic];
        
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
      
        
        p1 = plot(current(:,2),30-current(:,1)+1,'--r','linewidth',2);
        p2 = plot(path(:,2),30-path(:,1)+1,'-b','linewidth',5);
        p3 = plot(is,30-js+1,'ok','MarkerSize',5,'linewidth',2);
        p4 = plot(is,30-js+1,'ok','MarkerSize',20,'linewidth',1);
        drawnow;
        delete(p1);
        delete(p2);
        delete(p3);
        delete(p4);
        
        if isValid(js-1,is)
            if ~OBSTACLES(js-1,is)
                change = true;
                MAP{js-1,is} = makeObstacle(MAP{js-1,is});
                MAP{js-1,is}.rhs = Inf;
                MAP{js-1,is}.g = Inf;
                %plot(MAP{js-1,is}.x,MAP{js-1,is}.y,'ks','MarkerFaceColor','k');
                updateVertex(MAP{js,is},MAP{js,is},Dest,k);
            end
        end
        
        if isValid(js+1,is)              
            if ~OBSTACLES(js+1,is)
                change = true;
                MAP{js+1,is} = makeObstacle(MAP{js+1,is});
                MAP{js+1,is}.rhs = Inf;
                MAP{js+1,is}.g = Inf;
                %plot(MAP{js+1,is}.x,MAP{js+1,is}.y,'ks','MarkerFaceColor','k');
                updateVertex(MAP{js,is},MAP{js,is},Dest,k);
            end          
        end
        
        if isValid(js,is-1)              
            if ~OBSTACLES(js,is-1)
                change = true;
                MAP{js,is-1} = makeObstacle(MAP{js,is-1});
                MAP{js,is-1}.rhs = Inf;
                MAP{js,is-1}.g = Inf;  
                %plot(MAP{js,is-1}.x,MAP{js,is-1}.y,'ks','MarkerFaceColor','k');
                updateVertex(MAP{js,is},MAP{js,is},Dest,k);
            end        
        end
        
        if isValid(js,is+1)              
            if ~OBSTACLES(js,is+1)
                change = true;
                MAP{js,is+1} = makeObstacle(MAP{js,is+1});
                MAP{js,is+1}.rhs = Inf;
                MAP{js,is+1}.g = Inf; 
                %plot(MAP{js,is+1}.x,MAP{js,is+1}.y,'ks','MarkerFaceColor','k');
                updateVertex(MAP{js,is},MAP{js,is},Dest,k);
            end          
        end
        
        if isValid(js+1,is+1)              
            if ~OBSTACLES(js+1,is+1)
                change = true;
                MAP{js+1,is+1} = makeObstacle(MAP{js+1,is+1});
                MAP{js+1,is+1}.rhs = Inf;
                MAP{js+1,is+1}.g = Inf; 
                %plot(MAP{js+1,is+1}.x,MAP{js+1,is+1}.y,'ks','MarkerFaceColor','k');
                updateVertex(MAP{js,is},MAP{js,is},Dest,k);
            end         
        end
        
        if isValid(js-1,is+1)              
            if ~OBSTACLES(js-1,is+1)
                change = true;
                MAP{js-1,is+1} = makeObstacle(MAP{js-1,is+1});
                MAP{js-1,is+1}.rhs = Inf;
                MAP{js-1,is+1}.g = Inf;
                %plot(MAP{js-1,is+1}.x,MAP{js-1,is+1}.y,'ks','MarkerFaceColor','k');
                updateVertex(MAP{js,is},MAP{js,is},Dest,k);
            end        
        end
        
        if isValid(js-1,is-1)              
            if ~OBSTACLES(js-1,is-1)
                change = true;
                MAP{js-1,is-1} = makeObstacle(MAP{js-1,is-1});
                MAP{js-1,is-1}.rhs = Inf;
                MAP{js-1,is-1}.g = Inf;  
                %plot(MAP{js-1,is-1}.x,MAP{js-1,is-1}.y,'ks','MarkerFaceColor','k');
                updateVertex(MAP{js,is},MAP{js,is},Dest,k);
            end          
        end
        
        if isValid(js+1,is-1)              
            if ~OBSTACLES(js+1,is-1)
                change = true;
                MAP{js+1,is-1} = makeObstacle(MAP{js+1,is-1});
                MAP{js+1,is-1}.rhs = Inf;
                MAP{js+1,is-1}.g = Inf;   
                %plot(MAP{js+1,is-1}.x,MAP{js+1,is-1}.y,'ks','MarkerFaceColor','k');
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