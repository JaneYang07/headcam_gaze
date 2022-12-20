function FourEllipticVenn( sets, data, diagramTitle, filename)
% Draw a four elliptic venn diagram 
% Input:
%   - for sets = { A, B , C, D}
%   - data is a fifteen element cell of:
%       |A|
%       |B|
%       |C|
%       |D|
%       |A and B|
%       |A and C|
%       |B and C|
%       |A and B and C|
%       |A and D|
%       |B and D|
%       |C and D|
%       |A and B and D|
%       |A and C and D|
%       |B and C and D|
%       |A and B and C and D|
% Example:
%     FourEllipticVenn( { 'Set 1', 'Set 2' , 'Set 3', 'Set 4'}, {'A', 'B', 'C', 'D', 'AB', 'AC', 'BC', 'ABC', 'AD', 'BD', 'CD', 'ABD', 'ACD', 'BCD', 'ABCD' }, 'Four Elliptic Venn' )
% Implemented by Shaimaa Omer 2020

% venn diagram for roi, dom, child_inhand, and parent_inhand
% needed: roi, dom, child_inhand, and parent_inhand
%         roi&dom, roi&child_inhand, roi&parent_inhand, dom&child_inhand,
%         dom&parent_inhand, child_inhand&parent_inhand
%         roi&dom&child_inhand, roi&dom&parent_inhand,
%         roi&child_inhand&parent_inhand, dom&child_inhand&parent_inhand
%         roi&dom&child_inhand&parent_inhand

    figure();

    if length(data)~=15
        msgbox('Data cell must be of length 15', 'Error','error'); 
    else 
        axesm mercator
        ecc = axes2ecc(8,4);
        xo = 4; yo = 2.5; ang = 55;
        [elat,elon] = ellipse1(xo,0,[10 ecc],ang);
        patch('XData',elat,'YData',elon,'FaceColor','blue','FaceAlpha',.5,'EdgeColor','none');
        [elat,elon] = ellipse1(-1*xo,0,[10 ecc],-1*ang);
        patch('XData',elat,'YData',elon,'FaceColor','red','FaceAlpha',.5,'EdgeColor','none');
        [elat,elon] = ellipse1(0,yo,[10 ecc],ang);
        patch('XData',elat,'YData',elon,'FaceColor','green','FaceAlpha',.5,'EdgeColor','none');
        [elat,elon] = ellipse1(0,yo,[10 ecc],-1*ang);
        patch('XData',elat,'YData',elon,'FaceColor','Cyan','FaceAlpha',.5,'EdgeColor','none');
        title(diagramTitle);
    
        xlim([-14 14])
        ylim([-10 14])
    
        tx = text([9.5 4.5 -4.5 -9.5],[10 12.5 12.5 10], sets,'HorizontalAlignment','center','VerticalAlignment','middle','FontUnits', 'Normalized', 'FontSize', 0.06);
        tx(1).Color = 'blue';
        tx(2).Color = 'green';
        tx(3).Color = 'cyan';
        tx(4).Color = 'red';
        text([8 3.5 -3.5 -8],[2.5 9.5 9.5 2.5], {data{1:4}},'HorizontalAlignment','center','VerticalAlignment','middle','FontUnits', 'Normalized', 'FontSize', 0.05);
        text([5.5 5 0 3 0 -5 -5.5 -1.75 1.75 -3 0],[6.5 -2 6.5 2.5 -7 -2 6.5 -4.5 -4.5 2.5 -2], data(5:15),'HorizontalAlignment','center','VerticalAlignment','middle','FontUnits', 'Normalized', 'FontSize', 0.05);
    end

    saveas(gcf,filename);
end