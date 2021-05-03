% Copyright, 2021, (Ted) Zhongkun Zhan, all rights reserved.
% File name: AbaqusClassQ8.m
% This file solves a 2 demensional stead state heat transfer problem using
% finite element method with 8-node quadrilateral element type.
% Input: [file name]

classdef AbaqusClassQ8 < handle
    properties (Access = private)
    
    % main function run time.
    time;
    
    % nodes - 2D array with 3 columns - node no., x-coordinate, y-coordinate
    % and rows = no. of nodes.
    nodeGlobal;
    totalNodes;

    % elements - 2D array with columns - element no., nodes in element and rows
    % = no. of elements .
    elements;
    totalElements;

    % Conductivity
    K;
    
    % Matrices
    K_global;
    f_n;
    f_s;
    temperature;
    
    % This is a 4Elementsx4 matrix. First column: x; second column: y;
    % thrid column: qx; fourth column: qy.
    % Each element has four flux vectors, with one at each quadrature
    % point.
    flux;
    end
    
    properties (Access = private)
    % Temperary object.
    tempObj;
    
    % Get shape functions for two-point Gaussian quadrature.
    N_a = getShapeFuncQ8(-1 / 3 ^ 0.5, -1 / 3 ^ 0.5, true);
    N_b = getShapeFuncQ8(1 / 3 ^ 0.5, -1 / 3 ^ 0.5, true);
    N_c = getShapeFuncQ8(1 / 3 ^ 0.5, 1 / 3 ^ 0.5, true);
    N_d = getShapeFuncQ8(-1 / 3 ^ 0.5, 1 / 3 ^ 0.5, true);    
    
    
    % Get G matrix (the gradient of shape functions) values for two-point Gaussian Quadrature.
    % The order is a, b, c, d, counter clockwise, starting from the bottom left corner.
    G_a = getShapeFuncQ8(-1 / 3 ^ 0.5, -1 / 3 ^ 0.5, false);
    G_b = getShapeFuncQ8(1 / 3 ^ 0.5, -1 / 3 ^ 0.5, false);
    G_c = getShapeFuncQ8(1 / 3 ^ 0.5, 1 / 3 ^ 0.5, false);
    G_d = getShapeFuncQ8(-1 / 3 ^ 0.5, 1 / 3 ^ 0.5, false);
    end
    
    methods
        
        % Constructor
        function obj = AbaqusClassQ8(fileName)
            
            % Read in data.
            strGlobalNodes = '*Node';
            strElementNodes = '*Element, type=DC2D8';
            obj.nodeGlobal = readinp(strGlobalNodes, fileName);
            obj.totalNodes = size(obj.nodeGlobal, 1);
            obj.elements = readinp(strElementNodes, fileName);
            obj.totalElements = size(obj.elements, 1);
            string1 = '*Conductivity';
            constants = readinp(string1, fileName);
            obj.K = constants(1);
            
            if (strfind(fileName, 'Prob1') == 1)
                obj.tempObj = Prob1Related(fileName);
            elseif ((strfind(fileName, 'Prob2') == 1))
                obj.tempObj = Prob2Related(fileName);
            elseif ((strfind(fileName, 'Prob3') == 1))
                obj.tempObj = Prob3Related(fileName);
            end
            
            mainCalculation(obj);
        end
        
        % Get temperature at each node.
        % Matlab syntax: a function (other than the constructor) takes at
        % least one input, and the first input has to be the current class
        % (object) itself.
        function T = getT(obj)
            T = obj.temperature;
            return
        end
        
        % Get global nodes.
        function matrixN = getNodes(obj)
            matrixN = obj.nodeGlobal;
            return
        end
        
        % Get body flux.
        function q = getFlux(obj)
            q = obj.flux;
            return
        end
        
        % Get run time.
        function t = getTime(obj)
            t = obj.time;
            return
        end
        
        % Get elements.
        function ele = getElements(obj)
            ele = obj.elements;
            return
        end
        
    end
    
    methods (Access = private)
        
        % Main calculation (private).
        function mainCalculation(obj)
            
            % Start timing.
            %tic
            
            % Set the sizes of matrices.
            obj.K_global = zeros(obj.totalNodes, obj.totalNodes);
            obj.f_n = zeros(obj.totalNodes, 1);
            obj.f_s = zeros(obj.totalNodes, 1);
            obj.temperature = zeros(obj.totalNodes, 1);
            obj.flux = zeros(obj.totalElements * 4, 4);
            
            % Start the main loop to calculate temperature.
            for i = 1 : obj.totalElements
    
                % Get the x, y nodal values for this element.
                % Store the values in xy matrix.
                % Find the gather matrix.
                xy = zeros(8, 2);
                L = zeros(8, obj.totalNodes);
                for j = 1 : 8
                    globalNodeNumber = obj.elements(i, j + 1);
                    xy(j, 1) = obj.nodeGlobal(globalNodeNumber, 2);
                    xy(j, 2) = obj.nodeGlobal(globalNodeNumber, 3);
                    L(j, globalNodeNumber) = 1;
                end
    
                % Find K_global
                obj.K_global = obj.K_global + getStiffnessMatrix(obj, xy, L);
    
                % Apply Neumann BC.
                obj.f_n = obj.f_n + getNeumannBC(obj, i, xy, L);
                
                % Apply body source.
                obj.f_s = obj.f_s + getSource(obj, xy, L);    
            end
            
            % Apply essential BC.
            totalEBCNodes = [];
            for i = 1 : obj.tempObj.getEBCNum()
                currentTBC = obj.tempObj.getTempBC(i); % The nodes.
                currentTemp = obj.tempObj.getTemp(i); % The nodal values.
                totalEBCNodes = [totalEBCNodes, currentTBC];
                for j = 1 : size(currentTBC, 2)
                    tempX = obj.nodeGlobal(currentTBC(j), 2);
                    tempY = obj.nodeGlobal(currentTBC(j), 3);
                    obj.temperature(currentTBC(j), 1) = currentTemp(tempX, tempY);
                end
            end
            
            % Combine the RHS.
            RHS = obj.f_n + obj.f_s;
            
            % Restructure LHS and RHS to solve for nodal values.
            % Also find the gather matrix for remaining nodes, from the
            % remaining nodes to global nodes.
            finalL = zeros(obj.totalNodes, obj.totalNodes - size(totalEBCNodes, 2));
            count = 1;
            rowCount = 0;
            columnCount = 0;
            for kk = 1 : obj.totalNodes
                if ismember(obj.nodeGlobal(kk, 1), totalEBCNodes) == 1
                    
                    % Remove a row.
                    % Take in consideration of the fact that the size of
                    % the matrix reduces after each time you remove a row
                    % and a column.
                    obj.K_global(kk - rowCount, :) = [];
                    RHS(kk - rowCount, :) = [];
                    rowCount = rowCount + 1;
                    
                    % !!Move a column multiplied by that nodal value from
                    % the left side to the right side.
                    RHS = RHS - obj.K_global(:, kk - columnCount) * obj.temperature(kk, 1);
                    obj.K_global(:, kk - columnCount) = [];
                    columnCount = columnCount + 1;
                else
                    
                    % Find gather matrix.
                    finalL(kk, count) = 1;
                    count = count + 1;
                end
            end
            solution = obj.K_global \ RHS;
            solution = finalL * solution;
            obj.temperature = obj.temperature + solution;
            
            % Start the main loop to calculate flux at quadrature points.
            for i = 1 : obj.totalElements
    
                % Get the x, y nodal values for this element.
                % Store the values in xy matrix.
                % Find the temperature at local nodes.
                xy = zeros(8, 2);
                localTemp = zeros(8, 1);
                for j = 1 : 8
                    globalNodeNumber = obj.elements(i, j + 1);
                    xy(j, 1) = obj.nodeGlobal(globalNodeNumber, 2);
                    xy(j, 2) = obj.nodeGlobal(globalNodeNumber, 3);
                    localTemp(j, 1) = obj.temperature(globalNodeNumber, 1);
                end
                
                % Iterate through 4 quadrature points in each elements.
                fluxLocal = localFlux(xy, obj.N_a, obj.N_b, obj.N_c, obj.N_d, obj.G_a, obj.G_b, obj.G_c, obj.G_d, localTemp, obj.K);
                for j = 1 : 4
                    obj.flux(i * 4 - 3 + j - 1, :) = fluxLocal(j, :);
                end
            end
            
            % End timing
            %obj.time = toc;            
        end
        
        % Get stifness matrix.
        % Private.
        function K_el = getStiffnessMatrix(obj, xy, L)

            % Find the jacobian matrices and their determinants.
            J_a = obj.G_a * xy;
            detJ_a = det(J_a);
            J_b = obj.G_b * xy;
            detJ_b = det(J_b);
            J_c = obj.G_c * xy;
            detJ_c = det(J_c);
            J_d = obj.G_d * xy;
            detJ_d = det(J_d);

            % Find B matrices.
            B_a = inv(J_a) * obj.G_a;
            B_b = inv(J_b) * obj.G_b;
            B_c = inv(J_c) * obj.G_c;
            B_d = inv(J_d) * obj.G_d;
        
            K_el = B_a.' * obj.K * B_a * detJ_a + B_b.' * obj.K * B_b * detJ_b + B_c.' * obj.K * B_c * detJ_c + B_d.' * obj.K * B_d * detJ_d;
        
            % Transfer local nodes into global nodes.
            K_el = L.' * K_el * L;
            return
        end
        
        % Get Neumann BC. (private)
        function force_n = getNeumannBC(obj, elementNum, xy, L)
            force_n = zeros(obj.totalNodes, 1);
            currentElement = obj.elements(elementNum, :);
            
            % Go through each Neumann BC for each element.
            for i = 1 : obj.tempObj.getnBCNum()
                
                % Check if a node is on the boundary.
                % Use a 1x2 matrix to store the node number.
                % Each element can only have 0, 1, or 2 corner nodes on a
                % certain boundary.
                % loop after k reaches 3.
                currentBoundary = obj.tempObj.getNBC(i);
                currentFlux = obj.tempObj.getFlux(i);
                record = zeros(1, 2);
                k = 1;
                for j = 1 : 4
                    currentElement(1, j + 1);%
                    if ismember(currentElement(j + 1), currentBoundary) == 1
                        record(1, k) = j;
                        k = k + 1;
                    end
                    if k == 3
                        break
                    end
                end
                
                recordState = record(1) * record(2);
                if recordState ~= 0
                    force_n = force_n + force2PointGaussQ8(xy, L, recordState, currentFlux);
                end
            end
            force_n = -1 * force_n; % !!!!! here not above.
            return
        end
        
        % Get source.
        % private.
        function force_s = getSource(obj, xy, L)
            force_s = zeros(obj.totalNodes, 1);
            J_a = obj.G_a * xy;
            detJ_a = det(J_a);
            J_b = obj.G_b * xy;
            detJ_b = det(J_b);
            J_c = obj.G_c * xy;
            detJ_c = det(J_c);
            J_d = obj.G_d * xy;
            detJ_d = det(J_d);
            
            % Go through each source for each element.
            for i = 1 : obj.tempObj.getSourceNum()
                currentSource = obj.tempObj.getSource(i);
                force_s = force_s + source2PointGaussQ8(obj.N_a, obj.N_b, obj.N_c, obj.N_d, detJ_a, detJ_b, detJ_c, detJ_d, L, xy, currentSource); 
            end
            return
        end
        
    end
end
