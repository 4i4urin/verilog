import numpy as np


x = np.random.randn(100000)

x = x/np.max(np.abs(x)) * (2**20-1)
x= np.round(x)
np.savetxt('input.txt',x,'%d')
