import math
import numpy as np
import matplotlib.pyplot as plt


# t=np.arange(10)
# # print(t)

# s=lambda x : np.sin(x)

# a_sin=[s(i) for i in t]

# # print(a_sin)
# f_a_sin =np.fft.fft(a_sin)

# f_a_sin_f=np.fft.fftfreq(len(a_sin))


# plt.plot(a_sin)
# plt.figure()
# plt.plot(f_a_sin.real)
# plt.plot(f_a_sin.imag)
# plt.figure()
# plt.plot(f_a_sin_f,f_a_sin.real)
# plt.plot(f_a_sin_f,f_a_sin.imag)
# # plt.plot(t)
# plt.show()


# t = np.arange(256)
# sp = np.fft.fft(np.sin(t))
# freq = np.fft.fftfreq(t.shape[-1])
# plt.plot(freq, sp.real, freq, sp.imag)
# plt.show()


s=np.zeros(1000)

t=[0.25,0.5,0.75,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.75,0.51,0.25]

pos=50

s[pos:pos+len(t)]=t

f_s=np.fft.fft(s)

i_s=np.fft.ifft(f_s)

# ---
# f_s.real[100:900]=0
# f_s.imag[100:900]=0

# f_s.real[0:200]=0
# f_s.imag[0:200]=0

# f_s.real[800:]=0
# f_s.imag[800:]=0

f_s.real[0:500]=0
f_s.imag[0:500]=0

# f_s.real[500:]=0
# f_s.imag[500:]=0


i2_s=np.fft.ifft(f_s)

plt.plot(s)
plt.figure()
plt.plot(f_s.real)
plt.plot(f_s.imag)
plt.figure()
plt.plot(i_s)
plt.figure()
plt.plot(i2_s.real)
plt.plot(i2_s.imag)
plt.show()