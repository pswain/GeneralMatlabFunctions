function output_struct = parse_struct(input_struct,default_struct)
% output_struct = parse_struct(input_struct,default_struct)
%
% replaces any field in default struct with the one present in input struct
% and then returns the modified default_struct.
output_struct = default_struct;
fields = fieldnames(input_struct);
for fi = 1:length(fields);
    output_struct.(fields{fi}) = input_struct.(fields{fi});
end

end

function test()
%% to test

s_d =struct('a',3,'b',4);
s_i = struct('b',6,'c',5);
parse_struct(s_i,s_d)
end
