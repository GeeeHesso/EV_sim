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



data=np.genfromtxt('data.csv',delimiter=',')
# data=np.genfromtxt('dataPont1.csv',delimiter=',')
# data=np.genfromtxt('dataPont2.csv',delimiter=',')
# data=np.genfromtxt('dataTunel1.csv',delimiter=',')
# data=np.genfromtxt('dataTunel2.csv',delimiter=',')

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
		pass
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
data_x1= data_x1[~np.isnan(data_x1)]
data_y1= data_y1[~np.isnan(data_y1)]

data_x2=np.array(data[:,3])
data_y2=np.array(data[:,4])
data_x2= data_x2[~np.isnan(data_x2)]
data_y2= data_y2[~np.isnan(data_y2)]

dist1_end=np.linspace(0,inter_d1[-1],1000)
dist2_end=np.linspace(0,inter_d2[-1],1000)

inter_x1 = np.interp(dist1_end,inter_d1,data_x1)
inter_y1 = np.interp(dist1_end,inter_d1,data_y1)

inter_x2 = np.interp(dist2_end,inter_d2,data_x2)
inter_y2 = np.interp(dist2_end,inter_d2,data_y2)



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
#####################################################

plt.plot(data[:,1],data[:,0],'x',color='r')
plt.plot(data[:,4],data[:,3],color='b')
plt.title("Position")
plt.figure()

plt.plot(distance_1,data[:,2],'x',color='r')
plt.plot(distance_2,data[:,5],color='b')
plt.title("Height")

plt.figure()
plt.plot(diff_1)
plt.title("Slope")
plt.figure()
plt.plot(diff_2)
plt.title("Slope")

plt.figure()
plt.plot(d_d1)
plt.title("Diff distance")
plt.figure()
plt.plot(d_d2)
plt.title("Diff distance")

plt.figure()
plt.plot(inter_y1,inter_x1,'x',color='r')
plt.plot(inter_y2,inter_x2,color='b')
plt.title("Interpolation")


plt.show()