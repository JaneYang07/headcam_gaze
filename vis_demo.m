% Generate some data
x = 1:4;
y = rand(9,4);   % note: 4 columns, N rows
ymean = mean(y); % mean of each column for bar

figure();
hold on; % plot multiple things without clearing the axes
bar( x, ymean, 0.4 ); % bar of the means
plot( x, y, 'ok' );   % scatter of the data. 'o' for marker, 'k' for black
hold off


% https://stackoverflow.com/questions/66669264/how-to-overlay-single-data-points-on-bar-graph-in-matlab