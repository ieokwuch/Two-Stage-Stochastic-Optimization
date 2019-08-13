figure (1)
load risk
load values

plot(risk, vals(:,3), 'b--o')

title(' Cost vs Risk Curve for Quadractic Obj fn.', 'FontSize', 32)
xlabel('Acceptable Risk (theta * std dev of K)', 'FontSize', 29)
ylabel('Cost (fsim)', 'FontSize', 29)

figure (2)
load costs
plot(scenarios, costs_opt, 'b--o')
title('Change in TSP Optimization Costs with Number of Scenarios ', 'FontSize', 31)
xlabel('Number of Scenarios', 'FontSize', 29)
ylabel('Cost (f)', 'FontSize', 29)
legend('Optimization','Simulation')