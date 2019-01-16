import numpy as np
import matplotlib.pyplot as plt


def dist_2_pointsLatLong(lat,lon):
	r=6371000 #earth radius [m]
	d_lat  = lat[1]-lat[0]
	d_lon  = lon[1]-lon[0]
	s_1=np.power(np.sin(np.radians(d_lat/2)),2)
	s_2=np.power(np.sin(np.radians(d_lon/2)),2)
	c= np.cos(lat[1])*np.cos(lat[0])

	d_t=np.arcsin(np.sqrt(s_1+c*s_2)) #Haversine formula

	d=2*r*d_t

	# print("******")
	# print(d_lat)
	# print(d_lon)
	# print(s_1)
	# print(s_2)
	# print(c)
	# print(d_t)
	# print("******")
	return d



# data=np.genfromtxt('data.csv',delimiter=',')
# data=np.genfromtxt('dataPont1.csv',delimiter=',')
# data=np.genfromtxt('dataPont2.csv',delimiter=',')
# data=np.genfromtxt('dataTunel1.csv',delimiter=',')
data=np.genfromtxt('dataTunel2.csv',delimiter=',')

distance_1=[0]
distance_2=[0]
diff_1=[0] #Slope[%]
diff_2=[0] #Slope[%]
d_d1=[0] #Difference in distance[m]
d_d2=[0] #Difference in distance[m]

for t in range(len(data[:,4])):
	if t == 0:
		continue

	d1=dist_2_pointsLatLong([data[t,0],data[t-1,0]],[data[t,1],data[t-1,1]])
	d2=dist_2_pointsLatLong([data[t,3],data[t-1,3]],[data[t,4],data[t-1,4]])

	# print(d1)
	# print(d2)

	distance_1.append(distance_1[t-1]+d1)
	distance_2.append(distance_2[t-1]+d2)

	# print(t)
	d_d1.append((distance_1[t]-distance_1[t-1]))
	d_d2.append((distance_2[t]-distance_2[t-1]))
	if d_d1[t]==0 or d_d2[t]==0:
		diff_1.append(0)
		diff_2.append(0)
	else:
		df1=(data[t,2]-data[t-1,2])/(d_d1[t])
		df2=(data[t,5]-data[t-1,5])/(d_d2[t])

		diff_1.append(df1)
		diff_2.append(df2)


#####################################################
# Interpolation
#####################################################

inter_d1=np.array(distance_1)
inter_d2=np.array(distance_2)
inter_d1 = inter_d1[~np.isnan(inter_d1)]
inter_d2 = inter_d2[~np.isnan(inter_d2)]

data_x1=np.array(data[:,0])
data_y1=np.array(data[:,1])
data_z1=np.array(data[:,2])
data_x1= data_x1[~np.isnan(data_x1)]
data_y1= data_y1[~np.isnan(data_y1)]
data_z1= data_z1[~np.isnan(data_z1)]


data_x2=np.array(data[:,3])
data_y2=np.array(data[:,4])
data_z2=np.array(data[:,5])
data_x2= data_x2[~np.isnan(data_x2)]
data_y2= data_y2[~np.isnan(data_y2)]
data_z2= data_z2[~np.isnan(data_z2)]

step_interp=int(distance_2[-1])

dist1_end=np.linspace(0,inter_d1[-1],step_interp)
dist2_end=np.linspace(0,inter_d2[-1],step_interp)

inter_x1 = np.interp(dist1_end,inter_d1,data_x1)
inter_y1 = np.interp(dist1_end,inter_d1,data_y1)
inter_z1 = np.interp(dist1_end,inter_d1,data_z1)

inter_x2 = np.interp(dist2_end,inter_d2,data_x2)
inter_y2 = np.interp(dist2_end,inter_d2,data_y2)
inter_z2 = np.interp(dist2_end,inter_d2,data_z2)

# np.savetxt('tunnel2.csv',np.array([dist1_end,inter_z1]).T,delimiter=',')



# interp_diff_1=[0] #Slope[%]
# interp_diff_2=[0] #Slope[%]
# interp_d_d1=[0] #Difference in distance[m]
# interp_d_d2=[0] #Difference in distance[m]

# for t in range(len(data_x1)):
# 	if t == 0:
# 		continue

# 	interp_d_d1.append((distance_1[t]-distance_1[t-1]))
# 	interp_d_d2.append((distance_2[t]-distance_2[t-1]))
# 	if d_d1[t]==0 or d_d2[t]==0:
# 		pass
# 	else:
# 		df1=(data[t,2]-data[t-1,2])/(d_d1[t])
# 		df2=(data[t,5]-data[t-1,5])/(d_d2[t])

# 		interp_diff_1.append(df1)
# 		interp_diff_2.append(df2)

#####################################################
# Invert
#####################################################

# inter_x1=np.flip(inter_x1,axis=0)
# inter_y1=np.flip(inter_y1,axis=0)
# inter_z1=np.flip(inter_z1,axis=0)


#####################################################
# Lissage
#####################################################

N=3
lissage=(1./N)*np.ones(N)
N=301
lissage_h=(1./N)*np.ones(N)
# lissage_h=(1./(N-M))*np.ones(N)
# lissage_h[int((N-1)/2)-int((M-1)/2):int((N-1)/2)+int((M-1)/2)+1]=0

l_x1=np.convolve(lissage,inter_x1,'same')
l_y1=np.convolve(lissage,inter_y1,'same')
l_z1=np.convolve(lissage_h,inter_z1,'same')
l_z1[0:int((N+1)/2)]=inter_z1[0:int((N+1)/2)]
l_x1[0:4]=inter_x1[0:4]
l_y1[0:4]=inter_y1[0:4]
l_z1[-int((N+1)/2):]=inter_z1[-int((N+1)/2):]
l_x1[-5:]=inter_x1[-5:]
l_y1[-5:]=inter_y1[-5:]

N=3
lissage=(1./N)*np.ones(N)
N=301
lissage_h=(1./N)*np.ones(N)
# lissage_h=(1./(N-M))*np.ones(N)
# lissage_h[int((N-1)/2)-int((M-1)/2):int((N-1)/2)+int((M-1)/2)+1]=0

l_x2=np.convolve(lissage,inter_x2,'same')
l_y2=np.convolve(lissage,inter_y2,'same')
l_z2=np.convolve(lissage_h,inter_z2,'same')
l_z2[0:int((N+1)/2)]=inter_z2[0:int((N+1)/2)]
l_y2[0:4]=inter_y2[0:4]
l_x2[0:4]=inter_x2[0:4]
l_z2[-int((N+1)/2):]=inter_z2[-int((N+1)/2):]
l_y2[-5:]=inter_y2[-5:]
l_x2[-5:]=inter_x2[-5:]

print(np.sum(lissage_h))
#####################################################
# Computation on Lissage
#####################################################

# We only keep l_1 as l_2 does not really give any good results

#first derivative
l_d_d1=[0]
l_diff_1=[0]
for t in range(len(l_x1)):
	if t == 0:
		continue
	l_d_d1.append(dist1_end[t]-dist1_end[t-1])
	
	if l_d_d1[t]==0:
		pass
	else:
		l_df1=(l_z1[t]-l_z1[t-1])/(l_d_d1[t])
		l_diff_1.append(l_df1)


l_d_d2=[0]
l_diff_2=[0]
for t in range(len(l_x2)):
	if t == 0:
		continue
	l_d_d2.append(dist2_end[t]-dist2_end[t-1])
	
	if l_d_d2[t]==0:
		pass
	else:
		l_df2=(l_z2[t]-l_z2[t-1])/(l_d_d2[t])
		l_diff_2.append(l_df2)

# second derivative
h1=l_d_d1[1]
h2=l_d_d2[1]

l_ddf1=0
l_ddiff_1=[]
for t in range(len(l_z1)):
	if t == 0 or t == len(l_z1)-1:
		l_ddiff_1.append(0)
		continue
	
	l_ddf1=(l_z1[t+1]-2*l_z1[t]+l_z1[t-1])/h1
	l_ddiff_1.append(l_ddf1)

l_ddf2=0
l_ddiff_2=[]
for t in range(len(l_z1)):
	if t == 0 or t == len(l_z1)-1:
		l_ddiff_2.append(0)
		continue
	
	l_ddf2=(l_z2[t+1]-2*l_z2[t]+l_z2[t-1])/h2
	l_ddiff_2.append(l_ddf2)

#####################################################
# From derivative to height
#####################################################

N=101
d_filter=1/N*np.ones(N)
l_diff_1_liss=np.convolve(np.array(l_diff_1),d_filter,'same')

height_integral=[l_z1[0]]

limit=0.15
limit_2=0.15

for d in l_diff_1_liss:
	if d > limit:
		d_corr = limit_2
	elif d < -limit:
		d_corr = -limit_2
	else:
		d_corr=d
	height_integral.append(height_integral[-1]+d_corr)

# ---
N=1001
d_filter=1/N*np.ones(N)
l_ddiff_1_liss=np.convolve(np.array(l_ddiff_1),d_filter,'same')

diff_1_integral=[l_diff_1[0]]
height_integral_2=[l_z1[0]]
limit=10
limit_2=0

for d in l_ddiff_1_liss:
	diff_1_integral.append(diff_1_integral[-1]+d)

for d in diff_1_integral:
	height_integral_2.append(height_integral_2[-1]+d)


#####################################################
# Gauss fitting
#####################################################

pass

#####################################################
# Fourrier transform
#####################################################

height_fourrier=np.fft.fft(inter_z1)
height_fourrier2=np.fft.fft(inter_z1)
height_fourrier_freq=np.fft.fftfreq(len(inter_z1))
height_fourrier_inv=np.fft.ifft(height_fourrier)


#filter
len_frequ=len(height_fourrier.real)

denom=2000
start_frequ=int(1*(len_frequ+1)/denom)
end_frequ=int(((denom-1)*(len_frequ+1)/denom)-1)

# height_fourrier.real +=50

# height_fourrier.real[start_frequ:end_frequ]=0
# height_fourrier.imag[start_frequ:end_frequ]=0

height_fourrier2.real[:]=0
height_fourrier2.imag[:]=0

height_fourrier2.real[start_frequ:end_frequ]=height_fourrier.real[start_frequ:end_frequ]
height_fourrier2.imag[start_frequ:end_frequ]=height_fourrier.real[start_frequ:end_frequ]


height_fourrier_inv_filtered=np.fft.ifft(height_fourrier2)




#####################################################
# Least square
#####################################################

m,c=np.linalg.lstsq(np.vstack([dist1_end, np.ones(len(dist1_end))]).T,l_z1)[0]

z_flaten=l_z1-m*dist1_end-c


#####################################################
# Processing
#####################################################

#Raising edge [- 0 +]

size_1=1001
dead_1=0
filter_raise_edge=(1./(size_1-dead_1))*np.ones(size_1)
filter_raise_edge[0:int((size_1+1)/2)]=-(1./(size_1-dead_1))
filter_raise_edge[int((size_1-1)/2)-int((dead_1-1)/2):int((size_1-1)/2)+int((dead_1-1)/2)+1]=0
filter_1_height1=np.convolve(filter_raise_edge,l_z1,'same')
filter_1_height2=np.convolve(filter_raise_edge,l_z2,'same')
filter_1_height1[0:int((size_1+1)/2)]=0
filter_1_height1[-int((size_1+1)/2):]=0
filter_1_height2[0:int((size_1+1)/2)]=0
filter_1_height2[-int((size_1+1)/2):]=0

# falling edge [+ 0 -]

size_1=1001
dead_1=0
filter_fall_edge=(1./(size_1-dead_1))*np.ones(size_1)
filter_fall_edge[int((size_1+1)/2):]=-(1./(size_1-dead_1))
filter_fall_edge[int((size_1-1)/2)-int((dead_1-1)/2):int((size_1-1)/2)+int((dead_1-1)/2)+1]=0
filter_2_height1=np.convolve(filter_fall_edge,l_z1,'same')
filter_2_height2=np.convolve(filter_fall_edge,l_z2,'same')
filter_2_height1[0:int((size_1+1)/2)]=0
filter_2_height1[-int((size_1+1)/2):]=0
filter_2_height2[0:int((size_1+1)/2)]=0
filter_2_height2[-int((size_1+1)/2):]=0


# Flat
#Raising edge [- 0 +]

size_1=1001
dead_1=0
filter_raise_flat_edge=(1./(size_1-dead_1))*np.ones(size_1)
filter_raise_flat_edge[0:int((size_1+1)/2)]=-(1./(size_1-dead_1))
filter_raise_flat_edge[int((size_1-1)/2)-int((dead_1-1)/2):int((size_1-1)/2)+int((dead_1-1)/2)+1]=0
filter_3_height1=np.convolve(filter_raise_flat_edge,z_flaten,'same')
filter_3_height1[0:int((size_1+1)/2)]=0
filter_3_height1[-int((size_1+1)/2):]=0
# filter_1_height2[0:int((size_1+1)/2)]=0
# filter_1_height2[-int((size_1+1)/2):]=0

size_1=3
dead_1=0
derivative_filter=[1,0,-1]
derivative_height_flat_filter=np.convolve(filter_raise_edge,filter_3_height1,'same')
derivative_height_flat_filter[0:int((size_1+1)/2)]=0
derivative_height_flat_filter[-int((size_1+1)/2):]=0




#####################################################
# Saving file
#####################################################

# np.savetxt('Lisse1_5.csv',np.array([l_x1,l_y1,l_z1]).T,delimiter=',',newline='\n')
# np.savetxt('Lisse2_5.csv',np.array([l_x2,l_y2,l_z2]).T,delimiter=',',newline='\n')

# np.savetxt('Interp1.csv',np.array([inter_x1,inter_y1,inter_z1]).T,delimiter=',',newline='\n')
# np.savetxt('Interp2.csv',np.array([inter_x2,inter_y2,inter_z2]).T,delimiter=',',newline='\n')




# #####################################################
# #####################################################
# plt.plot(data[:,1],data[:,0],'x',color='r')
# plt.plot(data[:,4],data[:,3],color='b')
# plt.title("Position")
# plt.figure()

# plt.plot(distance_1,data[:,2],'x',color='r')
# plt.plot(distance_2,data[:,5],color='b')
# plt.title("Height")

# plt.figure()
# plt.plot(distance_1,diff_1)
# plt.title("Slope")
# plt.figure()
# plt.plot(distance_1,diff_2)
# plt.title("Slope")

# plt.figure()
# plt.plot(d_d1)
# plt.title("Diff distance")
# plt.figure()
# plt.plot(d_d2)
# plt.title("Diff distance")

# plt.figure()
# plt.plot(inter_y1,inter_x1,'x',color='r')
# plt.plot(inter_y2,inter_x2,color='b')
# plt.title("Interpolation")

# # plt.figure()
# # plt.plot(dist1_end[]-dist1_end[],inter_z1,'x',color='r') #Need to check the height...
# # plt.plot(dist2_end,inter_z2,color='b')
# # plt.title("Height")

# plt.figure()
# plt.plot(inter_y1,inter_x1,color='b')
# plt.plot(l_y1,l_x1,color='r')
# plt.title("Lissage")

# plt.figure()
# plt.plot(dist1_end,inter_z1,color='b')
# plt.plot(dist1_end,l_z1,color='r')
# plt.title("l_Height")

# fig,ax = plt.subplots()
# ax.plot(dist1_end,l_z1,color='b')
# ax2=ax.twinx()
# ax2.plot(dist1_end,l_diff_1,color='r')
# plt.title("Height-slope")

# plt.figure()
# plt.plot(dist2_end,inter_z2,color='b')
# plt.plot(dist2_end,l_z2,color='r')
# plt.title("l_Height")

# fig,ax = plt.subplots()
# ax.plot(dist2_end,l_z2,color='b')
# ax2=ax.twinx()
# ax2.plot(dist2_end,l_diff_2,color='r')
# plt.title("Height-slope")


# fig,ax = plt.subplots()
# ax.plot(dist1_end,filter_1_height1,color='r')
# ax.plot(dist1_end,filter_2_height1,color='g')
# ax2=ax.twinx()
# ax2.plot(dist1_end,l_z1,color='b')


# fig,ax = plt.subplots()
# ax.plot(dist2_end,filter_1_height2,color='r')
# ax.plot(dist1_end,filter_2_height2,color='g')
# ax2=ax.twinx()
# ax2.plot(dist2_end,l_z2,color='b')

# plt.figure()
# plt.plot(dist1_end,filter_3_height1,color='r')
# plt.plot(dist1_end,z_flaten)

# fig,ax = plt.subplots()
# ax.plot(dist1_end,z_flaten,color='r')
# ax2=ax.twinx()
# ax2.plot(dist1_end,derivative_height_flat_filter,color='b')

# plt.figure()
# plt.plot(height_fourrier_freq,height_fourrier.real,height_fourrier_freq,height_fourrier.imag)
# plt.title('DFF')

# plt.figure()
# plt.plot(height_fourrier_inv.real)
# plt.plot(inter_z1)
# plt.title('DFF_inv')

# plt.figure()
# plt.plot(height_fourrier_inv_filtered)
# plt.plot(inter_z1)
# plt.title('DFF_inv Filtered')

# plt.figure()
# plt.plot(height_fourrier_inv_filtered-inter_z1)
# plt.title('DFF_inv Filtered Diff')

plt.figure()
plt.plot(inter_z1,label='Inter')
plt.plot(l_z1,label='Liss')
plt.plot(height_integral,label='Integral')
plt.legend()
plt.title("height_integral")

plt.figure()
plt.plot(inter_z1,label='Inter')
plt.plot(l_z1,label='Liss')
plt.plot(height_integral_2,label='Integral')
plt.legend()
plt.title("height_integral_2")

plt.figure()
plt.plot(l_ddiff_1)
plt.plot(l_ddiff_1_liss)

plt.figure()
plt.plot(diff_1_integral)
plt.plot(l_diff_1)

# plt.figure()
# plt.plot(l_ddiff_1)
# plt.figure()
# plt.plot(l_ddiff_2)

# plt.figure()
# plt.plot(lissage_h)

# plt.figure()
# plt.plot(l_z1- inter_z1)
# plt.figure()
# plt.plot(l_z2- inter_z2)
# # plt.figure()
# # plt.plot(dist1_end)

# plt.figure()
# plt.plot(dist1_end,l_diff_1)

# fig,ax = plt.subplots()
# ax.plot(dist1_end,inter_z1,color='b')
# ax2=ax.twinx()
# ax2.plot(dist1_end,l_diff_1,color='r')
# # plt.figure()
# # plt.plot(l_d_d1)


plt.show()