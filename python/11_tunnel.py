import numpy as np
import matplotlib.pyplot as plt


def correct_length(data,added_length):
	new_data=np.zeros(len(data)+2*added_length)
	new_data[0:added_length]=data[0]#padding before
	new_data[-added_length:]=data[-1]#padding after
	new_data[added_length:-added_length]=data#real data"

	return new_data

# def correct_length_2X(data,added_length):
# 	new_data_t=correct_length(data,added_length)

# 	new_data=np.zeros(2*len(new_data_t))

# 	new_data[len(new_data_t):]= new_data_t #real data"

# 	return new_data

def edge_detector(data,size,dead):

	filter_edge=(1./(size-dead))*np.ones(size)
	filter_edge[0:int((size+1)/2)]=-(1./(size-dead)) #Start of the filter
	filter_edge[int((size-1)/2)-int((dead-1)/2):int((size-1)/2)+int((dead-1)/2)+1]=0 #middle of the filter/dead zone

	edge_1=np.convolve(filter_edge,data,'same')
	edge_2=np.convolve(-filter_edge,data,'same')
	edge_1[0:int((size+1)/2)]=edge_1[int((size+1)/2)+1]
	edge_1[-int((size+1)/2):]=edge_1[-(int((size+1)/2)+1)]
	edge_2[0:int((size+1)/2)]=edge_2[int((size+1)/2)+1]
	edge_2[-int((size+1)/2):]=edge_2[-(int((size+1)/2)+1)]

	return [edge_1,edge_2]

def ridge_diff(data,size,dead):

	filter_ridge=(1./(size-dead))*np.ones(size)
	filter_ridge[int((size-1)/2)-int((dead-1)/2):int((size-1)/2)+int((dead-1)/2)+1]=0 #middle of the filter/dead zone

	ridge_1=np.convolve(filter_ridge,data,'same')
	ridge_1[0:int((size+1)/2)]=ridge_1[int((size+1)/2)+1]
	ridge_1[-int((size+1)/2):]=ridge_1[-(int((size+1)/2)+1)]
	r_data=data-ridge_1

	return r_data

def DFF_1(data,cut_off):

	#gives the frequency of the data between -0.5 and 0.5

	fourrier_data=np.fft.fft(data)
	fourrier_data_frequ=np.fft.fftfreq(len(data))
	len_frequ=len(fourrier_data.real)

	start_frequ=int(cut_off*(len_frequ))
	end_frequ=int((1 - cut_off)*(len_frequ))

	fourrier_out=np.fft.fft(data)
	fourrier_out.real[:]=0
	fourrier_out.imag[:]=0

	fourrier_out.real[start_frequ:end_frequ]=fourrier_data.real[start_frequ:end_frequ]
	fourrier_out.imag[start_frequ:end_frequ]=fourrier_data.real[start_frequ:end_frequ]

	fourrier_data_inv=np.fft.ifft(fourrier_out)

	fourrier_data_inv[0]=0
	fourrier_data_inv[-1]=0

	return fourrier_data_inv

def DFF_2(data,cut_off):

	#gives the frequency of the data between -0.5 and 0.5

	fourrier_data=np.fft.fft(data)
	fourrier_data_frequ=np.fft.fftfreq(len(data))
	len_frequ=len(fourrier_data.real)

	start_frequ=int(cut_off*(len_frequ))
	end_frequ=int((1 - cut_off)*(len_frequ))

	fourrier_out=np.fft.fft(data)
	# fourrier_out.real[:]=0
	# fourrier_out.imag[:]=0

	fourrier_out.real[start_frequ:end_frequ]=0
	fourrier_out.imag[start_frequ:end_frequ]=0

	fourrier_data_inv=np.fft.ifft(fourrier_out)

	fourrier_data_inv[0]=0
	fourrier_data_inv[-1]=0

	return fourrier_data_inv

def DFF_half(data):

	#gives the frequency of the data between -0.5 and 0.5

	fourrier_data=np.fft.fft(data)
	
	fourrier_data.real[0:int(len(fourrier_data)/2)]=0
	fourrier_data.imag[0:int(len(fourrier_data)/2)]=0

	fourrier_data_inv=np.fft.ifft(fourrier_data)

	fourrier_data_inv[0]=0
	fourrier_data_inv[-1]=0

	return fourrier_data_inv.imag

def derivative(data):
	
	derivative_filter=[1,-1,0]
	l_d = np.convolve(derivative_filter,data,'same')
	l_d[0:2]=l_d[2]
	l_d[-2:]=l_d[-3]

	return l_d

def derivative_2(data):
	derivative_filter=[1,-2,1]
	l_d = np.convolve(derivative_filter,data,'same')
	l_d[0:2]=l_d[2]
	l_d[-2:]=l_d[-3]

	return l_d


def display_2(data1,data2,title):
	fig,ax = plt.subplots()
	ax.plot(data1,color='b')
	ax2=ax.twinx()
	ax2.plot(data2,color='r')
	plt.title(title)

def display_der(data1,data2):

	fig,ax = plt.subplots()
	ax.plot(data1,color='b')
	ax2=ax.twinx()
	ax2.plot(data2,color='r')
	ax2.axhline(y=0.1, color='k', linestyle='-')
	ax2.axhline(y=-0.1, color='k', linestyle='-')
	plt.title('Derivative ++')

	new_data=np.copy(data2)

	for i in range(len(new_data)):
		if new_data[i] < 0.1 and new_data[i] > -0.1:
			new_data[i] = 0


	tunnel = False
	points = []

	for i in range(len(new_data)):
		if new_data[i] > 0 and tunnel == False:
			tunnel = True
			points.append([[i,data1[i]],[0,0],[0,0]])
		if new_data[i] < 0 and tunnel == True:
			points[-1][1] = [i,data1[i]]
			if new_data[i+1] == 0:
				tunnel = False


	plt.figure()
	plt.plot(new_data)

	plt.figure()
	plt.plot(data1)
	for i in range(len(points)):
		m=(points[i][0][1]-points[i][1][1])/(points[i][0][0]-points[i][1][0])
		h=points[i][0][1]-m*points[i][0][0]
		points[i][2][0]=m
		points[i][2][1]=h
		plt.plot(points[i][0][0],points[i][0][1],'xr')
		plt.plot(points[i][1][0],points[i][1][1],'xk')
	# plt.plot(points[1],'x')


	# print(points[0][0][0])
	# print(points[0][0][1])
	# print(points[0][1][0])
	# print(points[0][1][1])
	# print(points[0][2][0])
	# print(points[0][2][1])
	data_end = np.copy(data1)
	for i in range(len(points)):
		for j in range(len(data1)):
			if j >= points[i][0][0] and j <= points[i][1][0]:
				# Correct for tunnel
				data_end[j] = points[i][2][0]*j+points[i][2][1]


	# np.savetxt('tunnel4.csv',data_end,delimiter=',',newline='\n')

	plt.figure()
	plt.plot(data1)
	plt.plot(data_end)


data=np.genfromtxt('tunnels.csv',delimiter=',')

dist1=data[:,0]
data1=data[:,1]
dist1=dist1[~np.isnan(dist1)]
data1=data1[~np.isnan(data1)]

dist2=data[:,2]
data2=data[:,3]
dist2=dist2[~np.isnan(dist2)]
data2=data2[~np.isnan(data2)]

dist3=data[:,4]
data3=data[:,5]
dist3=dist3[~np.isnan(dist3)]
data3=data3[~np.isnan(data3)]

dist4=data[:,6]
data4=data[:,7]
dist4=dist4[~np.isnan(dist4)]
data4=data4[~np.isnan(data4)]

dist5=data[:,8]
data5=data[:,9]
dist5=dist5[~np.isnan(dist5)]
data5=data5[~np.isnan(data5)]

dist6=data[:,10]
data6=data[:,11]
dist6=dist6[~np.isnan(dist6)]
data6=data6[~np.isnan(data6)]


# print(dist1)



p_data=data1
# p_data=data2
# p_data=data3
# p_data=data4
# p_data=data5 #bof...
# p_data=data6
#Let's do some cleaning!

pad=1001
#smoothing
N=201
lissage_h=(1./N)*np.ones(N)
c_p_data=correct_length(p_data,pad)
s_p_data=np.convolve(lissage_h,c_p_data,'same')
s_p_data[-N:]=c_p_data[-N:]
s_p_data[:N]=c_p_data[:N]





[r_1,r_2] = edge_detector(s_p_data,1001,501)


r_3 = ridge_diff(s_p_data,1001,501)

r_4 = DFF_1(s_p_data,0.001)

r_5 = derivative(s_p_data)
r_6 = derivative_2(s_p_data)

r_7 = DFF_2(s_p_data,0.2)

r_8 = DFF_half(s_p_data)



display_2(p_data,r_1[pad:-pad],'edge1')
display_2(p_data,r_2[pad:-pad],'edge2')
display_2(p_data,r_3[pad:-pad],'ridge_diff')
display_2(p_data,r_4[pad:-pad],'dff1')
display_2(p_data,r_5[pad:-pad],'derivative1')
display_2(p_data,r_6[pad:-pad],'derivative2')
display_2(p_data,r_7[pad:-pad],'dff2')
display_2(p_data,r_8[pad:-pad],'dff_half')



display_der(p_data,r_5[pad:-pad])




# plt.plot(r_1)
# plt.plot(r_2)
# plt.plot(r_3)
# plt.plot(r_4.real)
# plt.plot(r_4.imag)

# plt.figure()
# plt.plot(r_5)

# plt.figure()
# plt.plot(r_6)

# plt.figure()
# plt.plot(r_4_c)

# plt.figure()
# plt.plot(data1)
# plt.plot(r_4)











# plt.figure()
# plt.plot(data1)
# plt.figure()
# plt.plot(data2)
# plt.figure()
# plt.plot(data3)
# plt.figure()
# plt.plot(data4)
# plt.figure()
# plt.plot(data5)
# plt.figure()
# plt.plot(data6)

plt.show()