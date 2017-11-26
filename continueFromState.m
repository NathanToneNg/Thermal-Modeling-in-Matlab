function continueFromState
%% Initialize globals
%Globals allow this to carry over from set-up functions. They are used
%instead of persistent so that they can be used in the command frame if
%necessary.
global precision xdist ydist zdist dd total_time dt framerate convection radiation ...
    specific_heat density Tm roomTemp elevatedTemp elevLocation thermal_Conductivity...
    elevFrequency absorption energyRate distributionFrequency emissivity timeOn timeOff...
    density2 specific_heat2 thermal_Conductivity2 interfaceK materials distribution ...
    frequency2 cycle cycleIntervals cycleSpeed isotherm convecc saveMovie melting Tm2 graph ...
    bottomLoss initialGrid topCheck depth heating roomTempFunc finalGrid consistent ...
    gradientPlot recordGradient gradientData;


load inProgress.mat



%% Iterate
% This is where the program iterates through time steps. The first time
% step is considered the initial values, and iter + 1 is the last. 
for j= iterPrior:iter + 1
    if any(any(any(isnan(wholeMatrix))))
        error('Error at iteration %d', j);
    end
    %Keep an older version so we aren't counting changes in the same time
    old = wholeMatrix;
    
    %Use constants, thermal conductivity, and difference in temperatures
    %between pixels on the grid to calculate conductive transfer
    wholeMatrix(2:end-1, 2:end-1,2:end-1) = wholeMatrix(2:end-1, 2:end-1,2:end-1) + ...
        ...
        (old(2:end-1, 1:end-2,2:end-1)-old(2:end-1,2:end-1,2:end-1)) ...
            .*constants .* upK + ...
        (old(2:end-1,3:end,2:end-1)-old(2:end-1,2:end-1,2:end-1))...
            .*constants .* downK + ...
        (old(1:end-2,2:end-1,2:end-1)-old(2:end-1,2:end-1,2:end-1))...
            .*constants .* leftK + ...
        (old(3:end,2:end-1,2:end-1) - old(2:end-1,2:end-1,2:end-1))...
            .*constants .* rightK + ...
        (old(2:end-1,2:end-1,1:end-2) - old(2:end-1,2:end-1,2:end-1)) ...
            .*constants .* inK + ...
        (old(2:end-1,2:end-1,3:end) - old(2:end-1,2:end-1,2:end-1)) ...
            .*constants .* outK;
    if infinitex
        wholeMatrix(1,2:end-1,2:end-1) = wholeMatrix(1,2:end-1,2:end-1) + ...
            (old(1, 2:end-1,2:end-1)-old(end,2:end-1,2:end-1)) .* xboundK;
        wholeMatrix(end,2:end-1,2:end-1) = wholeMatrix(end,2:end-1,2:end-1) + ...
            (old(end,2:end-1,2:end-1)-old(1,2:end-1,2:end-1)) .* xboundK;
    end
    if infinitey
        wholeMatrix(2:end-1,1,2:end-1) = wholeMatrix(2:end-1,1,2:end-1) + ...
            (old(2:end-1,1,2:end-1)-old(2:end-1,end,2:end-1)) .* yboundK;
        wholeMatrix(2:end-1,end,2:end-1) = wholeMatrix(2:end-1,end,2:end-1) + ...
            (old(2:end-1,end,2:end-1)-old(2:end-1,1,2:end-1)) .* yboundK;
    end
    if infinitez
        wholeMatrix(2:end-1,2:end-1,1) = wholeMatrix(2:end-1,2:end-1,1) + ...
            (old(2:end-1,2:end-1,1)-old(2:end-1,2:end-1,end)) .* zboundK;
        wholeMatrix(2:end-1,2:end-1,end) = wholeMatrix(2:end-1,2:end-1,end) + ...
            (old(2:end-1,2:end-1,end)-old(2:end-1,2:end-1,1)) .* zboundK;
    end
    %Changes based on radiation
    if radiation
        if heating
            wholeMatrix(boundaries) = wholeMatrix(boundaries) - ...
                (rConst .* (((old(boundaries) + 273.15).^4) - ...
                (roomTempFunc(j * dt) + 273.15).^4));
        else
            wholeMatrix(boundaries) = wholeMatrix(boundaries) - ...
            (rConst .* ((old(boundaries) + 273.15).^4)) + rAir;
        end
    end
    %Changes based on convection
    if convection
        if heating
            wholeMatrix(boundaries) = wholeMatrix(boundaries) - ...
                ((old(boundaries) - roomTempFunc(j * dt)) .* convRatio);
        else
            wholeMatrix(boundaries) = wholeMatrix(boundaries) - ...
                ((old(boundaries) .* convRatio) - convAir);
        end
    end
    %Increments by energy (turned into temp) if between the correct time
    %interval
    if j >= iterOn && j <= iterOff
        wholeMatrix(bigReceivers) = wholeMatrix(bigReceivers) + energyRate .* insertion(receivers) .* ratios(rotation)';
    end
    %If cycle/rotations are on, this will change
    if ~isempty(cycle) && cycle ~= 1 && mod(j - 1, cycleRate) == 0
        rotation = rotation + 1;
        rotation(rotation > cycleIntervals) = 1;
    end
    
    %Will graph/ save total energy/ average temps at correct framerate.
    if mod(j - 1, framerate) == 0 %Could alternatively be mod(j, framerate) == 1
        list(index) = sum(sum(sum(wholeMatrix(2:end-1,2:end-1,2:end-1) ... %Total Energy
            ./ constants))) .* dt .* dd;
        tempsList(index) = mean(mean(mean(wholeMatrix(2:end-1,2:end-1,2:end-1))));
        if ~isempty(topCheck) && topCheck
            topTemps(index) = getTop(wholeMatrix(2:end-1,2:end-1,2:end-1),depth);
        end
        if graph
            try
                if gradientPlot == 1
                    if j == 2
                        figure;
                    end
                    hold on;
                    eval(sprintf('h%d = histogram(wholeMatrix(2:end-1,2:end-1,2:end-1));',j));
                    alpha(0.5);
                    eval(sprintf('h%d.FaceColor = [(j / (iter + 1)) (j / (iter + 1)) (1-(j / (iter + 1)))];',j));
                    [sizes, ~] = histcounts(wholeMatrix(2:end-1,2:end-1,2:end-1));
                    ylim([0 max(sizes)*1.05 ]);
                elseif gradientPlot == 2
                    if j == 2
                        figure;
                    end
                    hold on;
                    if j ~= iter + 1
                        color = [(j / (iter + 1)) (1-(j / (iter + 1))) (1 - (j / (iter + 1)))];
                    else
                        color = [1 0 0];
                    end
                    depthGradientPlotBins(wholeMatrix(2:end-1,2:end-1,2:end-1), numberEl, color, index);
                elseif isotherm
                    isosurfacePlot(wholeMatrix(2:end-1,2:end-1,2:end-1));
                else
                    figure;
                    slice(X,Y,Z, wholeMatrix(2:end-1,2:end-1,2:end-1), yslice, xslice, zslice);
                    caxis([0 (Tm + 20)])
                    colorbar('horiz')
                end
                drawnow
                F(index) = getframe(gcf);
            catch
                if j == framerate + 1
                    disp('Cannot graph');
                end
            end
        end
        index = index + 1;
        if melting
            melted = anyMeltingIter(wholeMatrix(2:end-1,2:end-1,2:end-1),melted,Tms);
        end
        iterPrior = j; %#ok<NASGU>
        save('inProgress.mat');
    end
end

%% Save final settings and play movie/display final frame
%Save final data frame in finalTemps
if ~isempty(finalGrid) && finalGrid
    clear global finalTemps
    global finalTemps
    finalTemps = wholeMatrix(2:end-1,2:end-1,2:end-1);
end
%Will wait for user to give word, and will then close all windows, play the
%movie, and then show just the last screen.
if graph
    pause
    close all;
    try
        fig = figure;
        movie(fig,F,1);
    catch
        %disp('Cannot create movie');
    end
    close all;

    try
        if gradientPlot == 1
            if j == 2
                figure;
            end
            hold on;
            eval(sprintf('h%d = histogram(wholeMatrix(2:end-1,2:end-1,2:end-1));',j));
            alpha(0.5);
            eval(sprintf('h%d.FaceColor = [(j / (iter + 1)) (j / (iter + 1)) (1-(j / (iter + 1)))];',j));
            [sizes, ~] = histcounts(wholeMatrix(2:end-1,2:end-1,2:end-1));
            ylim([0 max(sizes)*1.05 ]);
        elseif gradientPlot == 2
            if j == 2
                figure;
            end
            hold on;
            color = [1 0 0];
            depthGradientPlotBins(wholeMatrix(2:end-1,2:end-1,2:end-1), numberEl, color);
        elseif isotherm
            isosurfacePlot(wholeMatrix(2:end-1,2:end-1,2:end-1));
            view(3);
            hold on;
            s = slice(X,Y,Z, wholeMatrix(2:end-1,2:end-1,2:end-1), yslice, xslice, zslice);
            alpha(s, 0.3);
            caxis([0 (Tm + 20)])
            colorbar('horiz')
        else
            slice(X,Y,Z, wholeMatrix(2:end-1,2:end-1,2:end-1), yslice, xslice, zslice);
            caxis([0 (Tm + 20)])
            colorbar('horiz')
        end
    catch
        disp('Cannot graph');
    end
    if saveMovie
        v = VideoWriter('recentTestMovie');
        v.open;
        v.writeVideo(F)
        v.close;
    end
end
%Used in tests where we need to check what percent of the material melts in
%a given heating simulation. Checks over all materials at the Tm passed in.
if melting
    num = xintervals * yintervals * zintervals;
    ratio = sum(sum(sum(melted)))/num;

    fprintf('Ratio Melted = %d / %d = %g = %g%%\n', sum(sum(sum(melted))), num, ratio, ratio*100);
end

end