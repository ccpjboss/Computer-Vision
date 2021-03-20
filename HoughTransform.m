function [H, rhoScale, thetaScale] = HoughTransform(Im, rhoRes, thetaRes)

rhoMax = sqrt(size(Im,1)^2+size(Im,2)^2); %Computes the max rho which is the diagonal of the image
thetaScale = -pi:thetaRes:pi; %Theta vector for the acumulator
rhoScale = 0:rhoRes:rhoMax; %Rho vertor for the acumulator

H = zeros(length(rhoScale),length(thetaScale)); %Creates the acumulator and fills it with zeros

[y,x] = find(Im); %Finds non zero pixels in the image

rho = zeros(length(x),length(thetaScale)); %Creates the rho vector for every non zero pixel found

for i = 1:length(x)
    rho(i,:) = x(i)*cos(thetaScale)+y(i)*sin(thetaScale); %Computes the rho vector for every theta
end

binValues = discretize(rho(:,:),rhoScale); %Assigns every rho calculated to a bin of rhos
[r,c] = find(~(isnan(binValues)));

for i = 1:numel(r)
    rhoAux=binValues(r(i),c(i));
    H(rhoAux,c(i)) = H(binValues(r(i),c(i)),c(i)) + 1; %Votes for the rho/theta pair
end

%imshow(imadjust(rescale(H)),[],'InitialMagnification','fit');
end  