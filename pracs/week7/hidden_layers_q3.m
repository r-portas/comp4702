layers = [0.024989, 0.01906, 0.014973, 0.014544];
epoches = [86, 114, 125, 116];

figure
a=[layers', zeros(4,1)];
b=[zeros(4,1), epoches'];
[AX,H1,H2] =plotyy([1:4],a, [1:4],b, 'bar', 'bar');
set(H1,'FaceColor','r') % a
set(H2,'FaceColor','b') % b
set(gca, 'XTickLabel', {'15', '30', '45', '60'});

legend([H1(1) H2(1)], 'Validation Performance', 'Epoches')
xlabel('Hidden Neurons');
