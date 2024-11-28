clear all;
close all;
tolerance = 1e-5;
% input matrix with symbols probability
Probability_inputs = [0.3,0.35,0.1,0.2,0.005,0.04,0.005];
negative_indices = find(Probability_inputs < 0);

greater_than_one_indicies = find(Probability_inputs > 1);

if ~isempty(negative_indices) || ~isempty(greater_than_one_indicies)
    if ~isempty(negative_indices)
        disp('Probability of any symbol can not be negative numbers!');
    end
    if ~isempty(greater_than_one_indicies)
        disp('Probability of any symbol can not be greater than one!');
    end
else

P_length = length(Probability_inputs);

P_sum = sum(Probability_inputs);

P_sorted = sort(Probability_inputs, 'descend');

M = zeros((P_length-1), P_length);

M(1, :) = P_sorted;

 if P_sum == 1
     
    if ismember(1, Probability_inputs)
        for l = 1:P_length
        code(1,l) = "";
        end
    else
  
    for i = 1:(P_length-2)
        p = M(i, :);
        new_prob = sum(p(end-i:end));
        new_p = [M(i, 1:end-i-1), new_prob, zeros(1, i)];
        M(i+1, :) = sort(new_p, 'descend');
    end

    for y = 1:P_length-1
      for x = 1:P_length
        code(y,x) = "";
      end
  end
  code(P_length-1, 1:2) = ["0", "1"];

  for i = (P_length-2):-1:1
      p = M(i, :);
        for j = 1:(P_length-i)
            index = 0;
            element = M(i+1,j);
            
            for k = 1:P_length
                tmp = p(k);
                if abs(tmp-element) < tolerance
                    index = k;
                    p(k)=-1;
                    break;
                end
            end
            
            if index ~= 0
                code(i,index)= code(i+1,j);

            else
                code(i,P_length-i)   = strcat(num2str(code(i+1,j)), "0");
                code(i,P_length-i+1) = strcat(num2str(code(i+1,j)), "1");
            end
            end
            end  
  end
  
  T = table(M(1,:)', code(1,:)', 'VariableNames', {'Symbol_probability', 'Binary_Huffman_code'});
  disp(T);  
  
else
    disp('sum of inputs probabilities does not equal one');
 end
end