function plotCCG(t, assignments, varargin)
% Plot cross-correlograms of all pairs.
%   plotCCG(t, assignment) plots a matrix of cross(auto)-correlograms for
%   all pairs of clusters. Inputs are:
%       t           vector of spike times           #spikes x 1
%       assignment  vector of cluster assignments   #spikes x 1

maxlag = 20;
binsize = 0.5;
C = max(assignments);

[ccg, bins] = correlogram(t, assignments, binsize, maxlag);

colors = [0 0 0; 0 0 1; 0 1 0; 1 0 0; 0 1 1; 1 0 1; 1 1 0; .5 .5 .5; 0 0 .5];

figure()
for c1 = 1:C
    for c2 = 1:C
        subplot(C,C,c1+(c2-1)*C)
        if c1 == c2
            bar(bins,ccg(:,c1,c2),binsize,'FaceColor',colors(c1,:),'edgecolor','none');
        else
            bar(bins,ccg(:,c1,c2),binsize,'edgecolor','none');
        end
        if c2 ~= C
            set(gca,'XTickLabel',[],'YTickLabel',[])
        else
            set(gca,'YTickLabel',[])
            if c1 == ceil(C/2);
                xlabel('t [ms]')
            end
        end
        xlim([-maxlag,maxlag])
    end
end

