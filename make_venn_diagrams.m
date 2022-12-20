clear;

mtx = readmatrix('result_table_venn_diagram_updated.csv');

for i = 1 : size(mtx, 1)
    filename = sprintf('VennDiagram-%d.png',mtx(i,1));
    diagramTitle = sprintf('VennDiagram-%d',mtx(i,1));
    FourEllipticVenn({'roi','dom','child-inhand','parent-inhand'}, {mtx(i,2),mtx(i,3),mtx(i,4),mtx(i,5),mtx(i,6),mtx(i,7),mtx(i,9),mtx(i,12),mtx(i,8),mtx(i,10),mtx(i,11),mtx(i,13),mtx(i,14),mtx(i,15),mtx(i,16)}, diagramTitle,filename);


end