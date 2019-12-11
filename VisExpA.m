function [ VG paths S] = VisExpA( G , S)
%	This function computes the visibility expansion algorithm, which
%   generates a graph VG associated to a complex network G, similarly 
%   to the visibility algorithm, which was introduced by Lacasa et al. 
%   (2008) and it generates a visibility graph associated to a time 
%   series ts. 
%
%   INPUTS:     G:	Directed/undirected connectivity or adjacency 
%                   matrix of a complex network.
%               S:	Vector (length=n, number of nodes) with the 
%                   control-attribute S (e.g. centrality, population, 
%                   size,etc.). If S is not entered as an argument, 
%                   node strengths are considered as the default 
%                   value.
%
%   OUTPUTS:    VG: The adjacency matrix of the visibility graph G 
%                   associated to a complex network, where two nodes 
%                   (u,v) are each other connected when the one (u) 
%                   “sees” the other (v), under the Lacasa et al. (2008) 
%                   criterion, where for a node c intermediating nodes 
%                   (u,v) (i.e. u,c,v) it stands:
%                           sc < sv + (su - sv)*dvc/dvu,
%                   where:
%                           su = the strength of node u
%                           duv = the path distance between nodes u 
%                                 and v
%               paths: shortest paths of network G, on which the 
%                   VisExpA is computed.
%               S:  vector of the control attribute (applicable) when it
%                   is not entered as an input argument.
%               
%   REFERENCE: 
%   Tsiotas, D., Charakopoulos, A., (2018) “Visibility in the topology 
%   of complex networks: introducing a new approach”, Physica Á, 505, 
%   pp.280-292.
%
%   Developed by  Dimitrios Tsiotas (Ph.D), June 2017. 

n=length(G);
ADJ=G;
ADJ(ADJ>1)==1;
if nargin < 2   
    S1=sum(ADJ,1);
    S2=sum(ADJ,2);
    if S1'==S2
        S=S1';
    else
        S=(S1+S2');
    end
end
G=sparse(G);
D=zeros(n);
VG=zeros(n);
loop=0;
Bo=[1:n];
B=zeros(1,n);
for i=1:n
    loop=loop+1;
    for j=1:n
    loop=loop+1;
    [a b]=graphshortestpath(G,i,j);
    D(i,j)=a;
    lb=length(b);
    if lb>1
       STR=S(b);
       V=visibilitynet(STR);
       VG(b,b)=V;
    end
    ind=[1:lb];
    B(loop,ind)=b;    
    end
    paths=B;
end
VG=VG+ADJ;
VG(VG>1)=1;
end
