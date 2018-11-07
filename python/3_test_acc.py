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


def radius_compute(point1,point2,point3,limit):

	# print(point1)
	# print(point2)
	# print(point3)

	inf_flag_S1 = False
	inf_flag_S2	= False

	M1=[point2[0]+point1[0],point2[1]+point1[1]]
	M2=[point3[0]+point2[0],point3[1]+point2[1]]

	M1=[M1[0]/2,M1[1]/2]
	M2=[M2[0]/2,M2[1]/2]
	# print(M1)
	# print(M2)

	#Compute slope
	if (point2[0]-point1[0]) < limit:
		inf_flag_S1 = True
		S1=0
	else:
		S1=-(point2[1]-point1[1])/(point2[0]-point1[0])

	if (point3[0]-point2[0]) < limit:
		inf_flag_S2 = True
		S2=0
	else:
		S2=-(point3[1]-point2[1])/(point3[0]-point2[0])

	# print(S1)
	# print(S2)

	# Compute H1 and H2
	H1=M1[1]-S1*M1[0]
	H2=M2[1]-S2*M2[0]

	# print(H1)
	# print(H2)

	# Compute Inercept
	if abs(S1 - S2) < limit: # making sure the slopes are not too close (parallel danger)
		# print(S1-S2)
		# print('test1')
		return 1000
		
		# continue
	if inf_flag_S1 and inf_flag_S2:
		# print('test2')
		return 1000
		# continue

	if inf_flag_S2:
		Ix = M2[0]
		Iy = M2[0]*S1 + H1
	elif inf_flag_S1:
		Ix = M1[0]
		Iy = M1[0]*S2 + H2		
	else:
		Ix=(H2-H1)/(S1-S2)
		Iy=S1*Ix+H1
	I=[Ix,Iy]

	# print(I)

	#Compute r
	#Distance between intercept and the data

	# r=dist_2_pointsLatLong([I[0],point2[0]],[I[1],point2[1]])

	r=(I[0]-point2[0])**2+(I[1]-point2[1])**2
	r=r**0.5

	return r



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
		diff_1.append(0)
		diff_2.append(0)
	else:
		df1=(data[t,2]-data[t-1,2])/(d_d1[t])
		df2=(data[t,5]-data[t-1,5])/(d_d2[t])

		diff_1.append(df1)
		diff_2.append(df2)



limit=1e-6

pathx=[]
pathy=[]

radius=[]
for t in range(len(data[:,4])):
	if t == 0 or t == len(data[:,4])-1:
		continue

	r=radius_compute([data[t-1,0],data[t-1,1]],[data[t,0],data[t,1]],[data[t+1,0],data[t+1,1]],limit)

	p1x= dist_2_pointsLatLong([data[t-1,0],data[0,0]],[data[0,1],data[0,1]])
	p1y= dist_2_pointsLatLong([data[0,0],data[0,0]],[data[t-1,1],data[0,1]])

	p2x= dist_2_pointsLatLong([data[t,0],data[0,0]],[data[0,1],data[0,1]])
	p2y= dist_2_pointsLatLong([data[0,0],data[0,0]],[data[t,1],data[0,1]])

	p3x= dist_2_pointsLatLong([data[t+1,0],data[0,0]],[data[0,1],data[0,1]])
	p3y= dist_2_pointsLatLong([data[0,0],data[0,0]],[data[t+1,1],data[0,1]])

	r=radius_compute([p1x,p1y],[p2x,p2y],[p3x,p3y],limit)
	# r=radius_compute([data[t-1,0],data[t-1,1]],[data[t,0],data[t,1]],[data[t+1,0],data[t+1,1]],limit)

	radius.append(r)
	

	pathx.append(p2x)	
	pathy.append(p2y)	


# print(len(radius))
plt.plot(distance_1[1:-1],radius)

plt.figure()
plt.plot(pathy,pathx)
plt.show()