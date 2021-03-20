function [rhos, thetas] = HoughLines(H, nLines)

%Vectors to store the highest voted theta/rho pairs
rhos =[];
thetas = [];

N=7; %Size of the neighborhood

for i=1:nLines
    Hnew = sort(H(:),"descend");
    peak=Hnew(1);   
    [rho,theta]=find(H == peak,1);
    
    %Suppression of close lines 
    %Low x limit, if the actual x-N is lower than 1, it means that the 
    %neighbor size doesn't fit the image.
    lowLimitX = max([rho-N 1]); 
    highLimitX = min([rho+N size(H,1)]);
    lowLimitY = max([theta-N 1]);
    highLimitY = min([theta+N size(H,2)]);
    H(lowLimitX:highLimitX,lowLimitY:highLimitY) = 0;
    
    %Saves the pair
    rhos =[rhos;rho];
    thetas = [thetas;theta];
end
end
        