
code.coset_leader_weight_distribution
code.encode([1,1,0,0])
#fazer reshape para passar uma mensagem maior
code.decode([1,1,1,1,1,1,1])
code.decode([0,1,0,0,0,1,1])
code.decode([0,1,0,0,0,1,1], method='syndrome_table')
#síndrome é o padrão, por isso não muda
code.decode([0,1,0,0,0,1,1], method='exhaustive_search_soft')
#0 <-> +1, 1 <-> -1 para bpsk, qam é ao contrário
#BER
N_cw = 100000 #Número de palavras-código transmitidas
code = komm.HammingCode(3) #Código a ser utilizado
EbN0_list = np.arange(-1.0, 8.0, step = 1.0) #Matlab: -1:1:7 #em python não pega o 8 (último)
#100000*k palavras-código (400000)
k = code.dimension
n = code.length
R = code.rate
u = np.random.randint(2, size = k*N_cw) # vai de zero até 2 sem incluir o 2, então vai de zero até 1, size
u.shape #tupla com um único elemento
type(u.shape)
#para codificar, fazer o reshape e codificar um por um
u_reshaped = np.reshape(u,newshape = (N_cw,k)) #matriz que eu quero fazer o reshape, newshape (novo formato - que eu desejo, N_cw linhas, k colunas
u_reshaped
A = np.array([[1,2,3],[4,5,6]]) #lista de listas
np.prod([1,2,3]) #faz o produto entre os elementos desta linha
np.apply_along_axis(np.prod, axis = 1, arr = A) #pega um array e aplica uma função para cada linha dele. eixo 1 = linha a linha
#acima era só um exemplo
c_reshaped = np.apply_along_axis(code.encode, axis = 1, arr = u_reshaped) #codifica e joga em outro array
#matlab: rowfun ao invés de apply_along_axis
u_reshaped
c_reshaped
c = np.reshape(c_reshaped, newshape = (n*N_cw,)) #matlab (n*N_cw, 1)
#matlab faz reshape em colunas
#não pode transmitir zeros e uns no canal awgn, então precisa modular ((*2)-1)
mod = komm.PAModulation(2) #cada pulso com amplitude diferente. Podia ser a continha acima (polar)
s = mod.modulate(c)
Pb = []
for EbN0 in EbN0_list:
    EbN0_linear = 10**(EbN0/10)
    Eb = np.linalg.norm(s)**2 #Eb = total de energia transmitida (cada elem. ao quadrado somado, que dá 700000)/ número de bits de informação (400000)
    #Eb = np.dot(s,s) / (k*N_cw)
    #matlab = dot(s, s_transposto) ou norm(s)
    #dá para tirar do for
    N0 = Eb/EbN0_linear
    w = np.random.randn(n*N_cw) * np.sqrt(N0/2) #vetor gaussiano com média zero e variância 1, multiplica pela raiz da variância do canal awgn (N0) para mudar a variância 1
    r = s + w #canal awgn
    b = mod.demodulate(r) #positivo bit 1, negativo bit zero
    b_reshaped = np.reshape(b, newshape = (N_cw, n))#fazer reshape
    u_hat_reshaped = np.apply_along_axis(code.decode, axis = 1, arr = b_reshaped)#decodificar linha a linha
    u_hat = np.reshape(u_hat_reshaped, newshape = (k*N_cw))
    Pb.append(np.sum(u != u_hat)/(k*N_cw)) #quantidade de erros
#armazenar num vetor e depois colocar pontos
    print(EbN0)
    taxa_Pb = Pb_sim / len(x_3)
    
plt.figure(1)     
plt.semilogy(EbN0, taxa_Pb, 'r')
plt.title('Prob de erro de bit simulada')
plt.xlabel('Eb/N0')
plt.ylabel('Pb')   
    
plt.show()    
