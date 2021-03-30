# FEM2021
# Copyright, 2021, (Ted) Zhongkun Zhan, all rights reserved.
# This program applies 8-node quadrilateral and 6-node triangular types of elements to solve 2-D steady state heat transfer problems using finite element methods.
# Object oriented programming concept is implemented. Mesh is generated by Abaqus. 
# Inputs: [filename.inp]
# To create an object (8-node quadrilateral type of elements):
#   obj = AbaqusClassQ8(filename.inp)
# To find temperature distribution:
#   obj.getT()
# To find flux distribution at quadrature points:
#   obj.getFlux()
# Sample .inp files are provided. Each problem with different sets & types of boundary conditions needs complementary files, such as ProbXQ8Related.m
# A main function is provided as an example to plot the temperature distribution and the flux distribution.
![Prob3Q8_163](https://user-images.githubusercontent.com/73008183/111817418-5e266f00-88b4-11eb-825a-4420a3ec4cf9.png)
![image](https://user-images.githubusercontent.com/73008183/113001421-cbe95b00-913e-11eb-920a-a6e676200572.png)
![image](https://user-images.githubusercontent.com/73008183/113001535-e3284880-913e-11eb-840a-2bd7f2e624a7.png)
