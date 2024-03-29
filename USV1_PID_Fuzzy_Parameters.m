

% Thong so USV
m = 150;
x_G = 0;
y_G = 0;
T = 0.12; % Draft
L = 4.29; % Overall length
LCG = 1.27; % Longitudinal Center of Gravity with respect to aft plane of engine pods
B_hull = 0.3;
Width = 1.83;
Iz = m*(L^2)/12;

% Thong so khac
rho = 1000; % Khoi luong rieng cua nuoc
u_0 = 0.75;
v_0 = 0.75;

% Hydrodynamic coefficients
X_d_u = 0.075 *(-m);
Y_d_v = 0.9 * (-pi*rho*(T.^2)*L);
Y_d_r = 0.2 * ( -pi*rho*(T.^2) * ((L-LCG).^2 + LCG.^2)/2 );
N_d_v = 2.5 * ( -pi*rho*(T.^2) * ((L-LCG).^2 + LCG.^2)/2 );
N_d_r = 1.2 * (-1) *( ...
        (4.75/2)*pi*rho*(B_hull/2)*(T.^4) +...
        (pi*rho*(T.^2)*((L-LCG).^3 + LCG.^3)/3 )...
        );

X_u = -40 ;
Y_v = 0.5 *(...
      - 40*rho*abs(v_0) * ...
      (1.1 + 0.0045*(L/T) - 0.1*(B_hull/T) + 0.016*(B_hull/T).^2 ) * ...
      (pi*T*L/2)...
      );
Y_r = 6 * ( -pi*rho*sqrt((u_0.^2)+(v_0.^2))*(T.^2)*L );
N_v = 0.06 * ( -pi*rho*sqrt((u_0.^2)+(v_0.^2))*(T.^2)*L );
N_r = 0.02 * ( -pi*rho*sqrt((u_0.^2)+(v_0.^2))*(T.^2)*L );

% Steady state
U = 1.5;

% He phuong trinh bao toan dong luong - moment dong luong 
M_RB = [ m  0     0     0  ;...
         0  m     m*x_G 0  ;...
         0 m*x_G  Iz    0  ;...
         0  0     0     1  ];
     
M_A = [ -X_d_u    0           0    0;...
        0        -Y_d_v   -Y_d_r   0;...
        0        -N_d_v   -N_d_r   0;...
        0         0           0    0];

C_RB = [ 0  0   0        0  ;...
         0  0   m*U      0  ;...
         0  0   m*x_G*U  0  ;...
         0  0   -1       0  ]; 
     
C_A = [ 0  0    0     0 ;...
        0  0  -Y_d_v  0 ;...
        0  0  -Y_d_r  0 ;...
        0  0    0     0 ];

D_l = [ -X_u    0     0   0 ;...
        0     -Y_v  -Y_r  0 ;...
        0     -N_v  -N_r  0 ;...
        0       0     0   0 ];
    
Mass = M_RB + M_A;
Coriolis = C_RB + C_A;
F =   [ 1  0  0 ;...
        0  1  0 ;...
        0  0  1 ;...
        0  0  0 ];

% Ma tran State-space
A = Mass\(-Coriolis - D_l);
B = Mass\F;
C = eye(4);
D = [ 0  0  0 ;...
      0  0  0 ;...
      0  0  0 ;...
      0  0  0 ];
  
% Ma tran State-space error state
M_RB1 = [ m  0     0       ;...
         0  m     m*x_G   ;...
         0 m*x_G  Iz     ];
         
     
M_A1 = [ -X_d_u    0           0    ;...
        0        -Y_d_v   -Y_d_r   ;...
        0        -N_d_v   -N_d_r   ];
    
C_RB1 =[ 0  0   0          ;...
         0  0   m*U        ;...
         0  0   m*x_G*U  ];
        
     
C_A1 = [ 0  0    0      ;...
        0  0  -Y_d_v  ;...
        0  0  -Y_d_r ];
         

E = [ -X_u    0     0   ;...
        0     -Y_v  -Y_r   ;...
        0     -N_v  -N_r   ];...
        
%Mass_1 = M_RB1 + M_A1;
%Coriolis1 = C_RB1 + C_A1;
%F1 =   [ 1  0  0 ;...
        %0  1  0 ;...
        %0  0  1 ];
         
        
%A1 = Mass_1\(-Coriolis - E);
%B1 = Mass_1\F1;
%C6 = eye(3);
%D_111 = [ 0  0  0 ;...
      %0  0  0 ;...
      %0  0  0 ];
     
Condition = [1; 0; 0; 3*pi/4];




