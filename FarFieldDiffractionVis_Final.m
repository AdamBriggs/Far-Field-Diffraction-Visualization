%Peter Dean-Erlander, Adam Briggs, Andres Garcia Coleto
%OPT 211 Final Project
%Visualization of Far Field Diffraction from Differing Apertures
%This script is designed to output a visualization for the far field
%diffraction of different apertures and provide intensity v. distance graphs along the xy plane.
%This script is a function and takes in user input to determine the aperture.  
%To use this program, enter the script name--FarFieldDiffractionVis--
%followed by one of the following arguments: 'Square', 'SingleSlit', 'DoubleSlit',
%'Circular' 'RightTriangle', 'EquilateralTriangle', 'ChickenWire'



function FarFieldDiffractionVis_final(aperture) %This function creates an aperture based off the input from the user.
%example strcmp from previous work
%strcmp(unit,'km')==1

%Defined Constants Section
% Adam Briggs Code
%Define Aperture Field
apl=5000; %Size of the aperture field
sql=500; %Define Square Length
slitW=200; %Width of slit
slitH=2500; %Height of slit
slit2w=175; %Width for double slit
slit2H=2500; %Height of double slit
slit2space=500; %Spacing between centers of double slit
rad=275; %Circle Radius
tri=1500; %Side Length for right triangle
eqtri=900; %Side length for equilateral triangle
chickenspace=250; %Spacing of black lines
chickensquare=150; %Width of the black lines
ap=zeros(apl); %Define actual aperture plane

%Choosing which Aperture Section
if strcmp(aperture,'Square')==1 % Choose aperture type, computes the matrix defining each aperture
    a=0.25; % a=adjusting factor for intensity
    ttle='Square Aperture'; %Define the Title for future plots
    % Square Aperture 
    for ijk=round(1+apl/2-sql/2):round(1+apl/2+sql/2) %Vertical Part
        for lmn=round(1+apl/2-sql/2):round(1+apl/2+sql/2) %Horizontical Part
            ap(ijk,lmn)=1;
        end
    end
    
elseif strcmp(aperture,'SingleSlit')==1
    a=0.3; % a=adjusting factor for intensity
    ttle='Single Slit Aperture'; %Define the Title for future plots
    % Single Slit 
    for ijk=round(1+apl/2-slitH/2):round(1+apl/2+slitH/2) %Vertical Part 
        for lmn=round(1+apl/2-slitW/2):round(1+apl/2+slitW/2) %Horizontical Part
             ap(ijk,lmn)=1;
        end
    end
 
elseif strcmp(aperture,'DoubleSlit')==1
    a=0.3; % a=adjusting factor for intensity
    ttle='Double Slit Aperture'; %Define the Title for future plots
    % Double Slit 
    %Left Side Slit
    for ijk=round(1+apl/2-slit2H/2):round(1+apl/2+slit2H/2) %Vertical Part
        for lmn=round(1+apl/2-slit2space/2-slit2w/2):round(1+apl/2-slit2space/2+slit2w/2) %Horizontical Part
             ap(ijk,lmn)=1;
        end
    end
    %Right Side Slit
    for ijk=round(1+apl/2-slit2H/2):round(1+apl/2+slit2H/2) %Vertical Part
        for lmn=round(1+apl/2+slit2space/2-slit2w/2):round(1+apl/2+slit2space/2+slit2w/2) %Horizontical Part
            ap(ijk,lmn)=1;
        end
    end
 
elseif strcmp(aperture,'Circular')==1
    a=0.3; % a=adjusting factor for intensity
    ttle='Circular Aperture'; %Define the Title for future plots
    % Circular Aperture
    xcenter=apl/2; %Calculates center point for the x axis
    ycenter=apl/2; %Calculates center point for the y axis
    rad2=rad^2; %Square of radius 
    for ijk=1:apl
        for abc=1:apl
            dx=ijk-xcenter; %Determines x position from center
            dy=abc-ycenter; %Determines y position from center
            x2=dx^2; %Square of x position from center
            y2=dy^2; %Square of y position from center
            ap(ijk,abc)=x2+y2<=rad2; %Calculates if point is within radius of circle
        end
    end
   
elseif strcmp(aperture,'RightTriangle')==1
    a=0.3; % a=adjusting factor for intensity
    ttle='Right Triangle Aperture'; %Define the Title for future plots
    % Right Trianglar Aperture
    addr=0; %Defines adder to sequentially work through triangle.
    for ijk=round(1+(apl/2)-(tri/2)):round(1+(apl/2)+(tri/2)) %Vertical Part
        for lmn=round(1+(apl/2)-(tri/2)):round(1+(apl/2)-(tri/2)+addr) %Horizontical Part
        ap(ijk,lmn)=1;
        end
        addr= addr+1; %Adds to adder
    end
      
elseif strcmp(aperture,'EquilateralTriangle')==1
    a=0.3; % a=adjusting factor for intensity
    ttle='Equilateral Triangle Aperture'; %Define the Title for future plots
    % Equilateral Triangle 
    addr=0; %Defines adder to sequentially work through triangle.
    for ijk=round(1+(apl/2)-(eqtri/2)./sqrt(3)):round(1+(apl/2)+(eqtri/2)./sqrt(3)) %Vertical Part
        for lmn=round(1+(apl/2)-addr/2):round(1+(apl/2)+addr/2) %Horizontical Part
        ap(ijk,lmn)=1;
        end
        addr= addr+1;
    end    
    
elseif strcmp(aperture,'ChickenWire')==1
    ap=zeros(5001); %Adjusts the size of the aperture field by one pixel to correct for OBO error in FFT visualization.
    a=0.25; % a=adjusting factor for intensity
    ttle='Chicken Wire Aperture'; %Define the Title for future plots
   % Chicken Wire
    ap(:,:)=1; %Changes matrix from zeros to ones
    for abc=0:19 %Creates loop to create enough black lines to cover the provided width of aperture field
        for ijk=round(50+abc.*chickenspace):round(50+abc.*chickenspace+chickensquare) %Creates Vertical Black Lines 
            ap(:,ijk)=0;
        end
            for ijk=round(50+abc.*chickenspace):round(50+abc.*chickenspace+chickensquare) %Creates Horizontical Black Lines
                ap(ijk,:)=0;
            end
    end
   
else
    %Error Message
   disp('Error 404: Aperture not found. Please input a valid aperture name.') % Displays error message if invalid aperture is given. Displays names of correct apertures
   disp('Valid aperture names are: ''Square'', ''SingleSlit'', ''DoubleSlit'', ''Circular''')
   disp('''RightTriangle'', ''EquilateralTriangle'', and ''ChickenWire''.')
   
   return %The code will stop running if it reaches this point
end



% Plotting Section

% Plot the aperture 
figure %Open a figure window
imagesc(ap) % plot image of the aperture field
colormap gray % set aperture field plot color
axis equal % set the display scale of the axis
axis([0 apl 0 apl]) % set axis limits to the size of the aperture field
xlabel('Location [Pixels]'); %Add x-axis Label
ylabel('Location [Pixels]'); %Add y-axis Label
title(ttle);%Adds title to the plot

%Get the fourier Transformation for an aperture
F=fft2 (ap); % Fourier transformation for aperture
Fc=fftshift(F); %Center the fourier transformation by shifting the 0 frequency to the center
I=abs(Fc).^2; % Calculate the intensity
Ia=(I).^(a); % Calculate the intensity adjusted


figure(2) %Open a new figure window
imagesc(Ia) % Plot image of the intensity of diffraction 
colormap gray % Set the color of the plot
axis equal % Set the display scale of the axes
axis([0 apl 0 apl]) % Set axes limits to size of the screen
c=colorbar; %Adds a colorbar and defines it as a variable to later add a colorbar title
c.Label.String='Adjusted Intensity [Arb. Units]'; %Adds the colorbar title
title (['Full Far Field Diffraction Pattern of a ' ttle]);%Adds title to the plot
xlabel('Location [Pixels]');%Add x-axis Label
ylabel('Location [Pixels]');%Add y-axis Label

figure(3) %Open a new figure window
imagesc(Ia) % Plot image of the intensity of diffraction adjusted
colormap gray % Set the color of the plot
axis equal % Set the display scale of the axes
axis([2375 2625 2375 2625]) % Set axes limits to size of the screen
c=colorbar;%Adds a colorbar and defines it as a variable to later add a colorbar title
c.Label.String='Adjusted Intensity [Arb. Units]';%Adds the colorbar title
title (['Center-Field Far Field Diffraction Pattern of a ' ttle]) %Adds title to the plot
set(gca,'XTick',2375:50:2625)%Set the tick values in the x axis
set(gca,'XTickLabel',0:50:250)% changes the tick labels in the x axis
set(gca,'YTick',2375:50:2625)%Set the tick values in the y axis
set(gca,'YTickLabel',0:50:250)% changes the tick labels in the y axis
xlabel('Location [Pixels]');%Add x-axis Label
ylabel('Location [Pixels]');%Add y-axis Label


figure(4) %Open a new figure window
plot(I(:,2500)); %Plot the vertical cross section of intensity against position
xlim([2375 2625]) %Sets the limits to the center 250 pixels in the vertical cross section
set(gca,'XTick',2375:50:2625)%Set the tick values in the x axis
set(gca,'XTickLabel',0:50:250)% changes the tick labels in the x axis
title(['Vertical Cross section of Diffraction of a ' ttle]) %Adds a title to the plot
xlabel('Location [Pixels]');%Add x-axis Label
ylabel('Intensity [Abs. Units]');%Add y-axis Label

figure(5) %Open a new figure window
plot(I(2500,:));%Plot the horizontal cross section of intensity against position
xlim([2375 2625])%Sets the limits to the center 250 pixels in the horizontal cross section
set(gca,'XTick',2375:50:2625) %Set the tick values in the x axis
set(gca,'XTickLabel',0:50:250) %changes the tick labels in the x axis
title(['Horizontal Cross section of Diffraction of a ' ttle])%Adds a title to the plot
xlabel('Location [Pixels]');%Add x-axis Label
ylabel('Intensity [Abs. Units]');%Add y-axis Label

if strcmp(aperture,'RightTriangle')==1
    
%% Testing Section for 45 degree
figure(6) %Open a new figure window
a=diag(rot90(I)); %Rotates figure and selects diagonal set of numbers.
plot(a);%Plot the horizontal cross section of intensity against position
xlim([2375 2625])%Sets the limits to the center 250 pixels in the horizontal cross section
set(gca,'XTick',2375:50:2625) %Set the tick values in the x axis
set(gca,'XTickLabel',0:50:250) %changes the tick labels in the x axis
title(['45 Deg Cross section of Diffraction of a ' ttle])%Adds a title to the plot
xlabel('Location [Pixels]');%Add x-axis Label
ylabel('Intensity [Abs. Units]');%Add y-axis Label

elseif strcmp(aperture,'EquilateralTriangle')==1
%% Testing Section for 30 degree
figure(7);
degpos=zeros(8000);
for ijk=1:5000 %This for loop creates a 1D array of vales across the 30 degrees axis from x.
    tmp=1250+ijk.*sind(30);
    degpos(ijk)=I(round(tmp),ijk);
end
plot(degpos);
xlim([2375 2625])%Sets the limits to the center 250 pixels in the horizontal cross section
set(gca,'XTick',2375:50:2625) %Set the tick values in the x axis
set(gca,'XTickLabel',0:50:250) %changes the tick labels in the x axis
title(['30 Deg Cross section of Diffraction of a ' ttle])%Adds a title to the plot
xlabel('Location [Pixels]');%Add x-axis Label
ylabel('Intensity [Abs. Units]');%Add y-axis Label

figure(8);
degpos(8000);
for ijk=1:5000
    tmp=3750+ijk.*sind(-30);
    degpos(ijk)=I(round(tmp),ijk);
end
plot(degpos)
xlim([2375 2625])%Sets the limits to the center 250 pixels in the horizontal cross section
set(gca,'XTick',2375:50:2625) %Set the tick values in the x axis
set(gca,'XTickLabel',0:50:250) %changes the tick labels in the x axis
title(['-30 Deg Cross section of Diffraction of a ' ttle])%Adds a title to the plot
xlabel('Location [Pixels]');%Add x-axis Label
ylabel('Intensity [Abs. Units]');%Add y-axis Label
else
    return
end

