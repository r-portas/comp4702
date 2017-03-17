% in is the input array
% n is the group size
function out = q6(in, n)

    out = [];
    
    chunks = length(in)/n;

    for i = 1:chunks
        end_ind = length(in) - i * n + n;

        start_ind = end_ind - n + 1;
        start_ind = max([1, start_ind]);

        temp = in(start_ind:end_ind);

        out = [out, temp];
    end

end
