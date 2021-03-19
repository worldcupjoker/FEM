% Copyright, 2021, (Ted) Zhongkun Zhan, all rights reserved.
% File name: Prob3Q8Related

classdef Prob3Q8Related < handle
    properties (Access = private)
        nBCNum = 2;
        tBCNum = 3;
        sourceNum = 1;
        
        nBC1;
        nBC2;
        tBC1;
        tBC2;
        tBC3;
        tempRing = 0;
    end
    
    methods
        
        % Constructor
        function obj = Prob3Q8Related(fileName)
            obj.nBC1 = readinp('*Nset, nset=bot1', fileName);
            obj.nBC2 = readinp('*Nset, nset=top3', fileName);
            obj.tBC1 = readinp('*Nset, nset=ring', fileName);
            obj.tBC2 = readinp('*Nset, nset=right2', fileName);
            obj.tBC3 = readinp('*Nset, nset=left4', fileName);
        end
        
        function neumannBC = getNBC(obj, i)
            if i == 1
                neumannBC = obj.nBC1;
                return
            end
            if i == 2
                neumannBC = obj.nBC2;
                return
            end
        end
        
        function flux = getFlux(obj, i)
            if i == 1
                flux = @(x, y)(2 * 0.5 * (1 - 0.25 / (x ^ 2 + 0.5 ^ 2) ^ 0.5) + y - y);
                return
            end
            if i == 2
                flux = @(x, y)(2 * 0.5 * (0.25 / (x ^ 2 + 0.5 ^ 2) ^ 0.5 - 1) + y - y);
                return
            end
        end
        
        function s = getSource(obj, i)
            if i == 1
                s = @(x, y)(2 * 0.25 / (x ^ 2 + y ^ 2) ^ 0.5 - 4);
                return
            end
        end
        
        function tBC = getTempBC(obj, i)
            if i == 1
                tBC = obj.tBC1;
                return
            end
            if i == 2
                tBC = obj.tBC2;
                return
            end
            if i == 3
                tBC = obj.tBC3;
                return
            end
        end
        
        function temp = getTemp(obj, i)
            if i == 1
                temp = @(x, y)(0 + x - x + y - y);
                return
            end
            if i == 2
                temp = @(x, y)(0.25 ^ 2 + 0.5 ^ 2 + y ^ 2 - 2 * 0.25 * (0.5 ^ 2 + y ^ 2) ^ 0.5 + x - x);
                return
            end
            if i == 3
                temp = @(x, y)(0.25 ^ 2 + 0.5 ^ 2 + y ^ 2 - 2 * 0.25 * (0.5 ^ 2 + y ^ 2) ^ 0.5 + x - x);
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