% Copyright, 2021, (Ted) Zhongkun Zhan, all rights reserved.
% File name: Prob2Q8Related

classdef Prob2Q8Related < handle
    properties (Access = private)
        nBCNum = 1;
        tBCNum = 1;
        sourceNum = 1;
        
        nBC1;
        tBC1;
        temp1 = 0;
        flux1 = -2;
        source = 2;
    end
    
    methods
        
        % Constructor
        function obj = Prob2Q8Related(fileName)
            obj.nBC1 = readinp('*Nset, nset=right2', fileName);
            obj.tBC1 = readinp('*Nset, nset=left4', fileName);
        end
        
        function neumannBC = getNBC(obj, i)
            if i == 1
                neumannBC = obj.nBC1;
                return
            end
        end
        
        function flux = getFlux(obj, i)
            if i == 1
                flux = @(x, y)(obj.flux1);
                return
            end
        end
        
        function s = getSource(obj, i)
            if i == 1
                s = @(x, y)(obj.source);
                return
            end
        end
        
        function tBC = getTempBC(obj, i)
            if i == 1
                tBC = obj.tBC1;
                return
            end
        end
        
        function temp = getTemp(obj, i)
            if i == 1
                temp = @(x, y)(obj.temp1);
                return
            end
        end

        function num = getnBCNum(obj)
            num = obj.nBCNum;
            return
        end
        
        function num = getSourceNum(obj)
            num = obj.sourceNum;
            return
        end
        
        function num = getEBCNum(obj)
            num = obj.tBCNum;
            return
        end
        
    end
end