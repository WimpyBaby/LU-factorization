%load("pipe_values.csv")

% k = pipevalues.k;
% T = pipevalues.L;
% r = 1;
% 
% q1 = -k(1).*T(1)-k(2).*T(2)-k(3).*T(3);
% q2 = k(3).*T(3);
% q3 = k(2).*T(2);
% q4 = q2;
% q5 = -k(3).*T(3)-k(6).*T(6)-k(4).*T(4);
% q6 = k(4).*T(4);
% q7 = q3;
% q8 = q6;
% q9 = -k(2).*T(2)-k(4).*T(4)-k(5).*T(5);
% 
% while (r > 0)
% inpr = input("Input reservoir pressure: ");
% p5 = 0;
% p6 = 0;
% 
% A = [q1 q2 q3; q4 q5 q6; q7 q8 q9];
% b = [-k(1).*T(1).*inpr; -k(6).*T(6).*p6; -k(5).*T(5).*p5];
% 
% [L,U,P] = lu(A);
% 
% y = L\(P*b);
% x = U\y;
% 
% p2 = x(1);
% p3 = x(2);
% p4 = x(3);
% 
% psi = [inpr, p2, p3, p4, p5, p6];
% 
% ave_psi =  mean(psi);
% 
% if ave_psi > 15
%     stem(psi, 'filled', LineWidth=3)
%     xlabel("node")       
%     ylabel("pressure (Average: " + ave_psi + " )")
% 
%     hold on
% 
%     yline(ave_psi,"--", LineWidth=3)
%     legend('Node', 'Average pressure')
% 
%     hold off
% 
%     r = 0;
% else
%     fprintf("Average Pressure below 15 bars!.\n Input another reservoir pressure \n ")
%     pause(.1);
%     r = 1;
% end
% end


load("nat6400.mat");

Lr = 200;
kr = 0.01;
a = 1;

while (a > 0)
    pr1 = input("\n Input the first value for reservoir 1: ");
    pr2 = input("\n Input the first value for reservoir 2: ");
    pr3 = input("\n Input the first value for reservoir 3: ");
    pr4 = input("\n Input the first value for reservoir 4: ");
    pr5 = input("\n Input the first value for reservoir 5: ");
    pr6 = input("\n Input the first value for reservoir 6: ");
    pr7 = input("\n Input the first value for reservoir 7: ");
    pr8 = input("\n Input the first value for reservoir 8: ");

    %skapa en 6400 x 1 matris
    B = zeros(6400,1);

    q1 = -kr*Lr*pr1;
    q2 = -kr*Lr*pr2;
    q3 = -kr*Lr*pr3;
    q4 = -kr*Lr*pr4;
    q5 = -kr*Lr*pr5;
    q6 = -kr*Lr*pr6;
    q7 = -kr*Lr*pr7;
    q8 = -kr*Lr*pr8;

    b = [q1; q2; q3; q4; q5; q6; q7; q8];

    B(1:8,1) = b;

    [L,U,P] = lu(A);

    y = L\(P*B);
    x = U\y;

    ave_psi = mean(x);
    max = max(x);
    min = min(x);

    Ar = reshape(x,80,80);

    view = input("\n Wish to see a graph? 1 for yes 0 for no ");

    if view == 1
        n = input("\n Do you wish to see the graph in 2D(1), 3D(2) or both(3). ");

        switch n
            case 1
                stem(x);
                hold on
                yline(ave_psi)
                yline(min)
                yline(max)

                hold off

            case 2
                surf(X,Y,Ar);
            case 3
                nexttile
                stem(x);
                hold on
                yline(ave_psi)
                yline(min)
                yline(max)

                hold off
    
                nexttile
                surf(X,Y,Ar);
            otherwise
                disp("Enter a valid value! ")
    
        end
    elseif view == 0
        continue
    else
        disp("Enter a valid value!")
    end
    xlabel("node")
    zlabel("pressure in bar")

    v = input("\nWish to continue? 1 for yes 0 for no ");
    if v == 1
        continue
    elseif v == 0
        a = 0;
        break
    end
end
    


