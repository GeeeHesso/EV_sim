import matplotlib.pyplot as plt
import numpy as np
import random
import math

def create_profile_simple(point,slope_in,slope_out,max_speed,length):
	#Simplified with simple slopes

	#Initialization
	slope_1=np.zeros(length)
	slope_2=np.zeros(length)
	slope_3=max_speed*np.ones(length)
	profile = np.zeros(length)

	#Create parameters for the slopes
	h_1 = point[1]-slope_in*point[0]
	h_2 = point[1]-slope_out*point[0]

	#Create the slopes(simple lines y=ax+b)
	for i in range(length):
		slope_1[i] = slope_in*i + h_1
		slope_2[i] = slope_out*i + h_2

	#Create the profile
	profile_slope = np.maximum(slope_1,slope_2)  # create the V shape
	profile = np.minimum(profile_slope,slope_3)

	return profile

def create_profile_real(point,acc_in,acc_out,max_speed,length):
	# More accurate accord to the equations of movements

	#Initialization
	slope_1=np.zeros(length)
	slope_1_inv=np.zeros(length)
	slope_2=np.zeros(length)
	slope_3=max_speed*np.ones(length)	

	#According to the equation of motion
	# v(x) = (2ax+v_0**2)**(1/2)
	for i in range(0,point[0]+1):
		slope_1_inv[i] = math.sqrt(2*i*(-acc_in)+point[1]**2) #TODO careful with the negative

	slope_1[0:point[0]+1]=np.flip(slope_1_inv[0:point[0]+1],0)

	for i in range(point[0],length):
		slope_2[i] = math.sqrt(2*(i-point[0])*acc_out+point[1]**2)

	profile_slope = np.maximum(slope_1,slope_2)
	profile = np.minimum(profile_slope,slope_3)
	return profile


length = 1000 #total length of the test
ratio  = 20   #Ratio for noise

speed=22*np.ones(length) # 80km/h

speed[int(length*1/3):int(length*2/3)] = 33 #120 km/h

for i in range(int(length/ratio)):
	speed[ratio*i] -= random.randint(0,10) # random drop up to 36km/h

speed_o=np.array(speed)

acc_in      = -10 #Negative acceleration vehicle loosing speed while braking
acc_out     =  10  #positive acceleration vehicle picking up speed after a braking event
speed_limit =  33

for i in range(length):
	profile = create_profile_real([i,speed[i]],acc_in,acc_out,speed_limit,length)
	speed=np.minimum(speed,profile)

plt.plot(speed_o)
plt.plot(speed)
plt.show()