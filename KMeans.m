% K-means cluster for 'Q1-DATA.xlsx', where K = 5
% Author: Zephyr
% Date: 03/15/2018
clear;
clc;
close all;
rand('seed',2);
k = 5;
iterationMax = 1000;
iteration = 0;
% Import data
x = xlsread('Q1-DATA.xlsx');
n = size(x, 1);
% Randomly choose K points as centers
mu = x(randperm(n, k), :);
r = zeros(n, k);
distance = zeros(n, k);
for a = 1 : k
    distance(:, a) = (x(:, 1)-mu(a, 1)).^2 + (x(:, 2)-mu(a, 2)).^2;
end
for a = 1 : n
    r(a, :) = (distance(a, :)==min(distance(a, :))); 
end
JLast = inf;
J = sum(sum(r.*distance));
while J < JLast
    if iteration > iterationMax
        break;
    else
        iteration = iteration + 1;
        JLast = J;
        for a = 1 : k
            mu(a, :) = sum(r(:, a).*x)./sum(r(:, a));
            distance(:, a) = (x(:, 1)-mu(a, 1)).^2 + (x(:, 2)-mu(a, 2)).^2;
        end
        for a = 1 : n
            r(a, :) = (distance(a, :)==min(distance(a, :))); 
        end
        J = sum(sum(r.*distance));
    end
end

figure;
plot(x(:, 1), x(:, 2), 'b.');
grid on;
hold on;
plot(mu(:, 1), mu(:, 2), 'r*');
title('5-Means Cluster');
figure;
hold on;
grid on;
for a = 1 : n
    if r(a, 1)
        plot(x(a, 1), x(a, 2), 'r.');
    elseif r(a, 2)
        plot(x(a, 1), x(a, 2), 'y.');
    elseif r(a, 3)
        plot(x(a, 1), x(a, 2), 'g.');
    elseif r(a, 4)
        plot(x(a, 1), x(a, 2), 'b.');
    else
        plot(x(a, 1), x(a, 2), 'k.');
    end
end
title('5-Means Cluster');