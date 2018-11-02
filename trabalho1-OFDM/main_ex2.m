
ha = [1];
hb = [1 0.25];
hc = [1 0.25 0.5];
hd = [1 0.25 0.5 0.25];
N = 4;
u = 2;
X = [1 1 -1 -1 -1 1 -1 1];

x_n = ex1_transmissor(X,N,u);

X_a = ex2_receptor(x_n, ha, N, u)
X_b = ex2_receptor(x_n, hb, N, u)
X_c = ex2_receptor(x_n, hc, N, u)
X_d = ex2_receptor(x_n, hd, N, u)